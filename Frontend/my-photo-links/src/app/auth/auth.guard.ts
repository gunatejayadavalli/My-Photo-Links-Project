import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router, UrlTree } from '@angular/router';
import { Injectable } from '@angular/core';
import { Observable, Subscription } from 'rxjs';
import { map, take } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';
import { PhotoLinksService } from '../services/photo-links.service';

@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
  constructor(private authService: AuthService, private router: Router, private photoLinksService : PhotoLinksService) {}
  canActivate( route: ActivatedRouteSnapshot, router: RouterStateSnapshot):
    | boolean
    | UrlTree
    | Promise<boolean | UrlTree>
    | Observable<boolean | UrlTree> {
    return this.authService.isAuth.pipe(
      take(1),
      map(isAuth => {
        if(router.url==='/photoLinks' || router.url==='/results' || router.url==='/manageUsers' || router.url==='/myProfile' || router.url==='/manageTags'){
          if (isAuth) {
            return true;
          }
          return this.router.createUrlTree(['/login']);
        }else if(router.url==='/login' || router.url==='/signup' || router.url==='/resetPwd'){
          if (!isAuth) {
            return true;
          }
          return this.router.createUrlTree(['/photoLinks']);
        }
      })
    );
  }
}
