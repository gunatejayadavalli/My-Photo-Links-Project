import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Feedback } from '../models/feedback.model';

@Injectable({
    providedIn: 'root'
})
export class FeedbackService {

    constructor(private http: HttpClient) { }

    submitFeedback(userId: number,feedbackType:string,feedbackMsg:string,submittedBy:string){
        return this.http.post(environment.apiUrl+"/feedbacks",{
            userId: userId,
            feedbackType:feedbackType,
            feedbackMsg:feedbackMsg,
            submittedBy:submittedBy
        }).pipe(catchError(this.handleError));
    }

    getAllFeedbacks() {
        return this.http.get<Feedback[]>(environment.apiUrl + '/getAllFeedbacks',).pipe(catchError(this.handleError));
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