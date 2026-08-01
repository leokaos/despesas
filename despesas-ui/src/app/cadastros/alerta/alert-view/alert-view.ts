import { Component, inject, OnInit, signal } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { TableModule } from 'primeng/table';
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
import { map } from 'rxjs';
import { AlertWizzard } from "../alert-wizard/alert-wizard";

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

  data = signal<Alerta[]>([]);
  loading = signal<boolean>(true);
  showDialog = false;
  searchValue?: string;

  private alertaService = inject(AlertaService);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.alertaService.fetch().pipe(
      map(data => data.map(alerta => this.processAlerta(alerta)))
    ).subscribe((data: Alerta[]) => {
      this.data.update(_ => [...data]);
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
    this.showDialog = true;
  }

  public reload() {

  }

  public search() {

  }

  public openDialog(alerta: Alerta) {

  }

  public edit(alerta: Alerta) {

  }

}
