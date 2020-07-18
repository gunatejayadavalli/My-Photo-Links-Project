import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-forget-password',
  templateUrl: './forget-password.component.html',
  styleUrls: ['./forget-password.component.css']
})
export class ForgetPasswordComponent implements OnInit {


  isUsernameValidating = false;
  isAnswerValidating = false;
  userNameFormgroup: FormGroup;
  secQuesAnsFormGroup: FormGroup;
  passwordResetGroup: FormGroup;
  isLoading= false;

  constructor(private authService : AuthService, private router : Router, private snackBar: MatSnackBar) {}

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
    this.authService.getUserSecQuesForResetPwd(this.userNameFormgroup.value.username).subscribe(resData => {
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
    });
  }

  validateAnswer(){
    this.isAnswerValidating = true;
    this.authService.validateAnswer(this.userNameFormgroup.value.username, this.secQuesAnsFormGroup.value.answer).subscribe(resData => {
      if(resData){
        this.secQuesAnsFormGroup.setErrors(null);
        this.secQuesAnsFormGroup.get('answer').setErrors(null);
      }else{
        this.secQuesAnsFormGroup.get('answer').setErrors({
          wrongAnswer : true
        });
      }
      this.isAnswerValidating = false;
    });
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
    this.authService.resetPassword(
      this.userNameFormgroup.value.username,
      this.passwordResetGroup.value.password
    ).subscribe(
      resData => {
        if(resData===1){
          this.isLoading = false;
          this.snackBar.open('Password updated. Please Login', null, {
            duration: 2000
          })
          this.router.navigate(['/login']);
        }
      },
      errorMessage => {
        this.isLoading = false;
        this.snackBar.open(errorMessage, null, {
          duration: 2000
        })
      }
    );

  }

}
