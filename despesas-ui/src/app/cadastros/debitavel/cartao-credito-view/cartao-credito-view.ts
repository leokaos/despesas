import { Component, inject, signal, TemplateRef, ViewChild } from '@angular/core';
import { ActionConfig, BaseDebitavelView, ColumnConfig } from "../../../components/base-debitavel-view/base-debitavel-view";
import { ColorDisplay } from "../../../components/color-display/color-display";
import { ButtonModule } from 'primeng/button';
import { CartaoCredito } from '../../../models/debitavel.model';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { CartaoCreditoFiltro, CartaoCreditoService } from '../../../services/cartao-credito-service';
import { DecimalPipe } from '@angular/common';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';

@Component({
  selector: 'app-cartao-credito-view',
  imports: [BaseDebitavelView, ColorDisplay, ButtonModule, DecimalPipe, FontAwesomeModule],
  templateUrl: './cartao-credito-view.html',
  styleUrl: './cartao-credito-view.scss',
})
export class CartaoCreditoView {

  loading = signal<boolean>(true);
  loadingData = signal<boolean>(false);
  data = signal<CartaoCredito[]>([]);
  showApenasAtivos = signal<boolean>(true);
  cartaoCredito?: CartaoCredito;

  @ViewChild(BaseDebitavelView) baseView!: BaseDebitavelView;

  @ViewChild('colorTemplate', { static: true }) colorTemplate!: TemplateRef<any>;
  @ViewChild('limiteTemplate', { static: true }) limiteTemplate!: TemplateRef<any>;
  @ViewChild('ativoTemplate', { static: true }) ativoTemplate!: TemplateRef<any>;
  @ViewChild('bandeiraTemplate', { static: true }) bandeiraTemplate!: TemplateRef<any>;

  private cartaoCreditoService = inject(CartaoCreditoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  columns: ColumnConfig[] = [];
  extraActions: ActionConfig[] = [];

  constructor() { }

  ngOnInit(): void {

    this.columns = [
      { name: 'Cor', field: 'cor', small: true, template: this.colorTemplate },
      { name: 'Bandeira', field: 'bandeira.codigo', center: true, template: this.bandeiraTemplate },
      { name: 'Descrição', field: 'descricao' },
      { name: 'Limite', field: 'limite', center: true, template: this.limiteTemplate },
      { name: 'Dia Fechamento', field: 'diaDeFechamento', center: true },
      { name: 'Dia Vencimento', field: 'diaDeVencimento', center: true },
      { name: 'Ativo', field: 'ativo', small: true, center: true, template: this.ativoTemplate }
    ];

    this.extraActions = [
      { icon: 'pi pi-list', severity: 'warn', action: this.showFaturas.bind(this) }
    ];

    this.loadData();
  }

  private loadData() {

    let filtro = {} as CartaoCreditoFiltro;

    if (this.showApenasAtivos()) {
      filtro.ativo = true;
    }

    this.cartaoCreditoService.fetch(filtro).subscribe((data: CartaoCredito[]) => {
      this.data.update(_ => [...data]);
      this.loading.set(false);
      this.loadingData.set(false);
    });
  }

  add() {
    this.router.navigate(['cartao']);
  }

  edit(id: number) {
    this.router.navigate(['cartao', id]);
  }
  reload() {
    this.loading.set(true);
    this.loadData();
  }

  update($event: boolean) {
    this.loadingData.set(true);
    this.showApenasAtivos.set($event);
    this.loadData();
  }

  onChangeAtivos(ativos: boolean) {
    this.loadingData.set(true);
    this.showApenasAtivos.set(ativos);
    this.loadData();
  }

  remove() {

    if (this.cartaoCredito) {
      this.cartaoCreditoService.remove(this.cartaoCredito).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Cartão de Crédito removido com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.baseView.showDialog.set(false);
  }

  showFaturas(cartaoCredito: CartaoCredito) {
    this.router.navigate(['cartao', cartaoCredito.id, 'fatura']);
  }

  openDialog(cartaoCredito: any) {
    this.cartaoCredito = cartaoCredito;
    this.baseView.showDialog.set(true)
  }

}
