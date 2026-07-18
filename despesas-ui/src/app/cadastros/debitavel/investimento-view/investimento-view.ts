import { DecimalPipe, DatePipe } from '@angular/common';
import { Component, inject, signal, TemplateRef, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { Table } from 'primeng/table';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { Divida, Investimento } from '../../../models/debitavel.model';
import { InvestimentoFiltro, InvestimentoService } from '../../../services/investimento-service';
import { ActionConfig, BaseDebitavelView, ColumnConfig } from '../../../components/base-debitavel-view/base-debitavel-view';

@Component({
  selector: 'app-investimento-view',
  imports: [BaseDebitavelView, ColorDisplay, ButtonModule, DecimalPipe],
  templateUrl: './investimento-view.html',
  styleUrl: './investimento-view.scss',
})
export class InvestimentoView {

  loading = signal<boolean>(true);
  loadingData = signal<boolean>(false);
  data = signal<Investimento[]>([]);
  showApenasAtivos = signal<boolean>(true);
  investimento?: Investimento;

  @ViewChild(BaseDebitavelView) baseView!: BaseDebitavelView;

  @ViewChild('colorTemplate', { static: true }) colorTemplate!: TemplateRef<any>;
  @ViewChild('montanteTemplate', { static: true }) montanteTemplate!: TemplateRef<any>;
  @ViewChild('rendimentoTemplate', { static: true }) rendimentoTemplate!: TemplateRef<any>;
  @ViewChild('valorReceitasTemplate', { static: true }) valorReceitasTemplate!: TemplateRef<any>;
  @ViewChild('yieldTemplate', { static: true }) yieldTemplate!: TemplateRef<any>;
  @ViewChild('ativoTemplate', { static: true }) ativoTemplate!: TemplateRef<any>;

  private investimentoService = inject(InvestimentoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  columns: ColumnConfig[] = [];
  extraActions: ActionConfig[] = [];

  constructor() { }

  ngOnInit(): void {

    this.columns = [
      { name: 'Cor', field: 'cor', small: true, template: this.colorTemplate },
      { name: 'Descrição', field: 'descricao' },
      { name: 'Montante Aplicado', field: 'montante', center: true, template: this.montanteTemplate },
      { name: 'Rendimento', field: 'rendimento', center: true, template: this.rendimentoTemplate },
      { name: 'Periodicidade', field: 'periodicidade', center: true },
      { name: 'Total Rendimento', field: 'valorReceitas', center: true, template: this.valorReceitasTemplate },
      { name: 'Yield', field: 'yield', center: true, template: this.yieldTemplate },
      { name: 'Ativo', field: 'ativo', small: true, center: true, template: this.ativoTemplate }
    ]

    this.loadData();
  }

  loadData() {

    let filtro = {} as InvestimentoFiltro;

    if (this.showApenasAtivos()) {
      filtro.ativo = true;
    }

    this.investimentoService.fetch(filtro).subscribe((data: Investimento[]) => {
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
    this.router.navigate(['investimento']);
  }

  edit(id: number) {
    this.router.navigate(['investimento', id]);
  }

  remove() {
    if (this.investimento) {
      this.investimentoService.remove(this.investimento).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Investimento removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.baseView.showDialog.set(false);
  }

  openDialog(investimento: any) {
    this.investimento = investimento;
    this.baseView.showDialog.set(true)
  }

  onChangeAtivos(ativos: boolean) {
    this.loadingData.set(true);
    this.showApenasAtivos.set(ativos);
    this.loadData();
  }
}
