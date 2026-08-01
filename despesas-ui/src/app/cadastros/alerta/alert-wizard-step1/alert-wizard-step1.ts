import { Component, output } from '@angular/core';
import { InputNumberModule } from 'primeng/inputnumber';
import { SelectChangeEvent, SelectModule } from 'primeng/select';
import { FormsModule } from "@angular/forms";

@Component({
  selector: 'app-alert-wizard-step1',
  imports: [
    SelectModule,
    InputNumberModule,
    FormsModule
  ],
  templateUrl: './alert-wizard-step1.html',
  styleUrl: './alert-wizard-step1.scss',
})
export class AlertWizardStep1 {

  tiposAlerta = [
    { label: 'Lembrete de fatura de cartão de crédito', value: 'FATURA_CARTAO_CREDITO' },
    { label: 'Data limite de dívida', value: 'VALOR_LIMITE_DIVIDA' },
    { label: 'Alerta de despesa recorrente', value: 'DESPESA_RECORRENTE' }
  ];

  tipo?: string;
  diasAntesDeAviso?: number;

  onTipoSelected = output<string>();

  constructor() { }

  public isValid(): boolean {
    return this.tipo != null && this.diasAntesDeAviso != null;
  }

  public getValue() {
    return {
      tipo: this.tipo,
      diasAntesDeAviso: this.diasAntesDeAviso
    }
  }

  selectTipo($event: SelectChangeEvent) {
    this.onTipoSelected.emit($event.value);
  }

}
