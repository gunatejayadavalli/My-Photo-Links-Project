import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-forget-password',
  templateUrl: './forget-password.component.html',
  styleUrls: ['./forget-password.component.css']
})
export class ForgetPasswordComponent implements OnInit,OnDestroy {


  isUsernameValidating = false;
  isAnswerValidating = false;
  userNameFormgroup: FormGroup;
  secQuesAnsFormGroup: FormGroup;
  passwordResetGroup: FormGroup;
  isLoading= false;
  allSubs : Subscription[] = [];

  constructor(private authService : AuthService, private router : Router) {}

  ngOnInit() {

    this.userNameFormgroup = new FormGroup({
      username: new FormControl('', [Validators.required,Validators.minLength(4)])
    });

    this.secQuesAnsFormGroup = new FormGroup({
      secQues: new FormControl(''),
      answer: new FormControl('', Validators.required)
    });

    this.passwordResetGroup = new FormGroup({
      password: new FormControl('', [Validators.required,Validators.minLength(8)]),
      confirmPassword: new FormControl('',Validators.required)
    });

  }

  getUserSecQues(){
    this.isUsernameValidating = true;
    this.allSubs.push(this.authService.getUserSecQuesForResetPwd(this.userNameFormgroup.value.username).subscribe(resData => {
      if(resData!="USER_DONT_EXIST"){
        this.userNameFormgroup.setErrors(null);
        this.userNameFormgroup.get('username').setErrors(null);
        this.secQuesAnsFormGroup.patchValue({
          secQues: resData,
          answer: null
        })
      }else{
        this.userNameFormgroup.get('username').setErrors({
          userNotExist : true 
        });
      }
      this.isUsernameValidating = false;
    },
    errorMessage => {
      this.isUsernameValidating = false;
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

  validateAnswer(){
    this.isAnswerValidating = true;
    this.allSubs.push(this.authService.validateAnswer(this.userNameFormgroup.value.username, this.secQuesAnsFormGroup.value.answer).subscribe(resData => {
      if(resData){
        this.secQuesAnsFormGroup.setErrors(null);
        this.secQuesAnsFormGroup.get('answer').setErrors(null);
      }else{
        this.secQuesAnsFormGroup.get('answer').setErrors({
          wrongAnswer : true
        });
      }
      this.isAnswerValidating = false;
    },
    errorMessage => {
      this.isAnswerValidating = false;
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

  onKeyUsername(){
    this.userNameFormgroup.setErrors({
      modified: true
    });
  }

  onKeyAnswer(){
    this.secQuesAnsFormGroup.setErrors({
      modifiedAnswer: true
    });
  }

  onKeyPassword(){
    if(this.passwordResetGroup.value.password !== this.passwordResetGroup.value.confirmPassword){
      this.passwordResetGroup.get('confirmPassword').setErrors({
        mismatch: true
      });
    }else{
      this.passwordResetGroup.get('confirmPassword').setErrors(null);
    }
  }

  OnSubmit(){
    this.isLoading = true;
    this.allSubs.push(this.authService.resetPassword(
      this.userNameFormgroup.value.username,
      this.passwordResetGroup.value.password
    ).subscribe(
      resData => {
        if(resData===1){
          this.isLoading = false;
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: 'Password updated. Please login !',
            showClass: {
              popup: 'animate__animated animate__flip'
            }
          }).then((result) => {
            this.router.navigate(['/login']);
          });
        }
      },
      errorMessage => {
        this.isLoading = false;
        Swal.fire({
          icon: 'error',
          title: 'Oops...',
          text: errorMessage,
          showClass: {
            popup: 'animate__animated animate__shakeX'
          }
        });
      }
    ));

  }

  ngOnDestroy(){
    if(this.allSubs.length>0){
      this.allSubs.forEach(sub => {
        if(sub){
          sub.unsubscribe();
        }
      })
    }
  }

}
