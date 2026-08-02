import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { Table, TableModule } from 'primeng/table';
import { TagModule } from 'primeng/tag';
import { ToolbarModule } from 'primeng/toolbar';
import { Loader } from "../../../components/loader/loader";
import { AlertaService } from '../../../services/alerta-service';
import { Alerta, TipoAlerta } from '../../../models/alerta.model';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DialogModule } from 'primeng/dialog';
import { InputTextModule } from 'primeng/inputtext';
import { ProgressBarModule } from 'primeng/progressbar';
import { CommonModule } from '@angular/common';
import { PanelModule } from 'primeng/panel';
import { forkJoin, map } from 'rxjs';
import { AlertWizzard } from "../alert-wizard/alert-wizard";
import { CartaoCreditoService } from '../../../services/cartao-credito-service';
import { DividaService } from '../../../services/divida-service';
import { CartaoCredito, Divida } from '../../../models/debitavel.model';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-alert-view',
  imports: [
    TableModule,
    ButtonModule,
    TagModule,
    ToolbarModule,
    CardModule,
    Loader,
    IconFieldModule,
    InputIconModule,
    FormsModule,
    ButtonModule,
    Loader,
    TableModule,
    FormsModule,
    DialogModule,
    InputTextModule,
    ProgressBarModule,
    ReactiveFormsModule,
    CommonModule,
    PanelModule,
    AlertWizzard
  ],
  templateUrl: './alert-view.html',
  styleUrl: './alert-view.scss',
})
export class AlertView implements OnInit {


  @ViewChild('table')
  private table?: Table;

  data = signal<Alerta[]>([]);
  loading = signal<boolean>(true);
  showDialogAdd = signal<boolean>(false);
  showDialogDelete = signal<boolean>(false);
  searchValue?: string;
  alerta?: Alerta;

  cartoes = signal<CartaoCredito[]>([]);
  dividas = signal<Divida[]>([]);

  private alertaService = inject(AlertaService);
  private cartaoCreditoService = inject(CartaoCreditoService);
  private dividaService = inject(DividaService);
  private messageService = inject(MessageService);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    forkJoin({
      alertas: this.alertaService.fetch(),
      cartoes: this.cartaoCreditoService.fetch({ ativo: true }),
      dividas: this.dividaService.fetch({ ativo: true })
    }).subscribe(({ alertas, cartoes, dividas }) => {
      this.data.set(alertas.map(alerta => this.processAlerta(alerta)));
      this.cartoes.set(cartoes);
      this.dividas.set(dividas);
      this.loading.set(false);
    });

  }

  processAlerta(alerta: any): any {

    if (alerta.tipo === 'FATURA_CARTAO_CREDITO') {
      alerta.tipoLabel = 'Lembrete de fatura de cartão de crédito';
      alerta.detalhe = `Fatura vence todo dia ${alerta.cartao?.diaDeFechamento || ''}`;
    }

    if (alerta.tipo === 'VALOR_LIMITE_DIVIDA') {
      alerta.tipoLabel = 'Data limite de dívida';
      alerta.detalhe = `Pagamento Limite em ${alerta.divida?.dataLimite ? new Date(alerta.divida.dataLimite).toLocaleDateString('pt-BR') : ''}`;
    }

    if (alerta.tipo === 'DESPESA_RECORRENTE') {
      alerta.tipoLabel = 'Alerta de despesa recorrente';
      alerta.detalhe = `Todo dia ${alerta.diaAlvo || ''}`;
    }

    return alerta;
  }

  public add() {
    this.showDialogAdd.set(true);
  }

  public reload() {
    this.loading.set(true);
    this.loadData();
  }

  public search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  public openDialog(alerta: Alerta) {
    this.showDialogDelete.set(true);
    this.alerta = alerta;
  }

  save($event: Alerta) {
    this.alertaService.createOrUpdate($event).subscribe(_ => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Alerta Criado com sucesso!', life: 3000 });
      this.showDialogAdd.set(false);
      this.loadData();
    });
  }

  remover() {

    if (this.alerta) {

      this.alertaService.remove(this.alerta).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Alert removido com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialogDelete.set(false);
  }

}
