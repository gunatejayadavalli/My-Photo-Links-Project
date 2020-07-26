import { Injectable } from '@angular/core';
import {
  HttpInterceptor,
  HttpRequest,
  HttpHandler,
  HttpHeaders
} from '@angular/common/http';

@Injectable()
export class AuthInterceptorService implements HttpInterceptor {
  constructor() {}

  intercept(req: HttpRequest<any>, next: HttpHandler) {

    if(!localStorage.getItem('authData')){
      return next.handle(req);
    }else{
      const authData: {
        userId: number,
        userName: string,
        _token: string,
        loginDate: Date,
        _tokenExpirationDate: Date
      } = JSON.parse(localStorage.getItem('authData'));
      if(authData._token && authData._tokenExpirationDate && (authData._tokenExpirationDate > new Date())){
        const modifiedReq = req.clone({
          headers: new HttpHeaders().set('Authorization', 'Bearer '+authData._token)
        });
        return next.handle(modifiedReq);
      }
    }

  }
}
