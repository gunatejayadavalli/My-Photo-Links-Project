import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';
import { FeedbackService } from 'src/app/services/feedback.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-give-feedback',
  templateUrl: './give-feedback.component.html',
  styleUrls: ['./give-feedback.component.css']
})
export class GiveFeedbackComponent implements OnInit {

  userId:number;
  username:string;
  feedbackFormGroup : FormGroup;
  isSubmitting = false;
  allSubs:Subscription[] = [];

  constructor(private feedbackService : FeedbackService) { }

  ngOnInit(): void {

    const authData: {
      userId: number,
      userName: string,
    } = JSON.parse(localStorage.getItem('authData'));
    if(authData!=null){
      this.userId=authData.userId;
      this.username=authData.userName;
    }

    this.feedbackFormGroup = new FormGroup({
      feedbackType : new FormControl('',[Validators.required]),
      feedbackMsg : new FormControl('',[Validators.required, Validators.minLength(15), Validators.maxLength(300)])
    });

  }

  OnSubmit(){
    console.log('this.feedbackFormGroup.value.feedbackType : '+this.feedbackFormGroup.value.feedbackType);
    this.isSubmitting = true;
    this.allSubs.push(this.feedbackService.submitFeedback(
      this.userId,
      this.feedbackFormGroup.value.feedbackType,
      this.feedbackFormGroup.value.feedbackMsg,
      this.username).subscribe(result => {
        this.isSubmitting = false;
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: "Feedback submitted Successfully !"
        }).then(result => {
          this.feedbackFormGroup.reset();
        });
      },errorMessage => {
        this.isSubmitting = false;
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

}
