import { CommonModule } from '@angular/common';
import { AfterViewInit, Component, input, OnInit, output, Type, ViewChild } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { InputNumberModule } from 'primeng/inputnumber';
import { SelectModule } from 'primeng/select';
import { StepperModule } from 'primeng/stepper';
import { AlertWizardStep1 } from "../alert-wizard-step1/alert-wizard-step1";
import { AlertWizardStep3 } from '../alert-wizard-step3/alert-wizard-step3';
import { AlertWizardStep2Cartao } from '../alert-wizard-step2-cartao/alert-wizard-step2-cartao';
import { AlertWizardStep2Divida } from '../alert-wizard-step2-divida/alert-wizard-step2-divida';
import { AlertWizardStep2Recorrente } from '../alert-wizard-step2-recorrente/alert-wizard-step2-recorrente';

@Component({
  selector: 'app-alert-wizard',
  imports: [
    StepperModule,
    ButtonModule,
    InputNumberModule,
    SelectModule,
    ReactiveFormsModule,
    DialogModule,
    CommonModule,
    AlertWizardStep1,
    AlertWizardStep3
  ],
  templateUrl: './alert-wizard.html',
  styleUrl: './alert-wizard.scss',
})
export class AlertWizzard implements OnInit, AfterViewInit {

  passoAtual = 1;

  showDialog = input<boolean>(false);
  fechar = output<void>();

  steps: any = {};

  @ViewChild('step1') step1!: AlertWizardStep1;
  step2: Type<any> | null = null;
  @ViewChild('step3') step3!: AlertWizardStep3;

  constructor() { }

  carregarComponente(tipo?: string) {

    switch (tipo) {
      case 'FATURA_CARTAO_CREDITO':
        this.step2 = AlertWizardStep2Cartao;
        break;
      case 'VALOR_LIMITE_DIVIDA':
        this.step2 = AlertWizardStep2Divida;
        break;
      case 'DESPESA_RECORRENTE':
        this.step2 = AlertWizardStep2Recorrente;
        break;
    }

    this.buildSteps();
  }

  ngOnInit(): void {

  }

  ngAfterViewInit() {
    this.buildSteps();
  }

  buildSteps() {
    this.steps = {
      1: this.step1,
      2: this.step2,
      3: this.step3
    };

    console.info(this.steps)
  }

  isStepValido(): boolean {
    return this.steps[this.passoAtual]?.isValid() || false;
  }

  proximoPasso() {
    this.passoAtual++;
  }

  cancelar() {
    this.fechar.emit();
  }

}
