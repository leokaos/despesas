import { FaturaService } from './../../../services/fatura-service';
import { Component, inject, OnInit, signal } from '@angular/core';
import { CartaoCredito, Conta, Debitavel, Fatura } from '../../../models/debitavel.model';
import { Loader } from '../../../components/loader/loader';
import { TableModule } from 'primeng/table';
import { ActivatedRoute, Router } from '@angular/router';
import { CartaoCreditoService } from '../../../services/cartao-credito-service';
import { MessageService } from 'primeng/api';
import { concatMap, forkJoin } from 'rxjs';
import { DatePipe, DecimalPipe, JsonPipe } from '@angular/common';
import { ButtonModule } from 'primeng/button';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { DialogModule } from 'primeng/dialog';
import { DatePickerModule } from 'primeng/datepicker';
import { SelectDebitavel } from '../../../components/select-debitavel/select-debitavel';
import { FormsModule } from '@angular/forms';
import { ContaService } from '../../../services/conta-service';

@Component({
  selector: 'app-fatura-view',
  imports: [
    Loader,
    TableModule,
    DatePipe,
    DecimalPipe,
    ButtonModule,
    ColorDisplay,
    DialogModule,
    DatePickerModule,
    SelectDebitavel,
    FormsModule,
  ],
  templateUrl: './fatura-view.html',
  styleUrl: './fatura-view.scss',
})
export class FaturaView implements OnInit {

  cartaoCredito?: CartaoCredito;
  fatura?: Fatura;
  faturas: Fatura[] = [];
  contas: Conta[] = [];
  loading = signal<boolean>(true);
  showDialog: boolean = false;
  dataPagamento?: Date;
  conta?: Conta;

  private faturaService = inject(FaturaService);
  private cartaoCreditoService = inject(CartaoCreditoService);
  private contaService = inject(ContaService);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private router = inject(Router);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {

    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {

      this.cartaoCreditoService.fetchById(parseInt(id)).pipe(
        concatMap((cartao: CartaoCredito) => {
          this.cartaoCredito = cartao;

          return forkJoin({
            faturas: this.faturaService.fetch(cartao),
            contas: this.contaService.fetch(),
          });
        })
      ).subscribe(({ faturas, contas }) => {
        this.faturas = faturas;
        this.contas = contas.filter((conta: Conta) => conta.moeda === this.cartaoCredito?.moeda);
        this.loading.set(false);
      });

    } else {
      this.messageService.add({ severity: 'error', summary: 'Erro', detail: 'Cartão de Crédito não encontrado!', life: 3000 });
      this.router.navigate(['cartoes']);
    }
  }

  pagarFatura() {

    if (this.fatura && this.conta && this.dataPagamento) {

      this.faturaService.pay(this.fatura, this.conta, this.dataPagamento).subscribe((_) => {
        this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Fatura paga com sucesso!', life: 3000, });
        this.loadData();
      });

      this.showDialog = false;
    }
  }

}
