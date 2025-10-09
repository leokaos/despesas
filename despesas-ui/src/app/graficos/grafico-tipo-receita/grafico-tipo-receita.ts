import { ChangeDetectorRef, Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { ChartModule } from 'primeng/chart';
import { DatePickerModule } from 'primeng/datepicker';
import { PanelModule } from 'primeng/panel';
import { SelectInterval } from '../../components/select-interval/select-interval';
import { GraficoService } from '../../services/grafico-service';
import { Interval } from '../../models/interval.model';
import { GraficoLinha, Serie } from '../../models/grafico.model';

@Component({
  selector: 'app-grafico-tipo-receita',
  imports: [PanelModule, DatePickerModule, SelectInterval, ButtonModule, ChartModule, FormsModule],
  templateUrl: './grafico-tipo-receita.html',
  styleUrl: './grafico-tipo-receita.scss'
})
export class GraficoTipoReceita {

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

    this.graficoService.fetchReceitas(this.dataInicial, this.dataFinal).subscribe((data: GraficoLinha) => {

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
