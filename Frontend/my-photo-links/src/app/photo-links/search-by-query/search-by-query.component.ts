import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';

@Component({
  selector: 'app-search-by-query',
  templateUrl: './search-by-query.component.html',
  styleUrls: ['./search-by-query.component.css']
})
export class SearchByQueryComponent implements OnInit {

  searchForm: FormGroup;
  maxDate;
  minDate;

  constructor() { }

  ngOnInit(): void {

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
      keyword : new FormControl(null),
      fromDate : new FormControl(),
      toDate : new FormControl(),
    },{
      validators: groupValidator
    });
    this.maxDate = new Date();
    this.minDate = new Date('1970-01-01T00:00:00');
  }

  OnSubmit(){
    console.log(this.searchForm);
  }

}
