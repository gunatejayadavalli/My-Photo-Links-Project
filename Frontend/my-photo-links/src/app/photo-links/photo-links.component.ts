import { Component, OnInit, OnDestroy } from '@angular/core';
import { AuthService } from '../services/auth.service';
import { User } from '../models/user.model';
import { Subscription } from 'rxjs';
import { PhotoLinksService } from '../services/photo-links.service';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-photo-links',
  templateUrl: './photo-links.component.html',
  styleUrls: ['./photo-links.component.css']
})
export class PhotoLinksComponent implements OnInit,OnDestroy {

  loggedInUser: User;
  userNotAllowed = null;
  allSubs: Subscription[] = [];
  isSuperAdmin = false;
  isAdmin = false;
  
  constructor(private authService : AuthService, private photoLinksService : PhotoLinksService, private route: ActivatedRoute) {}

  ngOnInit(): void {

    this.allSubs.push(this.route.data.subscribe(data => {
      this.loggedInUser = data.user;
      data.user.roles.forEach(role => {
        if(role.roleName === 'ROLE_SUPERADMIN'){
          this.isSuperAdmin = true;
        }
        if(role.roleName === 'ROLE_ADMIN'){
          this.isAdmin = true;
        }
      })
      this.authService.user.next(this.loggedInUser);
        if(this.loggedInUser.blockFlag==='Y'){
          this.userNotAllowed = 'BLOCKED';
        }else if (this.loggedInUser.tags.length===0){
          this.userNotAllowed = 'NO_TAGS';
        }else{
          this.userNotAllowed = null;
        }
    }));

  }

  ngOnDestroy(){
    if(this.allSubs.length>0){
      this.allSubs.forEach(sub => {
        if(sub){
          sub.unsubscribe();
        }
      })
    }
  }

}
