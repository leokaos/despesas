import { Component, OnInit, signal, inject } from "@angular/core";
import { forkJoin } from "rxjs";
import { Moeda } from "../../models/debitavel.model";
import { Mes } from "../../models/mes.model";
import { Orcamento } from "../../models/orcamento.model";
import { DateUtil } from "../../models/util";
import { DashboardService } from "../../services/dashboard-service";
import { MetaService, MetaFiltro } from "../../services/meta-service";
import { OrcamentoService, OrcamentoFiltro } from "../../services/orcamento-service";
import { faArrowUp, faArrowDown } from '@fortawesome/free-solid-svg-icons';
import { Meta } from "../../models/meta.model";
import { CommonModule, DecimalPipe } from "@angular/common";
import { AppProgressBar } from "../../components/app-progress-bar/app-progress-bar";
import { FontAwesomeModule } from "@fortawesome/angular-fontawesome";
import { ButtonModule } from "primeng/button";
import { ChartModule } from 'primeng/chart';


@Component({
  selector: 'app-dashboard',
  imports: [DecimalPipe, AppProgressBar, FontAwesomeModule, ButtonModule, ChartModule],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.scss'
})
export class Dashboard implements OnInit {

  readonly faArrowUp = faArrowUp;
  readonly faArrowDown = faArrowDown;

  dataInicial: Date = DateUtil.getCurrentDataInicial();
  dataFinal: Date = DateUtil.getCurrentDataFinal();

  mes: number = this.dataInicial.getMonth();
  ano: number = this.dataInicial.getFullYear();

  saldo?: number;
  orcamentos: Orcamento[] = [];
  meta?: Meta;

  loading = signal<boolean>(true);

  private metaService = inject(MetaService);
  private orcamentoService = inject(OrcamentoService);
  private dashboardService = inject(DashboardService);

  readonly Mes = Mes;

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {

    this.loading.set(true);

    this.dataInicial = new Date(Date.UTC(this.ano, this.mes, 1));
    this.dataFinal = new Date(Date.UTC(this.ano, this.mes + 1, 0, 23, 59, 59));

    let orcamentoFiltro = {
      dataInicial: this.dataInicial,
      dataFinal: this.dataFinal
    } as OrcamentoFiltro;

    let metaFiltro = {
      mes: this.mes + 1,
      ano: this.ano,
    } as MetaFiltro;

    forkJoin({
      saldo: this.dashboardService.fetchSaldo(this.dataInicial, this.dataFinal),
      orcamentos: this.orcamentoService.fetch(orcamentoFiltro),
      metas: this.metaService.fetch(metaFiltro)
    }).subscribe((results: any) => {

      this.saldo = results.saldo;
      this.orcamentos = results.orcamentos;
      this.meta = results.metas[0] ? results.metas[0] : null;

      this.loading.set(false);
    });

  }

  debitaveis = [
    {
      "limite": 10000.00,
      "bandeira": "VISA",
      "limiteAtual": null,
      "diaDeVencimento": 25,
      "diaDeFechamento": 10,
      "tipo": "CARTAO",
      "saldo": 10000.00,
      "id": 8,
      "descricao": "Porto Seguro",
      "cor": "#0058e6",
      "ativo": true,
      "moeda": Moeda.REAL
    },
    {
      "tipo": "CONTA",
      "saldo": 10000.00,
      "id": 25,
      "descricao": "Itaú",
      "cor": "#a68312",
      "ativo": true,
      "moeda": Moeda.REAL
    },
    {
      "tipo": "CONTA",
      "saldo": 500.00,
      "id": 26,
      "descricao": "N26",
      "cor": "#3fa183",
      "ativo": true,
      "moeda": Moeda.EURO
    }
  ]

  graficos: any[] = [
    {
      "tipoGrafico": "PIZZA",
      "dados": [],
      "titulo": "Despesas Por Tipo"
    },
    {
      "tipoGrafico": "PIZZA",
      "dados": [],
      "titulo": "Receitas Por Tipo"
    },
    {
      "tipoGrafico": "BARRAS",
      "dados": [
        {
          "legenda": "Receitas",
          "valor": 0,
          "cor": "#42E87D"
        },
        {
          "legenda": "Despesas",
          "valor": 0,
          "cor": "#F54047"
        },
        {
          "legenda": "Transferências",
          "valor": 0,
          "cor": "#706EBB"
        }
      ],
      "titulo": "Extrato Mensal"
    }
  ];

  isSaldoNegativo(): boolean {
    return (this.saldo || 0) < 0;
  }

  isSaldoPositivo(): boolean {
    return (this.saldo || 0) > 0;
  }

  anterior() {
    if (this.mes == 0) {
      this.mes = 11;
      this.ano--;
    } else {
      this.mes--;
    }

    this.loadData();
  }

  posterior() {
    if (this.mes == 11) {
      this.mes = 0;
      this.ano++;
    } else {
      this.mes++;
    }

    this.loadData();
  }

}