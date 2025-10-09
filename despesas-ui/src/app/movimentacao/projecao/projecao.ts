import { ContaService } from './../../services/conta-service';
import { ChangeDetectorRef, Component, inject, OnInit, signal } from '@angular/core';
import { Conta } from '../../models/debitavel.model';
import { Loader } from "../../components/loader/loader";
import { PanelModule } from "primeng/panel";
import { InputNumberModule } from "primeng/inputnumber";
import { FormsModule } from '@angular/forms';
import { ButtonModule } from "primeng/button";
import { ChartModule } from "primeng/chart";
import { SelectDebitavel } from "../../components/select-debitavel/select-debitavel";
import { ProjecaoService } from '../../services/projecao-service';

@Component({
  selector: 'app-projecao',
  imports: [Loader, PanelModule, InputNumberModule, FormsModule, ButtonModule, ChartModule, SelectDebitavel],
  templateUrl: './projecao.html',
  styleUrl: './projecao.scss'
})
export class Projecao implements OnInit {

  loading = signal<boolean>(true);

  dataInicial?: Date;
  dataFinal?: Date;
  debitaveis: Conta[] = [];
  debitavel?: Conta;
  meses?: number;

  data: any;

  private contaService = inject(ContaService);
  private projecaoService = inject(ProjecaoService);
  private cd = inject(ChangeDetectorRef);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {
    this.contaService.fetch().subscribe(data => {
      this.debitaveis = data;

      this.loading.set(false);
    });
  }

  filter() {

    if (this.meses && this.debitavel) {

      this.projecaoService.fetch(this.meses, this.debitavel).subscribe(data => {

        this.data = {
          labels: data.itens.map((item: any) => this.getFormattedDate(item.data)),
          datasets: [{
            label: "Projeção",
            data: data.itens.map((item: any) => item.valor)
          }]
        }

        this.cd.markForCheck();
      });

    }
  }

  private getFormattedDate(item: number): string {
    let date = new Date(item);
    return `${date.getMonth() + 1}/${date.getFullYear()}`;
  }

}


