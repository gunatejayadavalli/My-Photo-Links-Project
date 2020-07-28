import { Component, OnInit, Output, EventEmitter, OnDestroy } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-side-nav',
  templateUrl: './side-nav.component.html',
  styleUrls: ['./side-nav.component.css']
})
export class SideNavComponent implements OnInit, OnDestroy {

  @Output() closeSideNav = new EventEmitter<void>();
  authSub: Subscription;
  authDataSub:Subscription;
  isAuthenticated = false;
  isSuperAdmin = false;
  isAdmin = false;

  constructor(private authService : AuthService) { }

  ngOnDestroy(): void {
    if(this.authSub){
      this.authSub.unsubscribe();
    }
    if(this.authDataSub){
      this.authDataSub.unsubscribe();
    }
    if(localStorage.getItem('authData')){
      this.isAuthenticated = true;
    }
  }

  ngOnInit(): void {
    this.authSub = this.authService.isAuth.subscribe(isAuth => {
      this.isAuthenticated = isAuth;
    });
    this.authDataSub = this.authService.authData.subscribe(authData => {
      if(authData!=null){
        authData.roles.forEach(role => {
          if(role.roleName === 'ROLE_SUPERADMIN'){
            this.isSuperAdmin = true;
          }
          if(role.roleName === 'ROLE_ADMIN'){
            this.isAdmin = true;
          }
        })
      }
    });
  }

  OnClose(){
    this.closeSideNav.emit();
  }

  OnLogout(){
    this.OnClose();
    this.authService.logout();
  }



}
