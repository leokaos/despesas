import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertWizardStep2Divida } from './alert-wizard-step2-divida';

describe('AlertWizardStep2Divida', () => {
  let component: AlertWizardStep2Divida;
  let fixture: ComponentFixture<AlertWizardStep2Divida>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertWizardStep2Divida]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertWizardStep2Divida);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
