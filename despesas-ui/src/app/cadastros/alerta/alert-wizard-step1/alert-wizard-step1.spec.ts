import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertWizardStep1 } from './alert-wizard-step1';

describe('AlertWizardStep1', () => {
  let component: AlertWizardStep1;
  let fixture: ComponentFixture<AlertWizardStep1>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertWizardStep1]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertWizardStep1);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
