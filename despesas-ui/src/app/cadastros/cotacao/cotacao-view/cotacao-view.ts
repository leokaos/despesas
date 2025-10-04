import { CommonModule } from '@angular/common';
import { Component, inject, signal, ViewChild } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { IconField } from 'primeng/iconfield';
import { InputIcon } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { PanelModule } from 'primeng/panel';
import { ProgressBarModule } from 'primeng/progressbar';
import { TableModule, Table } from 'primeng/table';
import { Loader } from '../../../components/loader/loader';
import { Cotacao } from '../../../models/cotacao.model';
import { CotacaoService } from '../../../services/cotacao-service';

@Component({
  selector: 'app-cotacao-view',
  imports: [
    ButtonModule,
    Loader,
    TableModule,
    IconField,
    InputIcon,
    FormsModule,
    DialogModule,
    InputTextModule,
    ProgressBarModule,
    ReactiveFormsModule,
    CommonModule,
    PanelModule
  ],
  templateUrl: './cotacao-view.html',
  styleUrl: './cotacao-view.scss'
})
export class CotacaoView {

  @ViewChild('table')
  private table?: Table;

  data: Cotacao[] = [];
  searchValue?: string;
  loading = signal<boolean>(true);
  showDialog: boolean = false;
  cotacao?: Cotacao;

  private cotacaoService = inject(CotacaoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.cotacaoService.fetch().subscribe((data: Cotacao[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  filter() {
    this.loading.set(true);
    this.loadData();
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  add() {
    this.router.navigate(['cotacao']);
  }

  edit(cotacao: Cotacao) {
    this.router.navigate(['cotacao', cotacao.id]);
  }

  openDialog(cotacao: Cotacao) {
    this.cotacao = cotacao;
    this.showDialog = true;
  }

  remover() {

    if (this.cotacao) {
      this.cotacaoService.remove(this.cotacao).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Cotação removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }
}
