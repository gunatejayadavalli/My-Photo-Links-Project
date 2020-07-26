import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { throwError, BehaviorSubject } from 'rxjs';
import { catchError } from 'rxjs/operators';
import {PhotoLink} from '../models/photo-link.model';
import { Tag } from '../models/tag.model';

export interface photoLinksResponseData {
    eventId: number,
    event: string,
    fromDate: Date,
    toDate: Date,
    photosLink: string,
    creationTime: Date,
    createdBy: string,
    updationTime: Date,
    updatedBy: string,
    tags: Tag[]
}

@Injectable({
    providedIn: 'root'
})
export class PhotoLinksService {

    resultsMode = new BehaviorSubject<boolean>(false);
    editMode = new BehaviorSubject<boolean>(false);
    photoLinks = new BehaviorSubject<PhotoLink[]>(null);
    editingPhotoLink = new BehaviorSubject<PhotoLink>(null);

    constructor(private http: HttpClient) { }

    getPhotoLinks(keyword: string, fromDate: Date, toDate: Date, selectedTag : number) {
        const authData: {
            userId: number,
            userName: string,
            _token: string,
            loginDate: Date,
            _tokenExpirationDate: Date
        } = JSON.parse(localStorage.getItem('authData'));
        return this.http.post<photoLinksResponseData[]>(environment.apiUrl + '/users/' + authData.userName + '/photoLinks',
            {
                keyword: keyword,
                fromDate: fromDate,
                toDate: toDate,
                selectedTag: selectedTag
            }
        ).pipe(catchError(this.handleError));
    }

    addOrUpdatePhotoLink(eventId: number, event: string, fromDate: Date, toDate: Date, photoLink: string, creationTime: Date,createdBy : string, updationTime: Date,updatedBy : string, tags : Tag[]){
        const authData: {
            userId: number,
            userName: string,
            _token: string,
            loginDate: Date,
            _tokenExpirationDate: Date
        } = JSON.parse(localStorage.getItem('authData'));
        const tagids : number[] = []
        tags.forEach(t => {
            tagids.push(t.tagId);
        })
        return this.http.post<photoLinksResponseData[]>(environment.apiUrl +"/addOrUpdatePhotoLink",
            {
                eventId: eventId,
                event: event,
                fromDate: fromDate,
                toDate: toDate,
                photosLink: photoLink,
                creationTime: creationTime,
                createdBy: createdBy,
                updationTime: updationTime,
                updatedBy: updatedBy,
                tagids: tagids
            }
        ).pipe(catchError(this.handleError));
    }

    deletePhotoLink(eventId : number){
        return this.http.delete(environment.apiUrl+"/photoLinks/"+eventId).pipe(catchError(this.handleError));
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