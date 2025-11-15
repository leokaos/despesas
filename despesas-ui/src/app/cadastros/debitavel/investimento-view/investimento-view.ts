import { DecimalPipe, DatePipe } from '@angular/common';
import { Component, inject, signal, ViewChild } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { DialogModule } from 'primeng/dialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { TableModule, Table } from 'primeng/table';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { Loader } from '../../../components/loader/loader';
import { Divida, Investimento } from '../../../models/debitavel.model';
import { DividaService } from '../../../services/divida-service';
import { InvestimentoService } from '../../../services/investimento-service';

@Component({
  selector: 'app-investimento-view',
  imports: [
    ButtonModule,
    TableModule,
    IconFieldModule,
    FormsModule,
    DialogModule,
    InputIconModule,
    ReactiveFormsModule,
    ColorPickerModule,
    InputTextModule,
    ColorDisplay,
    DecimalPipe,
    Loader,
  ],
  templateUrl: './investimento-view.html',
  styleUrl: './investimento-view.scss',
})
export class InvestimentoView {
  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data = signal<Investimento[]>([]);
  searchValue?: string;
  showDialog: boolean = false;
  investimento?: Investimento;

  private investimentoService = inject(InvestimentoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {
    this.investimentoService.fetch().subscribe((data: Investimento[]) => {
      this.data.update(_ => [...data]);
      this.loading.set(false);
    });
  }

  add() {
    this.router.navigate(['investimento']);
  }

  edit(divida: Divida) {
    this.router.navigate(['investimento', divida.id]);
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  openDialog(investimento: Investimento) {
    this.showDialog = true;
    this.investimento = investimento;
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  remover() {
    if (this.investimento) {
      // prettier-ignore
      this.investimentoService.remove(this.investimento).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Investimento removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }
}
