import { Component, inject, OnInit, signal } from '@angular/core';
import { DividaService } from '../../../services/divida-service';
import { ActivatedRoute, Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { concatMap, forkJoin } from 'rxjs';
import { Conta, Debitavel, Divida } from '../../../models/debitavel.model';
import { Transferencia } from '../../../models/movimentacao.model';
import { Loader } from "../../../components/loader/loader";
import { TableModule } from "primeng/table";
import { ColorDisplay } from "../../../components/color-display/color-display";
import { DatePipe, DecimalPipe } from '@angular/common';
import { SumPipe } from '../../../pipes/sum-pipe';
import { ButtonModule } from "primeng/button";
import { Dialog } from "primeng/dialog";
import { DatePicker } from "primeng/datepicker";
import { Select } from "primeng/select";
import { DebitavelFiltro, DebitavelService } from '../../../services/debitavel-service';
import { ContaService } from '../../../services/conta-service';
import { SelectDebitavel } from "../../../components/select-debitavel/select-debitavel";
import { InputGroup } from "primeng/inputgroup";
import { InputGroupAddon } from "primeng/inputgroupaddon";
import { InputNumber } from "primeng/inputnumber";
import { TransferenciaService } from '../../../services/transferencia-service';
import { FormsModule } from "@angular/forms";

@Component({
  selector: 'app-aportes-view',
  imports: [
    Loader,
    TableModule,
    ColorDisplay,
    DatePipe,
    DecimalPipe,
    SumPipe,
    ButtonModule,
    Dialog,
    DatePicker,
    SelectDebitavel,
    InputGroup,
    InputGroupAddon,
    InputNumber,
    FormsModule
  ],
  templateUrl: './aportes-view.html',
  styleUrl: './aportes-view.scss'
})
export class AportesView implements OnInit {

  loading = signal<boolean>(true);
  salvando = signal<boolean>(false);
  showDialog = signal<boolean>(false);

  divida?: Divida;
  transferencias = signal<Transferencia[]>([]);
  debitaveis: Debitavel[] = [];
  transferencia: Transferencia = {} as Transferencia;

  private dividaService = inject(DividaService);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private debitavelService = inject(DebitavelService);
  private transferenciaService = inject(TransferenciaService);
  private router = inject(Router);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  private loadData() {

    this.loading.set(true);

    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {

      this.dividaService.fetchById(parseInt(id)).pipe(
        concatMap((divida: Divida) => {

          this.divida = divida;

          let debitavelFiltro = { moeda: divida.moeda, ativo: true } as DebitavelFiltro;

          return forkJoin({
            transferencias: this.dividaService.fetchPagamentos(divida.id),
            debitaveis: this.debitavelService.fetch(debitavelFiltro),
          });

        })).subscribe(({ transferencias, debitaveis }) => {
          this.transferencias.set(transferencias);
          this.debitaveis = debitaveis.filter(d => d.id !== this.divida?.id);
          this.loading.set(false);
        });

    } else {
      this.messageService.add({ severity: 'error', summary: 'Erro', detail: 'Dívida não encontrada!', life: 3000 });
      this.router.navigate(['dividas']);
    }
  }

  openNovoAporteDialog() {

    this.showDialog.set(true);

    this.transferencia = {
      valor: this.divida?.valorRestante,
      creditavel: this.divida as Debitavel,
      vencimento: new Date(),
      descricao: `Aporte em ${this.divida?.descricao}`,
      moeda: this.divida?.moeda,
    } as Transferencia;

  }

  salvar() {

    this.salvando.set(true);

    this.transferenciaService.createOrUpdate(this.transferencia).subscribe(_ => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Transrência salva com sucesso!', life: 3000 });
      this.salvando.set(false);
      this.showDialog.set(false);
      this.loadData();
    });
  }

  returnToView() {
    this.router.navigate(['dividas']);
  }

}