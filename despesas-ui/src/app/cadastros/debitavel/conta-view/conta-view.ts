import { ContaFiltro, ContaService } from './../../../services/conta-service';
import { Component, inject, OnInit, signal, TemplateRef, ViewChild } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { Conta } from '../../../models/debitavel.model';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { Router } from '@angular/router';
import { DecimalPipe } from '@angular/common';
import { MessageService } from 'primeng/api';
import { BaseDebitavelView, ColumnConfig } from '../../../components/base-debitavel-view/base-debitavel-view';

@Component({
  selector: 'app-conta-view',
  imports: [BaseDebitavelView, ColorDisplay, ButtonModule, DecimalPipe],
  templateUrl: './conta-view.html',
  styleUrl: './conta-view.scss',
})
export class ContaView implements OnInit {

  loading = signal<boolean>(true);
  loadingData = signal<boolean>(false);
  data = signal<Conta[]>([]);
  showApenasAtivos = signal<boolean>(true);
  conta?: Conta;

  @ViewChild(BaseDebitavelView) baseView!: BaseDebitavelView;

  @ViewChild('colorTemplate', { static: true }) colorTemplate!: TemplateRef<any>;
  @ViewChild('saldoTemplate', { static: true }) saldoTemplate!: TemplateRef<any>;
  @ViewChild('ativoTemplate', { static: true }) ativoTemplate!: TemplateRef<any>;

  private contaService = inject(ContaService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  columns: ColumnConfig[] = [];

  constructor() { }

  ngOnInit(): void {

    this.columns = [
      { name: 'Cor', field: 'cor', small: true, template: this.colorTemplate },
      { name: 'Descrição', field: 'descricao' },
      { name: 'Saldo', field: 'saldo', template: this.saldoTemplate },
      { name: 'Ativo', field: 'ativo', center: true, template: this.ativoTemplate }
    ];

    this.loadData();
  }

  loadData() {

    let filtro = {} as ContaFiltro;

    if (this.showApenasAtivos()) {
      filtro.ativo = true;
    }

    this.contaService.fetch(filtro).subscribe((data: Conta[]) => {
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
    this.router.navigate(['conta']);
  }

  edit(id: number) {
    this.router.navigate(['conta', id]);
  }

  remove() {
    if (this.conta) {
      this.contaService.remove(this.conta).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Conta removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.baseView.showDialog.set(false);
  }

  openDialog(conta: any) {
    this.conta = conta;
    this.baseView.showDialog.set(true)
  }

  onChangeAtivos(ativos: boolean) {
    this.loadingData.set(true);
    this.showApenasAtivos.set(ativos);
    this.loadData();
  }

}
