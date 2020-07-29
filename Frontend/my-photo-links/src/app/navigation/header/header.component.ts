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
  }

  ngOnInit(): void {
    this.authSub = this.authService.isAuth.subscribe(isAuth => {
      this.isAuthenticated = isAuth;
    });
  }

  OnToggleSideNav(){
    this.sideNavToggle.emit();
  }

  OnLogout(){
    this.authService.logout();
  }

}
