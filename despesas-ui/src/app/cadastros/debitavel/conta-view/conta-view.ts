import { ContaService } from './../../../services/conta-service';
import { Component, EventEmitter, inject, OnInit, Output, signal, ViewChild } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { DialogModule } from 'primeng/dialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { Table, TableModule } from 'primeng/table';
import { Conta } from '../../../models/debitavel.model';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { Loader } from '../../../components/loader/loader';
import { Router } from '@angular/router';
import { DecimalPipe } from '@angular/common';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-conta-view',
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
  templateUrl: './conta-view.html',
  styleUrl: './conta-view.scss',
})
export class ContaView implements OnInit {
  @Output()
  onRemover: EventEmitter<Conta> = new EventEmitter<Conta>();

  @Output()
  onAdicionar: EventEmitter<void> = new EventEmitter<void>();

  @Output()
  onEdit: EventEmitter<Conta> = new EventEmitter<Conta>();

  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data: Conta[] = [];
  searchValue?: string;
  showDialog: boolean = false;
  conta?: Conta;

  private contaService = inject(ContaService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  constructor() {}

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.contaService.fetch().subscribe((data: Conta[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  add() {
    this.router.navigate(['conta']);
  }

  edit(conta: Conta) {
    this.router.navigate(['conta', conta.id]);
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  emitEdit(conta: Conta) {
    this.onEdit.emit(conta);
  }

  openDialog(conta: Conta) {
    this.showDialog = true;
    this.conta = conta;
  }

  remover() {
    if (this.conta) {
      // prettier-ignore
      this.contaService.remove(this.conta).subscribe(() => {
        this.messageService.add({severity: 'success', summary: 'Successo', detail: 'Conta removida com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }
}
