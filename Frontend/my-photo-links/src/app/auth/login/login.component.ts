import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { AuthService, AuthResponseData } from '../auth.service';
import { Observable } from 'rxjs';
import { Router } from '@angular/router';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginForm: FormGroup;
  isLoading = false;


  constructor(private authservice: AuthService, private router : Router, private snackBar: MatSnackBar) { }

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
    authObs.subscribe(
      resData => {
        this.isLoading = false;
        this.snackBar.open('Login Success !!', null, {
          duration: 2000
        })
        this.router.navigate(['/photoLinks']);
      },
      errorMessage => {
        this.isLoading = false;
        this.snackBar.open('Login Failed !!', null, {
          duration: 2000
        })
      }
    );
  }

}
