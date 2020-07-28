import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './auth/login/login.component';
import { SignupComponent } from './auth/signup/signup.component';
import { PhotoLinksComponent } from './photo-links/photo-links.component';
import {AuthGuard} from './auth/auth.guard';
import { ForgetPasswordComponent } from './auth/forget-password/forget-password.component';
import { ResultsComponent } from './photo-links/results/results.component';
import {UserResolver} from './services/user-resolver.service';
import { ManageUsersComponent } from './superadmin/manage-users/manage-users.component';
import { MyProfileComponent } from './my-profile/my-profile.component';

const routes: Routes = [
  {path:'login', component: LoginComponent, canActivate: [AuthGuard]},
  {path:'signup', component: SignupComponent, canActivate: [AuthGuard]},
  {path:'resetPwd', component: ForgetPasswordComponent, canActivate: [AuthGuard]},
  {path:'photoLinks', component: PhotoLinksComponent, canActivate: [AuthGuard], resolve : {user : UserResolver}},
  {path:'results', component: ResultsComponent, canActivate: [AuthGuard]},
  {path:'manageUsers', component: ManageUsersComponent, canActivate: [AuthGuard], resolve : {user : UserResolver}},
  {path:'myProfile', component: MyProfileComponent, canActivate: [AuthGuard], resolve : {user : UserResolver}},
  {path: '', redirectTo:'/photoLinks', pathMatch:'full'},
  {path: '**', redirectTo:'/photoLinks', pathMatch:'full'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
