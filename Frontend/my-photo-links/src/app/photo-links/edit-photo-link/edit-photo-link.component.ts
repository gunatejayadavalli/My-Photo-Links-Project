import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';
import { Tag } from 'src/app/models/tag.model';
import { PhotoLinksService } from 'src/app/services/photo-links.service';
import { PhotoLink } from 'src/app/models/photo-link.model';
import { take } from 'rxjs/operators';
import { AuthService } from 'src/app/services/auth.service';
import Swal from 'sweetalert2';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user.model';

@Component({
  selector: 'app-edit-photo-link',
  templateUrl: './edit-photo-link.component.html',
  styleUrls: ['./edit-photo-link.component.css']
})
export class EditPhotoLinkComponent implements OnInit {

  editForm: FormGroup;
  maxDate;
  minDate;
  allSubs: Subscription[] = [];
  tagsList: Tag[] = [];
  selectedTags: Tag[] = [];
  photoLinkTagIds : number[] = [];
  editing = false;
  editingPhotoLink: PhotoLink;
  photoLinkResults : PhotoLink[];
  loggedInUser : User;

  constructor(private photoLinksService: PhotoLinksService, private authService: AuthService, private router: Router) { }

  ngOnInit(): void {

    const groupValidator = (group: FormGroup): {[s: string]: boolean} => {
      if(group.value.fromDate > group.value.toDate && group.value.fromDate!=null && 
        group.value.toDate!=null && (this.minDate<=group.value.fromDate<=this.maxDate) && (this.minDate<=group.value.toDate<=this.maxDate)){
        this.editForm.get('fromDate').setErrors({
          fromDateGreater: true
        });
        this.editForm.get('toDate').setErrors({
          fromDateGreater: true
        });
        return {'fromDateGreater': true}
      }else if(group.value.fromDate <= group.value.toDate && group.value.fromDate!=null && 
        group.value.toDate!=null && (this.minDate<=group.value.fromDate<=this.maxDate) && (this.minDate<=group.value.toDate<=this.maxDate)){
        this.editForm.get('fromDate').setErrors(null);
        this.editForm.get('toDate').setErrors(null);
        return null
      }
    };

    this.editForm = new FormGroup({
      eventId : new FormControl(),
      event : new FormControl(null,[Validators.required,Validators.minLength(5),Validators.maxLength(35)]),
      fromDate : new FormControl(null,[Validators.required]),
      toDate : new FormControl(null,[Validators.required]),
      photoLink : new FormControl(null,[Validators.required]),
      tags : new FormControl([],[Validators.required])
    },{
      validators: groupValidator
    });

    this.allSubs.push(
      this.photoLinksService.editMode.subscribe(editMode => {
        if(editMode){
          this.allSubs.push(this.authService.user.pipe(take(1)).subscribe(user => {
            this.loggedInUser = user;
            this.tagsList = user.tags;
            this.maxDate = new Date();
            this.minDate = new Date('1970-01-01T00:00:00');
            this.allSubs.push(this.photoLinksService.editingPhotoLink.subscribe(photoLink => {
              if(photoLink){
                this.editingPhotoLink = photoLink;
                photoLink.tags.forEach(tag => {
                  this.photoLinkTagIds.push(tag.tagId);
                })
                this.tagsList.forEach(tag  => {
                  if(this.photoLinkTagIds.indexOf(tag.tagId)!= -1){
                    this.selectedTags.push(tag);
                  }
                })
                this.editForm.patchValue({
                  eventId : photoLink.eventId,
                  event : photoLink.event,
                  fromDate : new Date(photoLink.fromDate),
                  toDate : new Date(photoLink.toDate),
                  photoLink : photoLink.photosLink,
                  tags : this.selectedTags
                });
                this.allSubs.push(this.photoLinksService.photoLinks.subscribe(photoLinksResults => {
                  this.photoLinkResults = photoLinksResults;
                }));
              }
            }));
          }));
        }
      })
    );

  }

  OnTagRemoved(tag : Tag) {
    const tags = this.editForm.value.tags as Tag[];
    this.removeFirst(tags, tag);
    this.editForm.patchValue({
      tags :tags
    })
  }

  private removeFirst<T>(array: T[], toRemove: T): void {
    const index = array.indexOf(toRemove);
    if (index !== -1) {
      array.splice(index, 1);
    }
  }

  OnSubmit(){
    this.editing = true;
    const updationTime = new Date();
    const photoLink:PhotoLink = new PhotoLink(this.editingPhotoLink.eventId,
      this.editForm.value.event,
      this.editForm.value.fromDate,
      this.editForm.value.toDate,
      this.editForm.value.photoLink,
      this.editingPhotoLink.creationTime,
      this.editingPhotoLink.createdBy,
      updationTime,
      this.loggedInUser.userName,
      this.editForm.value.tags);

    this.allSubs.push(this.photoLinksService.addOrUpdatePhotoLink(
      this.editingPhotoLink.eventId,
      this.editForm.value.event,
      this.editForm.value.fromDate,
      this.editForm.value.toDate,
      this.editForm.value.photoLink,
      this.editingPhotoLink.creationTime,
      this.editingPhotoLink.createdBy,
      updationTime,
      this.loggedInUser.userName,
      this.editForm.value.tags).subscribe(
        result => {
          this.editing = false;
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "Photo link edited Successfully !"
          }).then(result=>{
            this.editForm.reset();
            this.photoLinksService.editMode.next(false);
            this.photoLinksService.editingPhotoLink.next(null);
            const index = this.photoLinkResults.indexOf(this.editingPhotoLink);
            this.photoLinkResults[index]=photoLink;
            this.photoLinkTagIds=[];
            this.selectedTags=[];
            photoLink.tags.forEach(tag => {
              this.photoLinkTagIds.push(tag.tagId);
            })
            this.tagsList.forEach(tag  => {
              if(this.photoLinkTagIds.indexOf(tag.tagId)!= -1){
                this.selectedTags.push(tag);
              }
            })
            this.photoLinksService.photoLinks.next(this.photoLinkResults);
            this.editingPhotoLink = photoLink;
            this.router.navigate(['/results']);
          })
        },
        errorMessage => {
          this.editing = false;
          Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: errorMessage,
            showClass: {
              popup: 'animate__animated animate__shakeX'
            }
          });
        }
      )
    );
  }

}
