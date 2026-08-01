import { Component, inject, OnInit, signal } from '@angular/core';
import { CartaoCreditoService } from '../../../services/cartao-credito-service';
import { CartaoCredito } from '../../../models/debitavel.model';
import { SelectDebitavel } from "../../../components/select-debitavel/select-debitavel";
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-alert-wizard-step2-cartao',
  imports: [SelectDebitavel, CommonModule, FormsModule],
  templateUrl: './alert-wizard-step2-cartao.html',
  styleUrl: './alert-wizard-step2-cartao.scss',
})
export class AlertWizardStep2Cartao implements OnInit {

  cartaoService = inject(CartaoCreditoService)
  data = signal<CartaoCredito[]>([]);
  cartao?: CartaoCredito;

  constructor() { }

  ngOnInit(): void {
    this.cartaoService.fetch({ ativo: true }).subscribe(
      data => this.data.set(data)
    );
  }

  public isValid(): boolean {
    return this.cartao != null;
  }

}
