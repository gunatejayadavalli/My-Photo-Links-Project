import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { catchError, tap } from 'rxjs/operators';
import { throwError, BehaviorSubject } from 'rxjs';
import { User } from '../models/user.model';
import {AuthData} from '../models/authData.model';
import { Role } from '../models/role.model';
import { Tag } from '../models/tag.model';
import { environment } from 'src/environments/environment';
import Swal from 'sweetalert2';

export interface AuthResponseData {
  userId: number,
  userName: string,
  firstName: string,
  lastName: string,
  email: string,
  blockFlag: string,
  blockReason: string,
  token: string,
  loginDate: Date,
  tokenExpirationDate: Date,
  roles: Role[],
  tags: Tag[]
}

@Injectable({ providedIn: 'root' })
export class AuthService {

  user = new BehaviorSubject<User>(null);
  isAuth = new BehaviorSubject<boolean>(false);
  private tokenExpirationTimer: any;

  constructor(private http: HttpClient, private router: Router) {}

  login(username: string, password: string) {
    return this.http.post<AuthResponseData>(environment.apiUrl+'/authenticate',
      {
        username: username,
        password: password
      }
    )
    .pipe(
      catchError(this.handleError),
      tap(resData => {
        this.handleAuthentication(resData.userId,resData.userName,resData.firstName,resData.lastName,resData.email,
          resData.blockFlag,resData.blockReason,resData.token,resData.loginDate,
          resData.tokenExpirationDate,resData.roles,resData.tags)
      })
    );
  }

  signup(username: string, password: string, firstName: string, lastName: string, email: string, secQues: string, answer: string) {
    return this.http.post(environment.apiUrl+'/registerUser',
      {
        userName: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        email: email,
        securityQues: secQues,
        securityAns: answer,
        blockFlag: "N"
      }
    )
    .pipe(
      catchError(this.handleError)
    );
  }

  logout() {
    this.isAuth.next(false);
    this.user.next(null);
    this.router.navigate(['/login']);
    localStorage.removeItem('authData');
    if (this.tokenExpirationTimer) {
      clearTimeout(this.tokenExpirationTimer);
    }
    this.tokenExpirationTimer = null;
  }

  autoLogin() {
    const authData: {
      userId: number,
      userName: string,
      _token: string,
      loginDate: Date,
      _tokenExpirationDate: Date
    } = JSON.parse(localStorage.getItem('authData'));
    if (!authData) {
      return;
    }else{
      if (authData._token) {
        this.isAuth.next(true);
      }
    }
  }

  refreshUser() {
    const authData: {
      userId: number,
      userName: string,
      _token: string,
      loginDate: Date,
      _tokenExpirationDate: Date
    } = JSON.parse(localStorage.getItem('authData'));
    if (authData._token) {
      return this.http.get<AuthResponseData>(environment.apiUrl+'/refreshUser/'+authData.userName).pipe(
        catchError(this.handleError),
        tap(userDetails => {
        this.handleAuthentication(userDetails.userId,userDetails.userName,userDetails.firstName,userDetails.lastName,userDetails.email,
          userDetails.blockFlag,userDetails.blockReason,authData._token,authData.loginDate,
          authData._tokenExpirationDate,userDetails.roles,userDetails.tags)
      }));
    }
  }

  autoLogout(expirationDuration: number) {
    this.tokenExpirationTimer = setTimeout(() => {
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'Token expired. Please login again !',
        showClass: {
          popup: 'animate__animated animate__rubberBand'
        }
      }).then((result) => {
        this.logout();
      });
    }, expirationDuration);
  }  

  checkUserNameExist(username : string){
    return this.http.get<boolean>(environment.apiUrl+'/checkUserNameExist/'+username).pipe(
      catchError(this.handleError)
    );
  }

  getUserSecQuesForResetPwd(username : string){
    return this.http.get(environment.apiUrl+'/getUserSecQues/'+username, {responseType:'text'}).pipe(
      catchError(this.handleError)
    );
  }

  validateAnswer(username: string, enteredAnswer: string){
    return this.http.post<boolean>(environment.apiUrl+'/validateAnswer',{
      userName: username,
      securityAns: enteredAnswer
    }).pipe(
      catchError(this.handleError)
    );
  }

  resetPassword(username: string, newPassword: string){
    return this.http.post<number>(environment.apiUrl+'/resetPassword',{
      userName: username,
      password: newPassword
    }).pipe(
      catchError(this.handleError)
    );
  }

  private handleAuthentication(
    userId: number,
    userName: string,
    firstName: string,
    lastName: string,
    email: string,
    blockFlag: string,
    blockReason: string,
    token: string,
    loginDate: Date,
    tokenExpirationDate: Date,
    roles: Role[],
    tags: Tag[]
  ) {
    const user = new User(userId,userName,firstName,lastName,email,blockFlag,blockReason,roles,tags);
    const authData = new AuthData(userId,userName,token,loginDate,tokenExpirationDate);
    this.isAuth.next(true);
    this.user.next(user);
    const timeRemaining : number = new Date(tokenExpirationDate).getTime() - new Date().getTime();
    this.autoLogout(timeRemaining);
    localStorage.setItem('authData', JSON.stringify(authData));
  }

  private handleError(errorRes: HttpErrorResponse) {
    let errorMessage = 'Something went wrong !';
    if (!errorRes.error || !errorRes.error.message) {
      return throwError(errorMessage);
    }
    switch (errorRes.error.message) {
      case 'USER_NOT_FOUND':
        errorMessage = 'User doesn\'t exist !';
        break;
      case 'INVALID_PASSWORD':
        errorMessage = 'Password is incorrect !';
        break;
    }
    return throwError(errorMessage);
  }

}
