import { Component, OnInit, Output, EventEmitter, OnDestroy } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit, OnDestroy {

  @Output() sideNavToggle = new EventEmitter<void>();
  userSub: Subscription;
  isAuthenticated = false;

  constructor(private authService : AuthService) { }

  ngOnDestroy(): void {
    if(this.userSub){
      this.userSub.unsubscribe();
    }
  }

  ngOnInit(): void {
    this.userSub = this.authService.isAuth.subscribe(isAuth => {
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
