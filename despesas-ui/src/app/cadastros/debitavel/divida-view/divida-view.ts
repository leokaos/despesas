import { Component, inject, OnInit, signal, TemplateRef, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { DividaFiltro, DividaService } from '../../../services/divida-service';
import { Divida } from '../../../models/debitavel.model';
import { ActionConfig, BaseDebitavelView, ColumnConfig } from "../../../components/base-debitavel-view/base-debitavel-view";
import { ColorDisplay } from "../../../components/color-display/color-display";
import { ButtonModule } from 'primeng/button';
import { DatePipe, DecimalPipe } from '@angular/common';

@Component({
  selector: 'app-divida-view',
  imports: [BaseDebitavelView, ColorDisplay, ButtonModule, DecimalPipe, DatePipe],
  templateUrl: './divida-view.html',
  styleUrl: './divida-view.scss',
})
export class DividaView implements OnInit {

  loading = signal<boolean>(true);
  loadingData = signal<boolean>(false);
  data = signal<Divida[]>([]);
  showApenasAtivos = signal<boolean>(true);
  divida?: Divida;

  @ViewChild(BaseDebitavelView) baseView!: BaseDebitavelView;

  @ViewChild('colorTemplate', { static: true }) colorTemplate!: TemplateRef<any>;
  @ViewChild('valorTotalTemplate', { static: true }) valorTotalTemplate!: TemplateRef<any>;
  @ViewChild('dataInicioTemplate', { static: true }) dataInicioTemplate!: TemplateRef<any>;
  @ViewChild('valorRestanteTemplate', { static: true }) valorRestanteTemplate!: TemplateRef<any>;
  @ViewChild('ativoTemplate', { static: true }) ativoTemplate!: TemplateRef<any>;

  private dividaService = inject(DividaService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  columns: ColumnConfig[] = [];
  extraActions: ActionConfig[] = [];

  constructor() { }

  ngOnInit(): void {

    this.columns = [
      { name: 'Cor', field: 'cor', small: true, template: this.colorTemplate },
      { name: 'Descrição', field: 'descricao' },
      { name: 'Valor Total', field: 'valorTotal', template: this.valorTotalTemplate },
      { name: 'Data Início', field: 'dataInicio', template: this.dataInicioTemplate },
      { name: 'Periodicidade', field: 'periodicidade', center: true },
      { name: 'Restante', field: 'valorRestante', template: this.valorRestanteTemplate },
      { name: 'Ativo', field: 'ativo', small: true, center: true, template: this.ativoTemplate }
    ];

    this.extraActions = [
      { icon: 'pi pi-list', severity: 'warn', action: this.showAportes.bind(this) }
    ];

    this.loadData();
  }

  loadData() {

    let filtro = {} as DividaFiltro;

    if (this.showApenasAtivos()) {
      filtro.ativo = true;
    }

    this.dividaService.fetch(filtro).subscribe((data: Divida[]) => {
      this.data.update(_ => [...data]);
      this.loading.set(false);
      this.loadingData.set(false);
    });

  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  add() {
    this.router.navigate(['divida']);
  }

  edit(id: number) {
    this.router.navigate(['divida', id]);
  }

  remove() {
    if (this.divida) {
      this.dividaService.remove(this.divida).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Dívida removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.baseView.showDialog.set(false);
  }

  openDialog(divida: any) {
    this.divida = divida;
    this.baseView.showDialog.set(true)
  }

  onChangeAtivos(ativos: boolean) {
    this.loadingData.set(true);
    this.showApenasAtivos.set(ativos);
    this.loadData();
  }

  showAportes(divida: Divida) {
    this.router.navigate(['divida', divida.id, 'aportes']);
  }
}
