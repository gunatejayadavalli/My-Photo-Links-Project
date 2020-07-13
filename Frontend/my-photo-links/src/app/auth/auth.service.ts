import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Router } from '@angular/router';
import { catchError, tap } from 'rxjs/operators';
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

  logout() {
    this.user.next(null);
    this.router.navigate(['/login']);
    localStorage.removeItem('userData');
    if (this.tokenExpirationTimer) {
      clearTimeout(this.tokenExpirationTimer);
    }
    this.tokenExpirationTimer = null;
  }

  autoLogout(expirationDuration: number) {
    this.tokenExpirationTimer = setTimeout(() => {
      this.logout();
    }, expirationDuration);
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
    return throwError("Error Occured");
  }

}
