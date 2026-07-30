import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertView } from './alert-view';

describe('AlertView', () => {
  let component: AlertView;
  let fixture: ComponentFixture<AlertView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
