import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertWizzard } from './alert-wizzard';

describe('AlertWizzard', () => {
  let component: AlertWizzard;
  let fixture: ComponentFixture<AlertWizzard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertWizzard]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertWizzard);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
