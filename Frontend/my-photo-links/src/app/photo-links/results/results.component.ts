import { Component, OnInit } from '@angular/core';
import { PhotoLink } from '../../models/photo-link.model';
import { PhotoLinksService } from '../../services/photo-links.service';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';
import { DatePipe } from '@angular/common';
import Swal from 'sweetalert2';
import { User } from 'src/app/models/user.model';
import { AuthService } from 'src/app/services/auth.service';
import { take } from 'rxjs/operators';

@Component({
  selector: 'app-results',
  templateUrl: './results.component.html',
  styleUrls: ['./results.component.css']
})
export class ResultsComponent implements OnInit {

  photoLinkResults : PhotoLink[] = null;
  allSubs: Subscription[] = [];
  resultMode = false;
  editMode = false;
  loggedInUser : User;
  isSuperAdmin = false;
  isAdmin = false;
  userTags: number[] = [];

  constructor(private authService : AuthService, private photoLinksService : PhotoLinksService, private router: Router, private datePipe: DatePipe) { }

  ngOnInit(): void {

    this.allSubs.push(this.authService.user.pipe(take(1)).subscribe(user => {
      if(user){
        this.loggedInUser = user;
      user.tags.forEach(tag => {
        this.userTags.push(tag.tagId);
      });
      user.roles.forEach(role => {
        if(role.roleName === 'ROLE_SUPERADMIN'){
          this.isSuperAdmin = true;
        }
        if(role.roleName === 'ROLE_ADMIN'){
          this.isAdmin = true;
        }
      })
      }
      }
    ));

    this.allSubs.push(
      this.photoLinksService.resultsMode.subscribe(resultMode => {
        if(resultMode){
          this.resultMode = true;
          this.allSubs.push(this.photoLinksService.photoLinks.subscribe(photoLinks => {
            this.photoLinkResults = photoLinks;
          }));
        }else{
          this.router.navigate(['/photoLinks']);
        }
      })
    );
    this.allSubs.push(
      this.photoLinksService.editMode.subscribe(editMode => {
          this.editMode = editMode;
      })
    );
  }

  OnEdit(photoLink : PhotoLink){
    let canBeEdited = true;
    photoLink.tags.forEach(tag => {
      if(this.userTags.indexOf(tag.tagId)==-1){
        canBeEdited = false;
      }
    });
    if(canBeEdited && (this.isSuperAdmin || this.isAdmin)){
    this.photoLinksService.editMode.next(true);
    this.photoLinksService.editingPhotoLink.next(photoLink);
    this.editMode = true;
    }else{
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: "You are not allowed to edit this !",
        showClass: {
          popup: 'animate__animated animate__shakeX'
        }
      });      
    }
  }

  OnDelete(photoLink : PhotoLink){
    let canBeDeleted = true;
    photoLink.tags.forEach(tag => {
      if(this.userTags.indexOf(tag.tagId)==-1){
        canBeDeleted = false;
      }
    });
    if(canBeDeleted && (this.isSuperAdmin || this.isAdmin)){
      Swal.fire({
        title: 'Confirm',
        text: "Delete this photo link ?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'red',
        cancelButtonColor: 'blue',
        confirmButtonText: 'Yes',
        cancelButtonText:'No'
      }).then((result) => {
        if (result.value) {
          this.allSubs.push(this.photoLinksService.deletePhotoLink(photoLink.eventId).subscribe(result => {
            Swal.fire({
              icon: 'success',
              title: 'Success',
              text: "Photo link deleted Successfully !"
            });
            const index = this.photoLinkResults.indexOf(photoLink);
            this.photoLinkResults.splice(index,1);
            this.photoLinksService.photoLinks.next(this.photoLinkResults);
          },
          errorMessage => {
            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: errorMessage,
              showClass: {
                popup: 'animate__animated animate__shakeX'
              }
            });
          }));
        }
      })
    }else{
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: "You are not allowed to delete this !",
        showClass: {
          popup: 'animate__animated animate__shakeX'
        }
      });
    }
  }

  shareLink(photoLink : PhotoLink){
    const link="whatsapp://send?text=*Event%20Name%20%3A*%20"+encodeURIComponent(photoLink.event)+"%0A*Event%20Date%20%3A*%20"+this.datePipe.transform(photoLink.fromDate,"MMM dd, yyyy")+"%20-%20"+this.datePipe.transform(photoLink.toDate,"MMM dd, yyyy")+"%0A%0A*Link%20%3A*%20"+photoLink.photosLink;
    window.open(link, "_blank");
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
