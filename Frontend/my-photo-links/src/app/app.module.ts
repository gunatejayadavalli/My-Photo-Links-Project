import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {MaterialModule} from './material.module';
import { SignupComponent } from './auth/signup/signup.component';
import { LoginComponent } from './auth/login/login.component';
import { PhotoLinksComponent } from './photo-links/photo-links.component';
import { SearchByQueryComponent } from './photo-links/search-by-query/search-by-query.component';
import { ResultsComponent } from './photo-links/results/results.component';
import { HeaderComponent } from './navigation/header/header.component';
import { SideNavComponent } from './navigation/side-nav/side-nav.component';
import {FlexLayoutModule} from '@angular/flex-layout';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import {AuthService} from './services/auth.service';
import {AuthInterceptorService} from './services/auth-interceptor.service';
import { ForgetPasswordComponent } from './auth/forget-password/forget-password.component';
import { UserNotAllowedComponent } from './photo-links/user-not-allowed/user-not-allowed.component';
import {PhotoLinksService} from './services/photo-links.service';
import { DatePipe } from '@angular/common';
import { AddPhotoLinkComponent } from './photo-links/add-photo-link/add-photo-link.component';
import { EditPhotoLinkComponent } from './photo-links/edit-photo-link/edit-photo-link.component';
import { ManageUsersComponent } from './superadmin/manage-users/manage-users.component';
import {ManageUsersService} from './services/manage-users.service';
import { FooterComponent } from './navigation/footer/footer.component';
import { MyProfileComponent } from './my-profile/my-profile.component';
import { ManageTagsComponent } from './superadmin/manage-tags/manage-tags.component';
import { AboutMeComponent } from './info/about-me/about-me.component';
import { AboutAppComponent } from './info/about-app/about-app.component';
import {FeedbackService} from './services/feedback.service';
import {GiveFeedbackComponent} from './give-feedback/give-feedback.component';
import { ViewFeedbacksComponent } from './superadmin/view-feedbacks/view-feedbacks.component';
import { AssignTagsComponent } from './superadmin/manage-users/assign-tags/assign-tags.component';
import {
  NgxUiLoaderConfig,
  NgxUiLoaderHttpModule,
  NgxUiLoaderModule
} from 'ngx-ui-loader';

// const ngxUiLoaderConfig: NgxUiLoaderConfig = {
//   "bgsColor": "red",
//   "bgsOpacity": 0.5,
//   "bgsPosition": "bottom-right",
//   "bgsSize": 60,
//   "bgsType": "ball-spin-clockwise",
//   "blur": 4,
//   "fgsColor": "#00324F",
//   "fgsPosition": "center-center",
//   "fgsSize": 40,
//   "fgsType": "ball-spin-clockwise",
//   "gap": 24,
//   "logoPosition": "center-center",
//   "logoSize": 120,
//   "logoUrl": "",
//   "masterLoaderId": "master",
//   "overlayBorderRadius": "0",
//   "overlayColor": "rgba(250,250,250,0.4)",
//   "pbColor": "red",
//   "pbDirection": "ltr",
//   "pbThickness": 3,
//   "hasProgressBar": false,
//   "text": "",
//   "textColor": "#FFFFFF",
//   "textPosition": "center-center"
// };

const ngxUiLoaderConfig: NgxUiLoaderConfig = 
{
  "bgsColor": "red",
  "bgsOpacity": 0.5,
  "bgsPosition": "bottom-right",
  "bgsSize": 50,
  "bgsType": "ball-spin-clockwise",
  "blur": 5,
  "delay": 0,
  "fastFadeOut": true,
  "fgsColor": "red",
  "fgsPosition": "center-center",
  "fgsSize": 50,
  "fgsType": "rectangle-bounce",
  "gap": 24,
  "logoPosition": "center-center",
  "logoSize": 120,
  "logoUrl": "",
  "masterLoaderId": "master",
  "overlayBorderRadius": "0",
  "overlayColor": "rgba(40, 40, 40, 0.8)",
  "pbColor": "red",
  "pbDirection": "ltr",
  "pbThickness": 1,
  "hasProgressBar": true,
  "text": "",
  "textColor": "#FFFFFF",
  "textPosition": "center-center",
  "maxTime": -1,
  "minTime": 300
}

@NgModule({
  declarations: [
    AppComponent,
    SignupComponent,
    LoginComponent,
    PhotoLinksComponent,
    SearchByQueryComponent,
    ResultsComponent,
    HeaderComponent,
    SideNavComponent,
    ForgetPasswordComponent,
    UserNotAllowedComponent,
    AddPhotoLinkComponent,
    EditPhotoLinkComponent,
    ManageUsersComponent,
    FooterComponent,
    MyProfileComponent,
    ManageTagsComponent,
    AboutMeComponent,
    AboutAppComponent,
    GiveFeedbackComponent,
    ViewFeedbacksComponent,
    AssignTagsComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialModule,
    FlexLayoutModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgxUiLoaderModule.forRoot(ngxUiLoaderConfig),
    NgxUiLoaderHttpModule.forRoot({ showForeground: true })
  ],
  providers: [
    AuthService,
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptorService,
      multi: true
    },
    PhotoLinksService,
    ManageUsersService,
    FeedbackService,
    DatePipe
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
