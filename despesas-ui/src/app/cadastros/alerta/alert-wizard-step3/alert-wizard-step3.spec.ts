import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertWizardStep3 } from './alert-wizard-step3';

describe('AlertWizardStep3', () => {
  let component: AlertWizardStep3;
  let fixture: ComponentFixture<AlertWizardStep3>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertWizardStep3]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertWizardStep3);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
