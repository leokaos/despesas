import { ChangeDetectorRef, Component, inject, OnInit, signal } from '@angular/core';
import { PanelModule } from "primeng/panel";
import { DatePickerModule } from "primeng/datepicker";
import { Despesa, Receita } from '../../models/movimentacao.model';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SelectInterval } from "../../components/select-interval/select-interval";
import { ButtonModule } from "primeng/button";
import { Interval } from '../../models/interval.model';
import { Loader } from "../../components/loader/loader";
import { ChartModule } from "primeng/chart";
import { OrcamentoFiltro, OrcamentoService } from '../../services/orcamento-service';
import { Orcamento } from '../../models/orcamento.model';
import { TipoDespesa } from '../../models/tipo-movimentacao.model';
import { TipoDespesaService } from '../../services/tipo-despesa-service';
import { SelectTipoMovimentacao } from '../../components/select-tipo-movimentacao/select-tipo-movimentacao';

@Component({
  selector: 'app-comparacao-orcamento',
  imports: [
    PanelModule,
    DatePickerModule,
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    SelectInterval,
    ButtonModule,
    Loader,
    ChartModule,
    SelectTipoMovimentacao
  ],
  templateUrl: './comparacao-orcamento.html',
  styleUrl: './comparacao-orcamento.scss'
})
export class ComparacaoOrcamento implements OnInit {

  dataInicial?: Date;
  dataFinal?: Date;
  data: any;
  options: any;
  tipos: TipoDespesa[] = [];
  tipoSelecionado?: TipoDespesa;

  loading = signal<boolean>(false);

  private orcamentoService = inject(OrcamentoService);
  private tipoDespesaService = inject(TipoDespesaService);
  private cd = inject(ChangeDetectorRef);

  constructor() { }

  ngOnInit(): void {

    this.loading.set(true);

    this.tipoDespesaService.fetch().subscribe((tipos: TipoDespesa[]) => {
      this.tipos = tipos;
      this.loading.set(false);
    })
  }

  setDates(interval: Interval) {
    this.dataInicial = interval.getDataInicial();
    this.dataFinal = interval.getDataFinal();
  }

  generate() {

    let filtro = {
      dataFinal: this.dataFinal,
      dataInicial: this.dataInicial,
      tipo: this.tipoSelecionado,
    } as OrcamentoFiltro;

    this.orcamentoService.fetch(filtro).subscribe((orcamentos: Orcamento[]) => {

      let labels = orcamentos.map(o => `${o.tipoDespesa.descricao} para ${o.descricao}`);

      this.data = {
        labels: labels,
        datasets: [
          {
            label: 'Valor Orçado',
            backgroundColor: '#CCCCCC',
            data: orcamentos.map((orcamento: Orcamento) => orcamento.valor)
          },
          {
            label: 'Valor Gasto',
            backgroundColor: orcamentos.map(o => this.getCorBarra(o)),
            data: orcamentos.map((orcamento: Orcamento) => orcamento.valorConsolidado)
          },
        ]
      };

      this.options = {
        indexAxis: 'y',
        maintainAspectRatio: false,
        aspectRatio: 0.6,
        plugins: { legend: { labels: { color: '#000000' } } },
      };

      this.cd.markForCheck();
    });

  }

  getCorBarra(o: Orcamento): string {

    let percent = o.valorConsolidado / o.valor * 100;

    if (percent <= 70.0) {
      return '#5cb85c';
    } else if (percent > 70.0 && percent <= 95.0) {
      return '#f0ad4e';
    } else {
      return '#d9534f';
    }
  }

}