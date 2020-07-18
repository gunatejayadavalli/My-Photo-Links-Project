import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { catchError, tap, map } from 'rxjs/operators';
import { throwError, BehaviorSubject } from 'rxjs';
import { User } from './user.model';
import { Role } from './role.model';
import { Tag } from './tag.model';
import { environment } from 'src/environments/environment';

export interface AuthResponseData {
  userId: number,
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
        this.handleAuthentication(resData.userId,resData.firstName,resData.lastName,resData.email,
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
    this.user.next(null);
    this.router.navigate(['/login']);
    localStorage.removeItem('userData');
    if (this.tokenExpirationTimer) {
      clearTimeout(this.tokenExpirationTimer);
    }
    this.tokenExpirationTimer = null;
  }

  autoLogin() {
    const userData: {
      userId: number,
      firstName: string,
      lastName: string,
      email: string,
      blockFlag: string,
      blockReason: string,
      _token: string,
      loginDate: Date,
      _tokenExpirationDate: Date,
      roles: Role[],
      tags: Tag[]
    } = JSON.parse(localStorage.getItem('userData'));
    if (!userData) {
      return;
    }
    const loadedUser = new User(userData.userId,userData.firstName,userData.lastName,userData.email,
      userData.blockFlag,userData.blockReason,userData._token,userData.loginDate,
      userData._tokenExpirationDate,userData.roles,userData.tags)
    if (loadedUser.token) {
      this.user.next(loadedUser);
      const expirationDuration = new Date(userData._tokenExpirationDate).getTime() - new Date().getTime();
      this.autoLogout(expirationDuration);
    }
  }

  autoLogout(expirationDuration: number) {
    this.tokenExpirationTimer = setTimeout(() => {
      this.logout();
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
    const user = new User(userId,firstName,lastName,email,blockFlag,blockReason,token,loginDate,tokenExpirationDate,roles,tags);
    this.user.next(user);
    const timeRemaining : number = new Date(tokenExpirationDate).getTime() - new Date().getTime();
    this.autoLogout(timeRemaining);
    localStorage.setItem('userData', JSON.stringify(user));
  }

  private handleError(errorRes: HttpErrorResponse) {
    let errorMessage = 'An unknown error occurred!';
    if (!errorRes.error || !errorRes.error.message) {
      return throwError(errorMessage);
    }
    switch (errorRes.error.message) {
      case 'USER_NOT_FOUND':
        errorMessage = 'User doesn\'t exist !!';
        break;
      case 'INVALID_PASSWORD':
        errorMessage = 'Password is incorrect !!';
        break;
    }
    return throwError(errorMessage);
  }

}
