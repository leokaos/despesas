import { CommonModule } from '@angular/common';
import { Component, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';
import { DividaService } from '../../../services/divida-service';
import { inject } from '@angular/core/primitives/di';
import { Divida } from '../../../models/debitavel.model';

@Component({
  selector: 'app-alert-wizard-step2-divida',
  imports: [SelectDebitavel, CommonModule, FormsModule],
  templateUrl: './alert-wizard-step2-divida.html',
  styleUrl: './alert-wizard-step2-divida.scss',
})
export class AlertWizardStep2Divida {

  dividaService = inject(DividaService)
  data = signal<Divida[]>([]);
  divida?: Divida;

  constructor() { }

  ngOnInit(): void {
    this.dividaService.fetch({ ativo: true }).subscribe(
      data => this.data.set(data)
    );
  }

  public isValid(): boolean {
    return this.divida != null;
  }
}
