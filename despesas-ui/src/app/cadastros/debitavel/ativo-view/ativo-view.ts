import { Component, inject, signal, TemplateRef, ViewChild } from '@angular/core';
import { BaseDebitavelView, ColumnConfig } from '../../../components/base-debitavel-view/base-debitavel-view';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { ButtonModule } from 'primeng/button';
import { DecimalPipe } from '@angular/common';
import { Ativo, Conta } from '../../../models/debitavel.model';
import { AtivoService } from '../../../services/ativo-service';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ContaFiltro } from '../../../services/conta-service';


@Component({
  selector: 'app-ativo-view',
  imports: [BaseDebitavelView, ColorDisplay, ButtonModule, DecimalPipe],
  templateUrl: './ativo-view.html',
  styleUrl: './ativo-view.scss',
})
export class AtivoView {

  loading = signal<boolean>(true);
  loadingData = signal<boolean>(false);
  data = signal<Ativo[]>([]);
  showApenasAtivos = signal<boolean>(true);
  ativo?: Ativo;

  @ViewChild(BaseDebitavelView) baseView!: BaseDebitavelView;

  @ViewChild('colorTemplate', { static: true }) colorTemplate!: TemplateRef<any>;
  @ViewChild('valorTemplate', { static: true }) valorTemplate!: TemplateRef<any>;
  @ViewChild('ativoTemplate', { static: true }) ativoTemplate!: TemplateRef<any>;

  private ativoService = inject(AtivoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  columns: ColumnConfig[] = [];

  TIPO_ATIVO_ICONES: { [key: string]: string } = {
    'CARRO': 'pi pi-car',
    'APARTAMENTO': 'pi pi-building',
    'TERRENO': 'pi pi-map',
    'CASA': 'pi pi-home',
  };

  constructor() { }

  ngOnInit(): void {

    this.columns = [
      { name: 'Cor', field: 'cor', small: true, template: this.colorTemplate },
      { name: 'Descrição', field: 'descricao' },
      { name: 'Tipo', field: 'tipoAtivo' },
      { name: 'Valor Total', field: 'valorTotal', template: this.valorTemplate },
      { name: 'Ativo', field: 'ativo', center: true, template: this.ativoTemplate }
    ];

    this.loadData();
  }

  loadData() {

    let filtro = {} as ContaFiltro;

    if (this.showApenasAtivos()) {
      filtro.ativo = true;
    }

    this.ativoService.fetch(filtro).subscribe((data: Ativo[]) => {
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
    this.router.navigate(['ativo']);
  }

  edit(id: number) {
    this.router.navigate(['ativo', id]);
  }

  remove() {
    if (this.ativo) {
      this.ativoService.remove(this.ativo).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Ativo removido com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.baseView.showDialog.set(false);
  }

  openDialog(ativo: any) {
    this.ativo = ativo;
    this.baseView.showDialog.set(true)
  }

  onChangeAtivos(ativos: boolean) {
    this.loadingData.set(true);
    this.showApenasAtivos.set(ativos);
    this.loadData();
  }

}
