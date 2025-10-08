import { Component, OnInit, signal, inject, ChangeDetectorRef } from "@angular/core";
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
import { DecimalPipe } from "@angular/common";
import { AppProgressBar } from "../../components/app-progress-bar/app-progress-bar";
import { FontAwesomeModule } from "@fortawesome/angular-fontawesome";
import { ButtonModule } from "primeng/button";
import { ChartModule } from 'primeng/chart';
import { Grafico } from "../../models/dashboard.model";

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
  graficos: Grafico[] = [];

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
      metas: this.metaService.fetch(metaFiltro),
      graficos: this.dashboardService.fetchGraficos(this.dataInicial, this.dataFinal)
    }).subscribe((results: any) => {

      this.saldo = results.saldo;
      this.orcamentos = results.orcamentos;
      this.meta = results.metas[0] ? results.metas[0] : null;
      this.graficos = results.graficos;

      this.loading.set(false);
    });

  }

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

  convertBarra(grafico: any): any {
    return {
      labels: grafico.dados.map((item: any) => item.legenda),
      datasets: [
        {
          data: grafico.dados.map((item: any) => item.valor),
          backgroundColor: grafico.dados.map((item: any) => item.cor)
        }
      ],
    };
  }

  convertPizza(grafico: any): any {
    return {
      labels: grafico.dados.map((item: any) => item.legenda),
      datasets: [
        {
          data: grafico.dados.map((item: any) => item.valor),
          backgroundColor: grafico.dados.map((item: any) => item.cor)
        }
      ],
    };
  }

}
