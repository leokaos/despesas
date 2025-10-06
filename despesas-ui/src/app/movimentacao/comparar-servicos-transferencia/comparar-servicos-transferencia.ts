import { CotacaoFiltro, CotacaoService } from './../../services/cotacao-service';
import { ServicoTransferenciaService } from './../../services/servico-transferencia-service';
import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { PanelModule } from 'primeng/panel';
import { ButtonModule } from 'primeng/button';
import { DatePickerModule } from 'primeng/datepicker';
import { DividerModule } from 'primeng/divider';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ParametroService } from '../../services/parametro-service';
import { forkJoin } from 'rxjs';
import { Loader } from '../../components/loader/loader';
import { ServicoTransferencia } from '../../models/servico-transferencia.model';
import { DialogModule } from 'primeng/dialog';
import { TableModule } from 'primeng/table';
import { SelectMoeda } from '../../components/select-moeda/select-moeda';
import { Debitavel, Moeda } from '../../models/debitavel.model';
import { Cotacao } from '../../models/cotacao.model';
import { CardModule } from 'primeng/card';
import { SelectDebitavel } from '../../components/select-debitavel/select-debitavel';
import { DebitavelFiltro, DebitavelService } from '../../services/debitavel-service';
import { TransferenciaService } from '../../services/transferencia-service';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-comparar-servicos-transferencia',
  imports: [
    PanelModule,
    ButtonModule,
    DatePickerModule,
    DividerModule,
    InputGroupModule,
    InputNumberModule,
    InputGroupAddonModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    Loader,
    DialogModule,
    TableModule,
    SelectMoeda,
    CardModule,
    SelectDebitavel,
  ],
  templateUrl: './comparar-servicos-transferencia.html',
  styleUrl: './comparar-servicos-transferencia.scss',
})
export class CompararServicosTransferencia implements OnInit {
  iof?: number;
  spot?: number;
  valor: number = 0;
  cotacao?: Cotacao;
  taxa: number = 0;
  moedaOrigem?: Moeda;
  moedaDestino?: Moeda;
  servicos: ServicoTransferencia[] = [];
  cotacoes: Cotacao[] = [];
  debitavel?: Debitavel;
  creditavel?: Debitavel;
  debitaveis: Debitavel[] = [];
  servicosSelecionados: ServicoTransferencia[] = [];
  servicoSelecionado?: ServicoTransferencia;

  showDialogServicos: boolean = false;
  showDialogCotacao: boolean = false;
  showDialogEfetuar: boolean = false;

  loading = signal<boolean>(true);
  loadingCotacoes = signal<boolean>(false);

  private parametroService = inject(ParametroService);
  private servicoTransferenciaService = inject(ServicoTransferenciaService);
  private cotacaoService = inject(CotacaoService);
  private debitavelService = inject(DebitavelService);
  private transferenciaService = inject(TransferenciaService);
  private messageService = inject(MessageService);

  constructor() { }

  ngOnInit(): void {
    let debitavelFiltro = { ativo: true } as DebitavelFiltro;

    forkJoin({
      iof: this.parametroService.fetchIOF(),
      spot: this.parametroService.fetchSPOT(),
      servicos: this.servicoTransferenciaService.fetch(),
      debitaveis: this.debitavelService.fetch(debitavelFiltro),
    }).subscribe((results: any) => {
      this.iof = results.iof;
      this.spot = results.spot;
      this.servicos = results.servicos;
      this.debitaveis = results.debitaveis;

      this.loading.set(false);
    });
  }

  getServicosNaoSelecionados(): ServicoTransferencia[] {
    return this.servicos.filter(
      (servico) => !this.servicosSelecionados.find((innerServico) => innerServico.id === servico.id)
    );
  }

  addServico(servico: ServicoTransferencia) {
    this.servicosSelecionados.push(servico);
  }

  openCotacaoDialog() {
    this.showDialogCotacao = true;
    this.cotacoes = [];
    this.loadingCotacoes.set(true);
  }

  buscarCotacao() {
    let filtro = {
      data: new Date(),
      origem: this.moedaOrigem,
      destino: this.moedaDestino,
    } as CotacaoFiltro;

    this.cotacaoService.fetch(filtro).subscribe((cotacoes: Cotacao[]) => {
      this.cotacoes = cotacoes;
      this.loadingCotacoes.set(false);
    });
  }

  setCotacao(cotacao: Cotacao) {
    this.cotacao = cotacao;
    this.taxa = cotacao.taxa;
    this.showDialogCotacao = false;
  }

  calcularTotalBruto(servico: ServicoTransferencia): number {
    var cotacaoSemSpot = (this.cotacao?.taxa || 0) - (this.spot || 0);

    var cotacaoDepoisSpred =
      Math.round((cotacaoSemSpot * (1 - servico.spred / 100) + Number.EPSILON) * 100) / 100;

    return cotacaoDepoisSpred * this.valor;
  }

  calcularTotalLiquido(servico: ServicoTransferencia): number {
    var totalBruto = this.calcularTotalBruto(servico);

    if (totalBruto <= 0.0) {
      return 0.0;
    }

    return totalBruto * (1 - (this.iof || 1) / 100) - servico.taxas;
  }

  openDialog(servico: ServicoTransferencia) {
    this.servicoSelecionado = servico;
    this.showDialogEfetuar = true;
  }

  efetuar() {

    if (this.servicoSelecionado && this.debitavel && this.creditavel && this.cotacao) {

      this.transferenciaService.createRemessa(
        this.servicoSelecionado,
        this.debitavel,
        this.creditavel,
        this.cotacao,
        this.valor
      ).subscribe((_) => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Remessa criada com sucesso!', life: 3000 });
        this.showDialogEfetuar = false;
        this.servicosSelecionados = [];
      });

    }
  }

  calcularPercentualCusto(servico: ServicoTransferencia): number {
    const custoTotal = servico.taxas + (this.calcularTotalBruto(servico) * servico.spred / 100);
    return (custoTotal / this.calcularTotalBruto(servico)) * 100;
  }

  getTaxaBadgeClass(servico: ServicoTransferencia): string {
    return servico.custoVariavel
      ? 'bg-orange-100 text-orange-800 border border-orange-200'
      : 'bg-green-100 text-green-800 border border-green-200';
  }

}
