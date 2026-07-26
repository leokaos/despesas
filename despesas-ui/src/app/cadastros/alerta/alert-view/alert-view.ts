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
    PanelModule
  ],
  templateUrl: './alert-view.html',
  styleUrl: './alert-view.scss',
})
export class AlertView implements OnInit {

  data = signal<Alerta[]>([]);
  loading = signal<boolean>(true);
  searchValue?: string;

  private alertaService = inject(AlertaService);

  tipoAlertaMap: any = {
    'FATURA_CARTAO_CREDITO': 'Lembrete de fatura de cartão de crédito',
    'DESPESA_RECORRENTE': 'Alerta de despesa recorrente',
    'VALOR_LIMITE_DIVIDA': 'Data limite de dívida'
  };
  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.alertaService.fetch().subscribe((data: Alerta[]) => {
      this.data.update(_ => [...data]);
      this.loading.set(false);
    });
  }

  public add() {

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
