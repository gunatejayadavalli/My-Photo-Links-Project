import { Component, OnInit, Output, EventEmitter, OnDestroy } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit,OnDestroy {

  @Output() sideNavToggle = new EventEmitter<void>();
  isAuthenticated = false;
  isSuperAdmin = false;
  isAdmin = false;
  authSub:Subscription;
  authDataSub:Subscription;

  constructor(private authService : AuthService) { }

  ngOnDestroy(): void {
    if(this.authSub){
      this.authSub.unsubscribe();
    }
    if(this.authDataSub){
      this.authDataSub.unsubscribe();
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

  OnToggleSideNav(){
    this.sideNavToggle.emit();
  }

  OnLogout(){
    this.authService.logout();
  }

}
