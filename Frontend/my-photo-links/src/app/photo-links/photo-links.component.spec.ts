import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PhotoLinksComponent } from './photo-links.component';

describe('PhotoLinksComponent', () => {
  let component: PhotoLinksComponent;
  let fixture: ComponentFixture<PhotoLinksComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PhotoLinksComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PhotoLinksComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
