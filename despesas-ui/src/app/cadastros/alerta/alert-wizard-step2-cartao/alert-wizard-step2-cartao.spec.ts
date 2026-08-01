import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertWizardStep2Cartao } from './alert-wizard-step2-cartao';

describe('AlertWizardStep2Cartao', () => {
  let component: AlertWizardStep2Cartao;
  let fixture: ComponentFixture<AlertWizardStep2Cartao>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertWizardStep2Cartao]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertWizardStep2Cartao);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
