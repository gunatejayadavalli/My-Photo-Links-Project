import { Component, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from '../../models/user.model';
import { AuthService } from '../../services/auth.service';
import { ManageUsersService } from '../../services/manage-users.service';
import Swal from 'sweetalert2';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Tag } from 'src/app/models/tag.model';

@Component({
  selector: 'app-manage-users',
  templateUrl: './manage-users.component.html',
  styleUrls: ['./manage-users.component.css']
})
export class ManageUsersComponent implements OnInit {

  allSubs:Subscription[] = [];
  loggedInUser: User;
  isSuperAdmin = false;
  users:User[] = [];
  allTags:Tag[] = [];

  constructor(private route: ActivatedRoute, private authService: AuthService, 
    private manageUsersService : ManageUsersService, private http : HttpClient, private router: Router) { }

  ngOnInit(): void {

    this.allSubs.push(this.route.data.subscribe(data => {
      this.loggedInUser = data.user;
      data.user.roles.forEach(role => {
        if(role.roleName === 'ROLE_SUPERADMIN'){
          this.isSuperAdmin = true;
        }
      })
      this.authService.user.next(this.loggedInUser);
    }));

    if(this.isSuperAdmin){
      this.getUsers();
      this.getTags();
    }

  }

  getUsers(){
    this.allSubs.push(
      this.manageUsersService.getAllUsers().subscribe(users => {
        this.users = users;
      })
    );
  }

  getTags(){
    this.allSubs.push(
      this.manageUsersService.getAllTags().subscribe(tags => {
        this.allTags = tags;
      })
    );
  }

  ifAdmin(user: User){
    let isAdmin = false;
    user.roles.forEach(role => {
      if(role.roleName === 'ROLE_ADMIN'){
        isAdmin = true;
      }
    });
    return isAdmin;
  }

  OnBlockUser(user : User){
    
    let isUserSuperAdmin = false;

    user.roles.forEach(role => {
      if(role.roleName === 'ROLE_SUPERADMIN'){
        isUserSuperAdmin = true;
      }
    });

    if(this.isSuperAdmin && !isUserSuperAdmin){

      Swal.fire({
        title: 'Submit block reason',
        input: 'text',
        inputValidator: (value) => {
          return !value && 'Must input block reason'
        },
        showCancelButton: true,
        confirmButtonText: 'Block',
        showLoaderOnConfirm: true,
        preConfirm: (reason) => {
          return this.http.post<boolean>(environment.apiUrl+'/blockUnblockUser',{
            userName: user.userName,
            blockFlag: 'Y',
            blockReason : reason
          }).subscribe(res => {

            },error => {
                Swal.showValidationMessage(
                  `Request failed: ${error}`
                )
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        if (result.value) {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "User blocked Successfully !"
          }).then(result => {
            this.getUsers();
          });
        }
      })


    }else{
      Swal.fire({
        icon: 'error',
        title: 'Not allowed',
        text: "User is superadmin !",
        showClass: {
          popup: 'animate__animated animate__shakeX'
        }
      });
    }
 
  }

  OnUnblockUser(user: User){

    if(this.isSuperAdmin){
      Swal.fire({
        title: 'Confirm',
        text: "Unblock the user ?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Unblock',
        showLoaderOnConfirm: true,
        preConfirm: (reason) => {
          return this.http.post<boolean>(environment.apiUrl+'/blockUnblockUser',{
            userName: user.userName,
            blockFlag: 'N',
            blockReason : null
          }).subscribe(res => {

            },error => {
                Swal.showValidationMessage(
                  `Request failed: ${error}`
                )
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        if (result.value) {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "User unblocked Successfully !"
          }).then(result => {
            this.getUsers();
          });
        }
      })

    }else{
      Swal.fire({
        icon: 'error',
        title: 'Not allowed',
        text: "You are not superadmin !",
        showClass: {
          popup: 'animate__animated animate__shakeX'
        }
      });
    }
 
  
  }

  toggleAdminRole(user : User){

    let message = ""
    if(this.ifAdmin(user)){
      message = "Remove admin role ?"
    }else{
      message = "Assign admin role ?"
    }

    if(this.isSuperAdmin){
      Swal.fire({
        title: 'Confirm',
        text: message,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Confirm',
        showLoaderOnConfirm: true,
        preConfirm: (reason) => {
          return this.http.get<boolean>(environment.apiUrl+'/toggleAdminRole/'+user.userId).subscribe(res => {

            },error => {
                Swal.showValidationMessage(
                  `Request failed: ${error}`
                )
            });
        },
        allowOutsideClick: () => !Swal.isLoading()
      }).then((result) => {
        if (result.value) {
          Swal.fire({
            icon: 'success',
            title: 'Success',
            text: "User role switched Successfully !"
          }).then(result => {
            this.getUsers();
          });
        }
      })

    }else{
      Swal.fire({
        icon: 'error',
        title: 'Not allowed',
        text: "You are not superadmin !",
        showClass: {
          popup: 'animate__animated animate__shakeX'
        }
      });
    }

  }

  modifyTags(user:User){
    console.log('Modify tags clicked');

    // Swal.fire({
    //   title: 'edit form',
    //   html:'<form>'+
    //        '<select name="tag" id="tag">'+
    //           '<option value="1">V R MAD KINDS</option>' +
    //           '<option value="2">FAMILY</option>' +
    //           '<option value="3">SIA</option>' +
    //        '</select>'+
    //        '</form>',
    //   showCancelButton: true,
    //   onBeforeOpen: () =>{
    //     document.getElementById("tag").selectedIndex = "1";
    //   }
    // }).then((result) => {
    // });
  
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
