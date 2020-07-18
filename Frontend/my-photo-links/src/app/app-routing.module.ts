import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { WelcomeComponent } from './welcome/welcome.component';
import { LoginComponent } from './auth/login/login.component';
import { SignupComponent } from './auth/signup/signup.component';
import { PhotoLinksComponent } from './photo-links/photo-links.component';
import {AuthGuard} from './auth/auth.guard';
import { ForgetPasswordComponent } from './auth/forget-password/forget-password.component';


const routes: Routes = [
  {path:'', component: WelcomeComponent},
  {path:'login', component: LoginComponent},
  {path:'signup', component: SignupComponent},
  {path:'resetPwd', component: ForgetPasswordComponent},
  {path:'photoLinks', component: PhotoLinksComponent, canActivate: [AuthGuard]},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})

export class AppRoutingModule { }
