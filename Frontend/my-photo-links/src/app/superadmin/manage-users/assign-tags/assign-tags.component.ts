import { Component, OnInit } from '@angular/core';
import { ManageUsersService } from 'src/app/services/manage-users.service';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { Tag } from 'src/app/models/tag.model';
import { User } from 'src/app/models/user.model';
import Swal from 'sweetalert2';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { take } from 'rxjs/operators';

@Component({
  selector: 'app-assign-tags',
  templateUrl: './assign-tags.component.html',
  styleUrls: ['./assign-tags.component.css']
})
export class AssignTagsComponent implements OnInit {

  allSubs : Subscription[] = [];
  allAvailableTags : Tag[] = [];
  assignTagsUser : User = null;
  hasTags : boolean = false;
  userTagIds : number[] = [];
  selectedTags: Tag[] = [];
  assignTagsFormGroup: FormGroup;
  loading = false;

  constructor(private manageUsersService : ManageUsersService, private router : Router) { }

  ngOnInit(): void {

    this.userTagIds = [];
    this.selectedTags  = [];

    this.allSubs.push(
      this.manageUsersService.assignTagsUser.pipe(take(1)).subscribe(user => {
        this.assignTagsUser = user;
        if(user){
          this.allSubs.push(
            this.manageUsersService.allAvailableTags.pipe(take(1)).subscribe(tags => {
              this.allAvailableTags = tags;
              if(!this.assignTagsUser || this.allAvailableTags.length == 0){
                Swal.fire({
                  icon: 'error',
                  title: 'Oops...',
                  text: 'User invalid or No tags available to assign !',
                  showClass: {
                    popup: 'animate__animated animate__shakeX'
                  }
                }).then(result => {
                  this.router.navigate(['/manageUsers']);
                })
              }else{

                this.assignTagsFormGroup = new FormGroup({
                  tags : new FormControl([])
                });

                if(this.assignTagsUser.tags.length>0){
                  this.hasTags = true;

                  this.assignTagsUser.tags.forEach(tag => {
                    this.userTagIds.push(tag.tagId);
                  })

                  this.allAvailableTags.forEach(tag  => {
                    if(this.userTagIds.indexOf(tag.tagId)!= -1){
                      this.selectedTags.push(tag);
                    }
                  })

                  this.assignTagsFormGroup.patchValue({
                    tags : this.selectedTags
                  })

                }else{
                  this.hasTags = false;
                }
              }
            })
          );
        }else{
          this.router.navigate(['/manageUsers']);
        }
      })
    );

  }

  OnTagRemoved(tag : Tag) {
    const tags = this.assignTagsFormGroup.value.tags as Tag[];
    this.removeFirst(tags, tag);
    this.assignTagsFormGroup.patchValue({
      tags :tags
    })
  }

  private removeFirst<T>(array: T[], toRemove: T): void {
    const index = array.indexOf(toRemove);
    if (index !== -1) {
      array.splice(index, 1);
    }
  }

  OnBackToManageUsers(){
    this.manageUsersService.assignTagsUser.next(null);
    this.manageUsersService.allAvailableTags.next([]);
    this.router.navigate(['/manageUsers']);
  }

  ngOnDestroy(){
    if(this.allSubs.length>0){
      this.allSubs.forEach(sub => {
        if(sub){
          sub.unsubscribe();
        }
      });
    }
  }

  OnSubmit(){
    this.loading=true;
    this.allSubs.push(
      this.manageUsersService.modifyUserTags(
        this.assignTagsUser.userId,
        this.hasTags,
        this.assignTagsFormGroup.value.tags
      ).subscribe(result => {
        this.loading=false;
        this.manageUsersService.assignTagsUser.next(null);
        this.manageUsersService.allAvailableTags.next([]);
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: "Tags modified Successfully !"
        }).then(result => {
          this.router.navigate(['/manageUsers']);
        });
      },
      errorMessage => {
        this.loading = false;
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: errorMessage,
          showClass: {
            popup: 'animate__animated animate__shakeX'
          }
        }).then(result => {
          this.manageUsersService.assignTagsUser.next(null);
          this.manageUsersService.allAvailableTags.next([]);
          this.router.navigate(['/manageUsers']);
        });
      })
    );
  }

}
