import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';
import { AuthService } from 'src/app/services/auth.service';
import { take } from 'rxjs/operators';
import { Tag } from 'src/app/models/tag.model';
import { PhotoLinksService } from 'src/app/services/photo-links.service';
import Swal from 'sweetalert2';
import { User } from 'src/app/models/user.model';

@Component({
  selector: 'app-add-photo-link',
  templateUrl: './add-photo-link.component.html',
  styleUrls: ['./add-photo-link.component.css']
})
export class AddPhotoLinkComponent implements OnInit {

  addForm: FormGroup;
  maxDate;
  minDate;
  allSubs: Subscription[] = [];
  tagsList: Tag[] = [];
  adding = false;
  loggedInUser: User;

  constructor(private authService: AuthService, private photoLinkService : PhotoLinksService) { }

  ngOnInit(): void {

    const groupValidator = (group: FormGroup): {[s: string]: boolean} => {
      if(group.value.fromDate > group.value.toDate && group.value.fromDate!=null && 
        group.value.toDate!=null && (this.minDate<=group.value.fromDate<=this.maxDate) && (this.minDate<=group.value.toDate<=this.maxDate)){
        this.addForm.get('fromDate').setErrors({
          fromDateGreater: true
        });
        this.addForm.get('toDate').setErrors({
          fromDateGreater: true
        });
        return {'fromDateGreater': true}
      }else if(group.value.fromDate <= group.value.toDate && group.value.fromDate!=null && 
        group.value.toDate!=null && (this.minDate<=group.value.fromDate<=this.maxDate) && (this.minDate<=group.value.toDate<=this.maxDate)){
        this.addForm.get('fromDate').setErrors(null);
        this.addForm.get('toDate').setErrors(null);
        return null
      }
    };

    this.addForm = new FormGroup({
      event : new FormControl(null,[Validators.required,Validators.minLength(5),Validators.maxLength(35)]),
      fromDate : new FormControl(null,[Validators.required]),
      toDate : new FormControl(null,[Validators.required]),
      photoLink : new FormControl(null,[Validators.required]),
      tags : new FormControl([],[Validators.required])
    },{
      validators: groupValidator
    });

    this.allSubs.push(this.authService.user.pipe(take(1)).subscribe(user => {
      this.loggedInUser = user;
      this.tagsList = user.tags;
      this.maxDate = new Date();
      this.minDate = new Date('1970-01-01T00:00:00');
      }
    ));

  }

  OnTagRemoved(tag : Tag) {
    const tags = this.addForm.value.tags as Tag[];
    this.removeFirst(tags, tag);
    this.addForm.patchValue({
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
    this.adding = true;
    const creationTime = new Date();
    this.allSubs.push(this.photoLinkService.addOrUpdatePhotoLink(
      0,
      this.addForm.value.event,
      this.addForm.value.fromDate,
      this.addForm.value.toDate,
      this.addForm.value.photoLink,
      creationTime,
      this.loggedInUser.userName,
      null,
      null,
      this.addForm.value.tags).subscribe(
        result => {
          this.adding = false;
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "Photo link added Successfully !"
          });
          this.addForm.reset();
        },
        errorMessage => {
          this.adding = false;
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
