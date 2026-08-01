import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertWizardStep2Recorrente } from './alert-wizard-step2-recorrente';

describe('AlertWizardStep2Recorrente', () => {
  let component: AlertWizardStep2Recorrente;
  let fixture: ComponentFixture<AlertWizardStep2Recorrente>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertWizardStep2Recorrente]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertWizardStep2Recorrente);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
