import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit,OnDestroy {

  isUsernameValidating = false;
  userNameFormgroup: FormGroup;
  passwordFormGroup: FormGroup;
  userDetailsFormGroup: FormGroup;
  secQuesAnsFormGroup: FormGroup;
  isLoading= false;
  allSubs: Subscription[] = [];

  constructor(private authService : AuthService, private router : Router) {}

  ngOnInit() {

    this.userNameFormgroup = new FormGroup({
      username: new FormControl('', [Validators.required,Validators.minLength(4),Validators.pattern(/^[a-zA-Z0-9]*$/)])
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
    this.allSubs.push(this.authService.checkUserNameExist(this.userNameFormgroup.value.username).subscribe(resData => {
      if(resData){
        this.userNameFormgroup.get('username').setErrors({
          notUnique: true
        });
      }else{
        this.userNameFormgroup.setErrors(null);
        this.userNameFormgroup.get('username').setErrors(null);
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
    this.allSubs.push(this.authService.signup(
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
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'Registration success. Please login !',
          showClass: {
            popup: 'animate__animated animate__flip'
          }
        }).then((result) => {
          this.router.navigate(['/login']);
        });
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
