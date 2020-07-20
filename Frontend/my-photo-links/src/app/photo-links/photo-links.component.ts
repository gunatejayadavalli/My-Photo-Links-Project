import { Component, OnInit, OnDestroy } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { User } from '../auth/user.model';
import { take, exhaustMap } from 'rxjs/operators';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-photo-links',
  templateUrl: './photo-links.component.html',
  styleUrls: ['./photo-links.component.css']
})
export class PhotoLinksComponent implements OnInit,OnDestroy {

  resultsMode = false;
  loggedInUser: User;
  userNotAllowedReason = null;
  allSubs: Subscription[] = [];

  constructor(private authService : AuthService) { }

  ngOnInit(): void {

    this.allSubs.push(this.authService.user.pipe(take(1)).subscribe(user => {
      this.loggedInUser = user;
    }));
    if(this.loggedInUser.blockFlag==='Y'){
      this.userNotAllowedReason = 'BLOCKED';
    }else if (this.loggedInUser.tags.length===0){
      this.userNotAllowedReason = 'NO_TAGS';
    }else{
      this.userNotAllowedReason = null;
    }

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
