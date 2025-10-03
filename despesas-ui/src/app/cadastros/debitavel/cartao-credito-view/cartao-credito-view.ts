import { Component, inject, signal, ViewChild } from '@angular/core';
import { Bandeira, CartaoCredito } from '../../../models/debitavel.model';
import { CartaoCreditoService } from '../../../services/cartao-credito-service';
import { DecimalPipe } from '@angular/common';
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
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import {
  faCcVisa,
  faCcMastercard,
  faCcAmex,
  IconDefinition,
} from '@fortawesome/free-brands-svg-icons';

@Component({
  selector: 'app-cartao-credito-view',
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
    FontAwesomeModule,
  ],
  templateUrl: './cartao-credito-view.html',
  styleUrl: './cartao-credito-view.scss',
})
export class CartaoCreditoView {
  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data: CartaoCredito[] = [];
  searchValue?: string;
  showDialog: boolean = false;
  cartaoCredito?: CartaoCredito;

  public iconesBandeira: Record<Bandeira, IconDefinition> = {
    [Bandeira.VISA]: faCcVisa,
    [Bandeira.MASTERCARD]: faCcMastercard,
    [Bandeira.AMERICAN_EXPRESS]: faCcAmex,
  };

  private cartaoCreditoService = inject(CartaoCreditoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  constructor() {}

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {
    this.cartaoCreditoService.fetch().subscribe((data: CartaoCredito[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  getIconeBandeira(cartaoCredito: CartaoCredito) {
    return this.iconesBandeira[cartaoCredito.bandeira];
  }

  add() {
    this.router.navigate(['cartao']);
  }

  edit(cartaoCredito: CartaoCredito) {
    this.router.navigate(['cartao', cartaoCredito.id]);
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  openDialog(cartaoCredito: CartaoCredito) {
    this.showDialog = true;
    this.cartaoCredito = cartaoCredito;
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  remover() {
    if (this.cartaoCredito) {
      // prettier-ignore
      this.cartaoCreditoService.remove(this.cartaoCredito).subscribe(() => {
        this.messageService.add({severity: 'success', summary: 'Successo', detail: 'Cartão de Crédito removido com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }
}
