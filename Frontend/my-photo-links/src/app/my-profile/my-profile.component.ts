import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { User } from '../models/user.model';
import { HttpClient } from '@angular/common/http';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-my-profile',
  templateUrl: './my-profile.component.html',
  styleUrls: ['./my-profile.component.css']
})
export class MyProfileComponent implements OnInit, OnDestroy {

  allSubs: Subscription[] = [];
  loggedInUser : User;
  userFormGroup : FormGroup;
  editPassword = false;
  editProfile = false;
  secQuesAns = '';
  updatingUser = false;

  constructor(private route: ActivatedRoute, private authService: AuthService, private http : HttpClient, private router: Router) { }

  ngOnInit(): void {

    const groupValidator = (group: FormGroup): {[s: string]: boolean} => {

      if(this.editPassword){
        if(group.value.password === null || (group.value.password!=null && group.value.password.length<8)){
          group.get('password').setErrors({
            minLength: true
          });
        }
        if(group.value.password !== group.value.confirmPassword){
          group.get('confirmPassword').setErrors({
            mismatch: true
          });
          return {'mismatch': true}
        }else{
          group.get('confirmPassword').setErrors(null);
          return null
        }
      }
      return null;
    };

    this.userFormGroup = new FormGroup({
      firstName: new FormControl({value: ''}, Validators.required),
      lastName: new FormControl({value: ''}, Validators.required),
      email: new FormControl({value: ''}, [Validators.required,Validators.email]),
      secQues: new FormControl({value: ''}, [Validators.required,Validators.minLength(5),Validators.maxLength(50)]),
      answer: new FormControl({value: ''}, Validators.required),
      password: new FormControl({value: ''}),
      confirmPassword: new FormControl({value: ''})
    },{
      validators: groupValidator
    });

    this.allSubs.push(this.route.data.subscribe(data => {
      this.loggedInUser = data.user;
      this.authService.user.next(this.loggedInUser);
      this.allSubs.push(this.authService.getSecQuesAnswer(data.user.userName).subscribe(answer => {
        this.secQuesAns = answer;
        this.userFormGroup.patchValue({
          firstName : data.user.firstName,
          lastName : data.user.lastName,
          email: data.user.emailId,
          secQues: data.user.secQues,
          answer: answer,
          password: null,
          confirmPassword: null
        })
      }));
    }));

  }

  OnSubmit(){
    this.updatingUser=true;
    this.allSubs.push(
      this.authService.updateUserProfile(this.loggedInUser.userId,this.loggedInUser.userName,this.userFormGroup.value.password
        ,this.userFormGroup.value.firstName,this.userFormGroup.value.lastName,this.userFormGroup.value.email
        ,this.userFormGroup.value.secQues,this.userFormGroup.value.answer).subscribe(res=>{
          if(res){
            this.updatingUser=false;
            Swal.fire({
              icon: 'success',
              title: 'Success',
              text: 'Profile updated Successfully !',
            }).then((result) => {
              window.location.reload();
            });
          }
        },
        errorMessage => {
          this.updatingUser = false;
          Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: errorMessage,
            showClass: {
              popup: 'animate__animated animate__shakeX'
            }
          });
        })
    );
  }

  onEditProfile(){
    this.editProfile = !this.editProfile;
  }

  enableEditPassword(){
    this.editPassword = true;
  }

  onCancelEdit(){
    if(this.editProfile){
      this.editProfile = false;
    }
    if(this.editPassword){
      this.editPassword = false;
    }
    this.userFormGroup.patchValue({
      firstName : this.loggedInUser.firstName,
      lastName : this.loggedInUser.lastName,
      email: this.loggedInUser.emailId,
      secQues: this.loggedInUser.secQues,
      answer: this.secQuesAns,
      password : null,
      confirmPassword : null
    })
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
