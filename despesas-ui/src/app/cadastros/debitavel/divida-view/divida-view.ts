import { Component, inject, signal, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Table, TableModule } from 'primeng/table';
import { DividaService } from '../../../services/divida-service';
import { ButtonModule } from 'primeng/button';
import { Loader } from '../../../components/loader/loader';
import { DatePipe, DecimalPipe } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ColorPickerModule } from 'primeng/colorpicker';
import { DialogModule } from 'primeng/dialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { Divida } from '../../../models/debitavel.model';

@Component({
  selector: 'app-divida-view',
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
    DatePipe,
  ],
  templateUrl: './divida-view.html',
  styleUrl: './divida-view.scss',
})
export class DividaView {

  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data = signal<Divida[]>([]);
  searchValue?: string;
  showDialog: boolean = false;
  divida?: Divida;

  private dividaService = inject(DividaService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.dividaService.fetch().subscribe((data: Divida[]) => {
      this.data.update(_ => [...data]);
      this.loading.set(false);
    });
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  add() {
    this.router.navigate(['divida']);
  }

  edit(divida: Divida) {
    this.router.navigate(['divida', divida.id]);
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  openDialog(divida: Divida) {
    this.showDialog = true;
    this.divida = divida;
  }

  remover() {
    if (this.divida) {
      this.dividaService.remove(this.divida).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Dívida removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  showAportes(divida: Divida) {
    this.router.navigate(['divida', divida.id, 'aportes']);
  }
}
