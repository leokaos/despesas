import { Periodo } from './../../../models/periodo.model';
import { FeriadoFiltro, FeriadoService } from './../../../services/feriado-service';
import { Component, inject, OnInit, signal, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from "primeng/button";
import { Table, TableModule } from 'primeng/table';
import { Feriado } from '../../../models/feriado.model';
import { DecimalPipe, DatePipe } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ColorPickerModule } from 'primeng/colorpicker';
import { DialogModule } from 'primeng/dialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { Loader } from '../../../components/loader/loader';
import { PanelModule } from 'primeng/panel';
import { FloatLabelModule } from 'primeng/floatlabel';
import { DatePickerModule } from 'primeng/datepicker';
import { DateUtil, PeriodoUtil } from '../../../models/util';
import { PeriodoView } from "../../../components/periodo-view/periodo-view";
import { Mes } from '../../../models/mes.model';

@Component({
  selector: 'app-feriado-view',
  imports: [
    PanelModule,
    ButtonModule,
    PeriodoView,
    FormsModule,
    Loader,
    TableModule,
    IconFieldModule,
    InputIconModule,
    DialogModule,
    DatePipe,
    InputTextModule,
],
  templateUrl: './feriado-view.html',
  styleUrl: './feriado-view.scss'
})
export class FeriadoView implements OnInit {

  @ViewChild('table')
  private table?: Table;

  loading = signal<boolean>(true);
  data = signal<Feriado[]>([]);
  searchValue?: string;
  showDialog: boolean = false;
  feriado?: Feriado;
  periodo?: Periodo;

  private feriadoService = inject(FeriadoService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  readonly TIPO_LABELS: { [key in 'FERIAS' | 'FERIADO' | 'FECHADO']: string } = {
    FERIAS: 'Férias',
    FERIADO: 'Feriado',
    FECHADO: 'Fechado'
  };

  constructor() { }

  ngOnInit(): void {

    this.periodo = {
      mes: Mes.getMesAtual(),
      ano: new Date().getFullYear(),
    } as Periodo;

    this.loadData();
  }

  loadData() {
    let filtro = {
      dataInicial: PeriodoUtil.getDataInicial(this.periodo!),
      dataFinal: PeriodoUtil.getDataFinal(this.periodo!),
    } as FeriadoFiltro;

    this.feriadoService.fetch(filtro).subscribe((data: Feriado[]) => {
      this.data.update(_ => [...data]);
      this.loading.set(false);
    });
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  filter() {
    this.loading.set(true);
    this.loadData();
  }

  reset() {

    this.periodo = {
      mes: Mes.getMesAtual(),
      ano: new Date().getFullYear(),
    } as Periodo;

    this.reload();
  }

  add() {
    this.router.navigate(['feriado']);
  }

  edit(feriado: Feriado) {
    this.router.navigate(['feriado', feriado.id]);
  }

  search() {
    this.table?.filterGlobal(this.searchValue, 'contains');
  }

  openDialog(feriado: Feriado) {
    this.showDialog = true;
    this.feriado = feriado;
  }

  remover() {
    if (this.feriado) {
      this.feriadoService.remove(this.feriado).subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Feriado removido com sucesso!', life: 3000 });
        this.loadData();
      });
    }

    this.showDialog = false;
  }

  getTipoLabel(tipo: Feriado['tipo']): string {
    return this.TIPO_LABELS[tipo];
  }

}
