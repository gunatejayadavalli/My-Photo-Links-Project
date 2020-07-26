import { Component, OnInit, OnDestroy } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthService, AuthResponseData } from '../../services/auth.service';
import { Observable, Subscription } from 'rxjs';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit,OnDestroy {

  loginForm: FormGroup;
  isLoading = false;
  allSubs: Subscription[] = [];


  constructor(private authservice: AuthService, private router : Router) { }

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      username : new FormControl('',[Validators.required]),
      password : new FormControl('',[Validators.required])
    });
  }

  OnSubmit(){
    this.isLoading = true;
    let authObs: Observable<AuthResponseData>;
    authObs = this.authservice.login(this.loginForm.value.username, this.loginForm.value.password);
    this.allSubs.push(authObs.subscribe(
      resData => {
        this.isLoading = false;
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'Login success !',
          showClass: {
            popup: 'animate__animated animate__flip'
          }
        }).then((result) => {
          this.router.navigate(['/photoLinks']);
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
