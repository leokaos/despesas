import { FormsModule } from '@angular/forms';
import { ChangeDetectorRef, Component, inject, OnInit, signal } from '@angular/core';
import { SelectInterval } from "../../components/select-interval/select-interval";
import { Interval } from '../../models/interval.model';
import { PanelModule } from "primeng/panel";
import { ButtonModule } from "primeng/button";
import { DatePickerModule } from "primeng/datepicker";
import { SelectDebitavel } from "../../components/select-debitavel/select-debitavel";
import { Loader } from "../../components/loader/loader";
import { DebitavelService } from '../../services/debitavel-service';
import { Debitavel } from '../../models/debitavel.model';
import { ExtratoService } from '../../services/extrato-service';
import { Extrato } from '../../models/extrato.model';
import { ChartModule } from "primeng/chart";

@Component({
  selector: 'app-extrato-mensal',
  imports: [PanelModule, ButtonModule, DatePickerModule, FormsModule, SelectDebitavel, Loader, SelectInterval, ChartModule],
  templateUrl: './extrato-mensal.html',
  styleUrl: './extrato-mensal.scss'
})
export class ExtratoMensal implements OnInit {

  loading = signal<boolean>(true);

  dataInicial?: Date;
  dataFinal?: Date;
  debitaveis: Debitavel[] = [];
  debitavel?: Debitavel;

  data: any;

  color: any = {
    'saidas': 'rgb(31, 119, 180)',
    'entradas': 'rgb(174, 199, 232)',
    'transferenciaEntrada': 'rgb(255, 127, 14)',
    'transferenciaSaida': 'rgb(255, 187, 120)'
  }

  private debitavelService = inject(DebitavelService);
  private extratoService = inject(ExtratoService);
  private cd = inject(ChangeDetectorRef);

  constructor() { }

  ngOnInit(): void {
    this.debitavelService.fetch({ ativo: true }).subscribe((data) => {
      this.debitaveis = data;
      this.loading.set(false);
    })
  }

  filter() {

    this.extratoService.fetch(this.dataInicial, this.dataFinal, this.debitavel).subscribe((data: Extrato[]) => {

      this.data = {
        labels: data.map(item => `${item.mes}/${item.ano}`),
        datasets: ['saidas', 'entradas', 'transferenciaEntrada', 'transferenciaSaida'].map(label => ({
          label,
          data: data.map((item: any) => item[label]),
          backgroundColor: this.color[label]
        }))
      };

      this.cd.markForCheck();
    })
  }

  setDates(interval: Interval) {
    this.dataInicial = interval.getDataInicial();
    this.dataFinal = interval.getDataFinal();
  }

}
