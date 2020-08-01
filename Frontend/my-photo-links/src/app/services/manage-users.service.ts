import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { throwError, BehaviorSubject } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Tag } from '../models/tag.model';
import { User } from '../models/user.model';
import { environment } from 'src/environments/environment';

@Injectable({
    providedIn: 'root'
})
export class ManageUsersService {

    allUsers: User[] = [];
    assignTagsUser = new BehaviorSubject<User>(null);
    allAvailableTags = new BehaviorSubject<Tag[]>([]);

    constructor(private http: HttpClient) { }

    getAllUsers() {
        return this.http.get<User[]>(environment.apiUrl + '/getAllUsers',).pipe(catchError(this.handleError));
    }

    getAllTags(){
        return this.http.get<Tag[]>(environment.apiUrl + '/getAllTags',).pipe(catchError(this.handleError));
    }

    modifyUserTags(userId:number,hasTags: boolean,newTags: Tag[]){
        return this.http.post<boolean>(environment.apiUrl + '/modifyUserTags?hasTags='+hasTags,{
            userId: userId,
            tags: newTags
        }).pipe(catchError(this.handleError));
    }

    private handleError(errorRes: HttpErrorResponse) {
        let errorMessage = 'Something went wrong !';
        if (!errorRes.error || !errorRes.error.message) {
            return throwError(errorMessage);
        }
        switch (errorRes.error.message) {
            case 'USER_NOT_FOUND':
                errorMessage = 'User doesn\'t exist !';
                break;
            case 'INVALID_PASSWORD':
                errorMessage = 'Password is incorrect !';
                break;
        }
        return throwError(errorMessage);
    }

}