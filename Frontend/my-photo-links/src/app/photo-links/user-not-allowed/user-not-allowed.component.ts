import { Component, OnInit, OnDestroy } from '@angular/core';
import { User } from '../../models/user.model';
import { AuthService } from 'src/app/services/auth.service';
import { take } from 'rxjs/operators';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-user-not-allowed',
  templateUrl: './user-not-allowed.component.html',
  styleUrls: ['./user-not-allowed.component.css']
})
export class UserNotAllowedComponent implements OnInit,OnDestroy {

  loggedInUser: User;
  userBlocked = false;
  userHasNoTags = false;
  blockReason = null;
  allSubs:Subscription[] = [];
  contactAdminUrl = "";

  constructor(private authService : AuthService) { }

  ngOnInit(): void {

    this.allSubs.push(this.authService.user.pipe(take(1)).subscribe(user => {
      this.loggedInUser = user;
      if(this.loggedInUser.blockFlag==='Y'){
        this.userBlocked = true;
        this.blockReason = this.loggedInUser.blockReason;
        this.contactAdminUrl="https://api.whatsapp.com/send?phone=918500572622";
      }else if(this.loggedInUser.tags.length==0){
        this.userHasNoTags = true;
        this.contactAdminUrl="https://api.whatsapp.com/send?phone=918500572622&text=Hi%20Guna%2C%0A%0AI%20am%20not%20able%20to%20view%20photo%20links%20since%20I%20have%20been%20not%20assigned%20to%20any%20tag.%20Assign%20me%20a%20tag.%0A%0AMy%20Username%20%3A%20*"+this.loggedInUser.userName+"*";
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
