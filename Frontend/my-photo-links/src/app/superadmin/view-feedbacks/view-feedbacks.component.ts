import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { User } from 'src/app/models/user.model';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { HttpClient } from '@angular/common/http';
import {Feedback} from '../../models/feedback.model';
import { FeedbackService } from 'src/app/services/feedback.service';
import Swal from 'sweetalert2';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-view-feedbacks',
  templateUrl: './view-feedbacks.component.html',
  styleUrls: ['./view-feedbacks.component.css']
})
export class ViewFeedbacksComponent implements OnInit,OnDestroy {

  allSubs:Subscription[] = [];
  loggedInUser: User;
  isSuperAdmin = false;
  allFeedbacks:Feedback[] = [];

  constructor(private route: ActivatedRoute, private authService: AuthService, 
    private feedbackService : FeedbackService, private http : HttpClient, private router: Router) { }

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
      this.getFeedbacks();
    }

  }

  getFeedbacks(){
    this.allSubs.push(
      this.feedbackService.getAllFeedbacks().subscribe(feedbacks=>{
        this.allFeedbacks = feedbacks;
        if(this.allFeedbacks.length==0){
          Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'No feedback messages found !'
          }).then(result => {
            this.router.navigate(['/photoLinks'])
          });
        }
      })
    );
  }

  markAsRead(feedback:Feedback){

    Swal.fire({
      title: 'Message',
      text: feedback.feedbackMsg,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Mark read',
      showLoaderOnConfirm: true,
      preConfirm: (reason) => {
        return this.http.put(environment.apiUrl+'/feedbacks/'+feedback.feedbackId,{
          userId:feedback.userId,
          feedbackType:feedback.feedbackType,
          feedbackMsg:feedback.feedbackMsg,
          submittedDate:feedback.submittedDate,
          submittedBy:feedback.submittedBy,
          readDate: new Date(),
          readBy: this.loggedInUser.userName
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
          text: "Marked as read !"
        }).then(result => {
          this.getFeedbacks();
        });
      }
    })

  }

  viewFeedbackMessage(feedback:Feedback){
    Swal.fire(
      'Message',
      feedback.feedbackMsg,
      'info'
    )
  }

  markAsResolved(feedback:Feedback){
    Swal.fire({
      title: 'Resolution',
      input: 'text',
      inputPlaceholder: 'Enter resolution message',
      inputValidator: (value) => {
        return !value && 'Must input message'
      },
      showCancelButton: true,
      confirmButtonText: 'Submit',
      showLoaderOnConfirm: true,
      preConfirm: (message) => {
        return this.http.put(environment.apiUrl+'/feedbacks/'+feedback.feedbackId,{
          userId:feedback.userId,
          feedbackType:feedback.feedbackType,
          feedbackMsg:feedback.feedbackMsg,
          submittedDate:feedback.submittedDate,
          submittedBy:feedback.submittedBy,
          readDate: feedback.readDate,
          readBy: feedback.readBy,
          resolvedDate:new Date(),
          resolvedBy:this.loggedInUser.userName,
          resolutionMsg:message
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
          text: "Marked as resolved !"
        }).then(result => {
          this.getFeedbacks();
        });
      }
    });
  }

  viewResolutionMessage(feedback:Feedback){
    Swal.fire(
      'Resolution',
      feedback.resolutionMsg,
      'info'
    )
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
