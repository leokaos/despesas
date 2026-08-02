import { CommonModule } from '@angular/common';
import { Component, input, model, output } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { SelectModule } from 'primeng/select';
import { StepperModule } from 'primeng/stepper';
import { Alerta } from '../../../models/alerta.model';
import { FormsModule } from '@angular/forms';
import { InputNumberModule } from 'primeng/inputnumber';
import { CartaoCredito, Debitavel, Divida } from '../../../models/debitavel.model';
import { SelectDebitavel } from "../../../components/select-debitavel/select-debitavel";
import { InputTextModule } from 'primeng/inputtext';

@Component({
  selector: 'app-alert-wizard',
  imports: [
    DialogModule,
    StepperModule,
    ButtonModule,
    CommonModule,
    SelectModule,
    FormsModule,
    InputNumberModule,
    SelectDebitavel,
    InputTextModule
  ],
  templateUrl: './alert-wizard.html',
  styleUrl: './alert-wizard.scss',
})
export class AlertWizzard {

  showDialog = model.required<boolean>();

  cartoes = input.required<Debitavel[]>();
  dividas = input.required<Debitavel[]>();

  onSave = output<Alerta>();

  tiposAlerta = [
    { label: 'Lembrete de fatura de cartão de crédito', value: 'FATURA_CARTAO_CREDITO' },
    { label: 'Data limite de dívida', value: 'VALOR_LIMITE_DIVIDA' },
    { label: 'Alerta de despesa recorrente', value: 'DESPESA_RECORRENTE' }
  ];

  tiposPeriodicidade = [
    { label: 'Dia Útil', value: 'DIA_UTIL' }
  ];

  private readonly stepValidators: Record<number, () => boolean> = {
    1: () => this.alerta.tipo != null && this.alerta.diasAntesDeAviso != null,

    2: () => {

      if (this.alerta.tipo === 'FATURA_CARTAO_CREDITO') {
        return this.alerta.cartao != null;
      }

      if (this.alerta.tipo === 'VALOR_LIMITE_DIVIDA') {
        return this.alerta.divida != null;
      }

      if (this.alerta.tipo === 'DESPESA_RECORRENTE') {
        return this.alerta.titulo != null && this.alerta.diaAlvo != null && this.alerta.tipoPeriodicidade != null;
      }

      return false;
    },

    3: () => true
  };

  step = 1;

  alerta = {} as Alerta;

  constructor() { }

  save() {
    this.onSave.emit(this.alerta);
  }

  proximo() {
    this.step++;
  }

  anterior() {
    this.step--;
  }

  isValid() {
    return this.stepValidators[this.step]?.() ?? true;
  }

  isAllValid() {
    return Object.values(this.stepValidators).every(validate => validate());
  }

  getTipoAlertaLabel(): string {
    return this.tiposAlerta.find(t => t.value === this.alerta.tipo)?.label || '-';
  }

  getTipoPeriodicidadeLabel(): string {
    return this.tiposPeriodicidade.find(p => p.value === this.alerta.tipoPeriodicidade)?.label || '-';
  }

}