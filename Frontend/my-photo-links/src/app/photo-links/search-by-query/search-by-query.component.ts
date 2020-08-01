import { Component, OnInit, Output, EventEmitter, OnDestroy } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { PhotoLinksService } from '../../services/photo-links.service';
import { Subscription } from 'rxjs';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';
import { AuthService } from 'src/app/services/auth.service';
import { Tag } from '../../models/tag.model';
import { take } from 'rxjs/operators';

@Component({
  selector: 'app-search-by-query',
  templateUrl: './search-by-query.component.html',
  styleUrls: ['./search-by-query.component.css']
})
export class SearchByQueryComponent implements OnInit,OnDestroy {

  searchForm: FormGroup;
  maxDate;
  minDate;
  allSubs: Subscription[] = [];
  searching = false;
  userTags: Tag[] = [new Tag(0,'All',null,null,null,null)];

  constructor(private authService: AuthService, private photoLinksService : PhotoLinksService, private router : Router) { }

  ngOnInit(): void {

    this.allSubs.push(this.authService.user.pipe(take(1)).subscribe(user => {
      this.userTags.push(...user.tags);
      this.maxDate = new Date();
      this.minDate = new Date('1970-01-01T00:00:00');

      const groupValidator = (group: FormGroup): {[s: string]: boolean} => {
        if(group.value.fromDate > group.value.toDate && group.value.fromDate!=null && 
          group.value.toDate!=null && (this.minDate<=group.value.fromDate<=this.maxDate) && (this.minDate<=group.value.toDate<=this.maxDate)){
          this.searchForm.get('fromDate').setErrors({
            fromDateGreater: true
          });
          this.searchForm.get('toDate').setErrors({
            fromDateGreater: true
          });
          return {'fromDateGreater': true}
        }else if(group.value.fromDate <= group.value.toDate && group.value.fromDate!=null && 
          group.value.toDate!=null && (this.minDate<=group.value.fromDate<=this.maxDate) && (this.minDate<=group.value.toDate<=this.maxDate)){
          this.searchForm.get('fromDate').setErrors(null);
          this.searchForm.get('toDate').setErrors(null);
          return null
        }
      };
  
      this.searchForm = new FormGroup({
        keyword : new FormControl(''),
        fromDate : new FormControl(),
        toDate : new FormControl(),
        selectedTag : new FormControl()
      },{
        validators: groupValidator
      });

      this.searchForm.patchValue({
        selectedTag : 0
      });

      }
    ));

  }

  OnSubmit(){
    this.searching = true;
    if(this.searchForm.value.fromDate===null){
      this.searchForm.patchValue({
        fromDate : this.minDate
      })
    }
    if(this.searchForm.value.toDate===null){
      this.searchForm.patchValue({
        toDate : this.maxDate
      })
    }
    this.allSubs.push(this.authService.refreshUser().subscribe(user => {
      if(user.tags.length==0 || user.blockFlag === 'Y'){
        window.location.reload();
      }else{
        this.allSubs.push(this.photoLinksService.getPhotoLinks(
          this.searchForm.value.keyword,
          this.searchForm.value.fromDate,
          this.searchForm.value.toDate,
          this.searchForm.value.selectedTag).subscribe(
            results => {
              this.searching = false;
              if(results.length>0){
                this.photoLinksService.resultsMode.next(true);
                this.photoLinksService.editMode.next(false);
                this.photoLinksService.photoLinks.next(results);
                this.router.navigate(['/results']);
              }else{
                this.photoLinksService.resultsMode.next(false);
                Swal.fire({
                  icon: 'error',
                  title: 'Oops...',
                  text: 'No results found !',
                  showClass: {
                    popup: 'animate__animated animate__shakeX'
                  }
                });
              }
            },
            errorMessage => {
              this.photoLinksService.resultsMode.next(false);
              this.searching = false;
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: errorMessage,
                showClass: {
                  popup: 'animate__animated animate__shakeX'
                }
              });
            }
          )
        );
      }
    })
    );

  }

  ngOnDestroy(){
    if(this.allSubs.length>0){
      this.allSubs.forEach(sub => {
        if(sub){
          sub.unsubscribe();
        }
      });
    }
  }

}
