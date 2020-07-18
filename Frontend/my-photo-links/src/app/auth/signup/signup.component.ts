import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthService } from '../auth.service';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  isUsernameValidating = false;
  userNameFormgroup: FormGroup;
  passwordFormGroup: FormGroup;
  userDetailsFormGroup: FormGroup;
  secQuesAnsFormGroup: FormGroup;
  isLoading= false;

  constructor(private authService : AuthService, private router : Router, private snackBar: MatSnackBar) {}

  ngOnInit() {

    this.userNameFormgroup = new FormGroup({
      username: new FormControl('', [Validators.required,Validators.minLength(4)])
    });

    this.passwordFormGroup = new FormGroup({
      password: new FormControl('', [Validators.required,Validators.minLength(8)]),
      confirmPassword: new FormControl('',Validators.required)
    });

    this.userDetailsFormGroup = new FormGroup({
      firstName: new FormControl('', Validators.required),
      lastName: new FormControl('', Validators.required),
      email: new FormControl('', [Validators.required,Validators.email])
    });

    this.secQuesAnsFormGroup = new FormGroup({
      secQues: new FormControl('', [Validators.required,Validators.minLength(5),Validators.maxLength(50)]),
      answer: new FormControl('', Validators.required)
    });

  }

  validateUserName(){
    this.isUsernameValidating = true;
    this.authService.checkUserNameExist(this.userNameFormgroup.value.username).subscribe(resData => {
      if(resData){
        this.userNameFormgroup.get('username').setErrors({
          notUnique: true
        });
      }else{
        this.userNameFormgroup.setErrors(null);
        this.userNameFormgroup.get('username').setErrors(null);
      }
      this.isUsernameValidating = false;
    });
  }

  onKeyUsername(){
    this.userNameFormgroup.setErrors({
      modified: true
    });
  }

  onKeyPassword(){
    if(this.passwordFormGroup.value.password !== this.passwordFormGroup.value.confirmPassword){
      this.passwordFormGroup.get('confirmPassword').setErrors({
        mismatch: true
      });
    }else{
      this.passwordFormGroup.get('confirmPassword').setErrors(null);
    }
  }

  OnSubmit(){
    this.isLoading = true;
    this.authService.signup(
      this.userNameFormgroup.value.username,
      this.passwordFormGroup.value.password,
      this.userDetailsFormGroup.value.firstName,
      this.userDetailsFormGroup.value.lastName,
      this.userDetailsFormGroup.value.email,
      this.secQuesAnsFormGroup.value.secQues,
      this.secQuesAnsFormGroup.value.answer
    ).subscribe(
      resData => {
        this.isLoading = false;
        this.snackBar.open('Registration Success. Please Login', null, {
          duration: 2000
        })
        this.router.navigate(['/login']);
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
