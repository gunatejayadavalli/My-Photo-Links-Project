import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { User } from 'src/app/models/user.model';
import { Tag } from 'src/app/models/tag.model';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { ManageUsersService } from 'src/app/services/manage-users.service';
import { HttpClient } from '@angular/common/http';
import Swal from 'sweetalert2';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-manage-tags',
  templateUrl: './manage-tags.component.html',
  styleUrls: ['./manage-tags.component.css']
})
export class ManageTagsComponent implements OnInit,OnDestroy {

  allSubs:Subscription[] = [];
  loggedInUser: User;
  isSuperAdmin = false;
  allTags: Tag[] = [];

  constructor(private route: ActivatedRoute, private authService: AuthService, 
    private manageUsersService : ManageUsersService, private http : HttpClient, private router: Router) { }

    ngOnInit(): void {

      this.allSubs.push(this.route.data.subscribe(data => {
        this.loggedInUser = data.user;
        data.user.roles.forEach(role => {
          if(role.roleName === 'ROLE_SUPERADMIN'){
            this.isSuperAdmin = true;
          }
        })
        this.authService.user.next(this.loggedInUser);
      }));

      if(this.isSuperAdmin){
        this.getTags();
      }
  
    }
  
    getTags(){
      this.allSubs.push(
        this.manageUsersService.getAllTags().subscribe(tags => {
          this.allTags = tags;
          if(this.allTags.length==0){
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'No tags found !'
            }).then(result => {
              this.router.navigate(['/photoLinks'])
            });
          }
        })
      );
    }

    addTag(tag : Tag){

      Swal.fire({
        title: 'Create tag',
        input: 'text',
        inputPlaceholder: 'Enter tag name',
        inputValidator: (value) => {
          return !value && 'Must input tag name'
        },
        showCancelButton: true,
        confirmButtonText: 'Add',
        showLoaderOnConfirm: true,
        preConfirm: (tagName) => {
          return this.http.post<boolean>(environment.apiUrl+'/addUpdateTag',{
            tagId: 0,
            tagName:tagName,
            createdBy:this.loggedInUser.userName
          }).subscribe(res => {

            },error => {
                Swal.showValidationMessage(
                  `Request failed: ${error}`
                )
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        if (result.value) {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "Tag added Successfully !"
          }).then(result => {
            this.getTags();
          });
        }
      })
    }

    updateTag(tag : Tag){
      
      Swal.fire({
        title: 'Modify tag',
        input: 'text',
        inputPlaceholder: 'Enter tag name',
        inputValue:tag.tagName,
        inputValidator: (value) => {
          return !value && 'Must input tag name'
        },
        showCancelButton: true,
        confirmButtonText: 'Save',
        showLoaderOnConfirm: true,
        preConfirm: (tagName) => {
          return this.http.post<boolean>(environment.apiUrl+'/addUpdateTag',{
            tagId: tag.tagId,
            tagName:tagName,
            createdBy:tag.createdBy,
            creationTime:tag.creationTime,
            updatedBy:this.loggedInUser.userName
          }).subscribe(res => {

            },error => {
                Swal.showValidationMessage(
                  `Request failed: ${error}`
                )
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        if (result.value) {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "Tag updated Successfully !"
          }).then(result => {
            this.getTags();
          });
        }
      })

    }

    deleteTag(tag : Tag){
      Swal.fire({
        title: 'Confirm',
        text: "Are you sure want to delete this Tag ?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Confirm',
        showLoaderOnConfirm: true,
        preConfirm: (reason) => {
          return this.http.get<boolean>(environment.apiUrl+'/deleteTag/'+tag.tagId).subscribe(res => {

          },error => {
              Swal.showValidationMessage(
                `Request failed: ${error}`
              )
          });
        },
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        if (result.value) {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "Tag deleted Successfully !"
          }).then(result => {
            this.getTags();
          });
        }
      })
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

}
