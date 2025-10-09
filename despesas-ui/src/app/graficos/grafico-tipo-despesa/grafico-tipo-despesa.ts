import { GraficoService } from './../../services/grafico-service';
import { ChangeDetectorRef, Component, inject } from '@angular/core';
import { PanelModule } from "primeng/panel";
import { DatePickerModule } from "primeng/datepicker";
import { SelectInterval } from "../../components/select-interval/select-interval";
import { ButtonModule } from "primeng/button";
import { ChartModule } from "primeng/chart";
import { FormsModule } from '@angular/forms';
import { Interval } from '../../models/interval.model';
import { GraficoLinha, Serie } from '../../models/grafico.model';

@Component({
  selector: 'app-grafico-tipo-despesa',
  imports: [PanelModule, DatePickerModule, SelectInterval, ButtonModule, ChartModule, FormsModule],
  templateUrl: './grafico-tipo-despesa.html',
  styleUrl: './grafico-tipo-despesa.scss'
})
export class GraficoTipoDespesa {

  dataInicial?: Date;
  dataFinal?: Date;

  data: any;

  private graficoService = inject(GraficoService);
  private cd = inject(ChangeDetectorRef);

  constructor() { }

  setDates(interval: Interval) {
    this.dataInicial = interval.getDataInicial();
    this.dataFinal = interval.getDataFinal();
  }

  filter() {

    this.graficoService.fetchDespesas(this.dataInicial, this.dataFinal).subscribe((data: GraficoLinha) => {

      let labels = [...new Set(data.series.flatMap(serie => serie.pontos.map(ponto => ponto.x)))].sort();

      this.data = {
        labels: labels.map(item => this.getFormattedDate(item)),
        datasets: data.series.map((serie: Serie) => {
          return {
            label: serie.nome,
            borderColor: serie.cor,
            data: labels.map(item => serie.pontos.find(p => p.x === item)?.y || 0)
          }
        })
      };

      this.cd.markForCheck();

    });
  }

  private getFormattedDate(item: number): string {
    let date = new Date(item);
    return `${date.getMonth() + 1}/${date.getFullYear()}`;
  }

}
