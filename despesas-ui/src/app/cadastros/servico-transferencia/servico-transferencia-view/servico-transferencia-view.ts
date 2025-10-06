import { DecimalPipe } from '@angular/common';
import { Component, inject, signal, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { PanelModule } from 'primeng/panel';
import { TableModule, Table } from 'primeng/table';
import { Loader } from '../../../components/loader/loader';
import { Periodo } from '../../../models/periodo.model';
import { ServicoTransferencia } from '../../../models/servico-transferencia.model';
import { ServicoTransferenciaService } from '../../../services/servico-transferencia-service';

@Component({
  selector: 'app-servico-transferencia-view',
  imports: [ButtonModule,
    Loader,
    TableModule,
    IconFieldModule,
    InputIconModule,
    FormsModule,
    DialogModule,
    InputTextModule,
    PanelModule,
    DecimalPipe,
  ],
  templateUrl: './servico-transferencia-view.html',
  styleUrl: './servico-transferencia-view.scss'
})
export class ServicoTransferenciaView {
  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data: ServicoTransferencia[] = [];
  searchValue?: string;
  showDialog: boolean = false;
  servicoTransferencia?: ServicoTransferencia;
  periodo?: Periodo;

  private router = inject(Router);
  private messageService = inject(MessageService);
  private servicoTransferenciaService = inject(ServicoTransferenciaService);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.servicoTransferenciaService.fetch().subscribe((data: ServicoTransferencia[]) => {
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
    this.router.navigate(['servico-transferencia']);
  }

  remover() {

    if (this.servicoTransferencia) {

      this.servicoTransferenciaService.remove(this.servicoTransferencia).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Serviço de Transferência removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  openDialog(servicoTransferencia: ServicoTransferencia) {
    this.showDialog = true;
    this.servicoTransferencia = servicoTransferencia;
  }

  edit(servicoTransferencia: ServicoTransferencia) {
    this.router.navigate(['servico-transferencia', servicoTransferencia.id]);
  }
}
