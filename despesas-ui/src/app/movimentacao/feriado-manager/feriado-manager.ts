import { Component, inject, OnInit, signal } from '@angular/core';
import { FeriadoService } from '../../services/feriado-service';
import { Feriado } from '../../models/feriado.model';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { DialogModule } from 'primeng/dialog';
import { DatePickerModule } from 'primeng/datepicker';
import { InputTextModule } from 'primeng/inputtext';
import { FormsModule } from '@angular/forms';
import { SplitButtonModule } from 'primeng/splitbutton';
import { SelectModule } from 'primeng/select';
import { Loader } from "../../components/loader/loader";
import { AppProgressBar } from '../../components/app-progress-bar/app-progress-bar';
import { concatMap, finalize, from, tap } from 'rxjs';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-feriado-manager',
  imports: [
    ButtonModule,
    TableModule,
    SelectModule,
    DialogModule,
    DatePickerModule,
    InputTextModule,
    FormsModule,
    SplitButtonModule,
    AppProgressBar,
    Loader
  ],
  templateUrl: './feriado-manager.html',
  styleUrl: './feriado-manager.scss'
})
export class FeriadoManager implements OnInit {

  tipos = [
    { label: 'Férias', value: 'FERIAS' },
    { label: 'Feriado', value: 'FERIADO' },
    { label: 'Fechado', value: 'FECHADO' }
  ];

  acoes = [
    { label: 'Buscar da API', icon: 'pi pi-cloud', command: () => this.showApiDialog = true },
    { label: 'Adicionar Range', icon: 'pi pi-calendar', command: () => this.showRangeDialog = true },
    { label: 'Adicionar Unitário', icon: 'pi pi-plus', command: () => this.showUnitDialog = true }
  ];

  loading = signal<boolean>(false);

  total = signal<number>(0);
  parcial = signal<number>(0);

  feriados: Feriado[] = [];

  showApiDialog = false;
  showRangeDialog = false;
  showUnitDialog = false;
  showSaveDialog = false;

  ano?: number;
  tipo?: string;
  datas?: Date[];
  data?: Date;

  private feriadoService = inject(FeriadoService);
  private messageService = inject(MessageService);

  constructor() {
    this.ano = new Date().getFullYear();
  }

  ngOnInit(): void { }

  remover(index: number) {
    this.feriados.splice(index, 1);
  }

  getTipoLabel(tipo: any) {
    return this.tipos.find(o => o.value === tipo)?.label || tipo;
  }

  buscarPelaApi() {

    if (this.ano && this.tipo) {

      this.loading.set(true);

      this.feriadoService.fetchExterno(this.ano, this.tipo).subscribe(feriados => {
        this.feriados = [...this.feriados, ...feriados];
        this.loading.set(false);
        this.showApiDialog = false;
      });

    }
  }

  gerarPorRange() {

    if (this.datas?.length == 2) {

      let feriados: Feriado[] = []
      let dataAtual = new Date(this.datas[0]);
      const dataFinal = this.datas[1];

      while (dataAtual <= dataFinal) {
        feriados.push({ nome: this.tipo, data: new Date(dataAtual), tipo: this.tipo } as Feriado);
        dataAtual.setDate(dataAtual.getDate() + 1);
      }

      this.feriados = [...this.feriados, ...feriados];
      this.showRangeDialog = false;
    }

  }

  adicionarUnitario() {
    if (this.data) {
      this.feriados.push({ nome: this.tipo, data: new Date(this.data), tipo: this.tipo } as Feriado);
      this.showUnitDialog = false;
    }
  }

  isTodosFeriadosValidos(): boolean {
    return this.feriados && this.feriados.length > 0 && !this.feriados.find(feriado => !(feriado.tipo && feriado.data));
  }

  save() {
    this.total.set(this.feriados.length);
    this.parcial.set(0);

    from(this.feriados).pipe(
      concatMap(feriado => this.feriadoService.createOrUpdate(feriado).pipe(
        tap(() => {
          this.parcial.update(value => value + 1)
        })
      )),
      finalize(() => {

        this.showSaveDialog = false;

        if (this.parcial() === this.total()) {

          this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Despesas salvas com sucesso!' });

          this.feriados = [];
          this.total.set(0);
          this.parcial.set(0);
        }
      })).subscribe({
        error: (error) => this.messageService.add({ severity: 'error', summary: 'Erro', detail: `Erro ao salvar despesas: ${error.message}` })
      });

  }

}