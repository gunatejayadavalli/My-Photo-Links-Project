import { Component, OnInit, Output, EventEmitter, OnDestroy, ViewChild } from '@angular/core';
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
  isAuthenticated = false;
  showSuperAdminScreens = false;

  constructor(private authService : AuthService) { }

  ngOnDestroy(): void {
    if(this.authSub){
      this.authSub.unsubscribe();
    }
  }

  ngOnInit(): void {
    this.authSub = this.authService.isAuth.subscribe(isAuth => {
      this.isAuthenticated = isAuth;
    });
  }

  OnClose(){
    this.showSuperAdminScreens=false;
    this.closeSideNav.emit();
  }

  OnLogout(){
    this.OnClose();
    this.authService.logout();
  }

  changeSuperAdmin(){
    this.showSuperAdminScreens = ! this.showSuperAdminScreens;
  }



}
