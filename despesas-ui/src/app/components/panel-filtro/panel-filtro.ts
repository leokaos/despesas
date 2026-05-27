import { CommonModule } from '@angular/common';
import { Component, EventEmitter, inject, Input, OnInit, Output, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { SelectModule } from 'primeng/select';
import { Filtro } from '../../models/filtro.model';
import { FiltroService } from '../../services/filtro-service';
import { MessageService } from 'primeng/api';
import { DialogModule } from 'primeng/dialog';
import { FloatLabelModule } from 'primeng/floatlabel';
import { QueryService } from '../../services/query-service';

@Component({
  selector: 'app-panel-filtro',
  imports: [
    CommonModule,
    FormsModule,
    ButtonModule,
    SelectModule,
    InputTextModule,
    DialogModule,
    FloatLabelModule
  ],
  templateUrl: './panel-filtro.html',
  styleUrl: './panel-filtro.scss',
})
export class PanelFiltro implements OnInit {

  @Output()
  onSearch = new EventEmitter<string>();

  @Input()
  searching?: boolean = false

  @Input({ required: true })
  type!: string;

  @Input()
  disabled: boolean = false;

  filtros = signal<Filtro[]>([]);
  filtro = signal<Filtro | null>(null);

  private messageService = inject(MessageService);
  private filtroService = inject(FiltroService);
  private queryService = inject(QueryService);

  queryText: string = "";
  nome: string = "";

  showSalvar: boolean = false;
  showRemove: boolean = false;

  constructor() { }

  ngOnInit(): void {
    this.filtroService.fetch({ classe: this.type }).subscribe((filtros: Filtro[]) => {
      this.filtros.set([...filtros]);
    })
  }

  search() {
    if (this.queryText && this.queryText.trim().length > 0) {
      let queryComputada: string = this.queryService.process(this.queryText);
      this.onSearch.emit(queryComputada);
    }
  }

  clear() {
    this.queryText = '';
    this.filtro.set(null);
  }

  emitChange() {
    if (this.filtro()) {
      this.queryText = this.filtro()!.expressao;
    }
  }

  deletar() {

    const filtroAtual = this.filtro();

    if (!filtroAtual) return;

    this.filtroService.remove(filtroAtual).subscribe(_ => {
      this.filtros.update(filtros => filtros.filter(f => f.id !== filtroAtual.id));
      this.showRemove = false;
      this.queryText = '';
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Filtro removido com sucesso!' });
    });

  }

  salvar() {

    if (this.nome) {

      let newFiltro = {
        nome: this.nome,
        expressao: this.queryText,
        classe: this.type
      } as Filtro;

      this.internalSave(newFiltro);
    }
  }

  onClickSave() {

    if (this.filtro()) {

      let newFiltro = {
        ...this.filtro(),
        expressao: this.queryText
      } as Filtro;

      this.internalSave(newFiltro);

    } else {
      this.showSalvar = true
    }

  }

  private internalSave(filtro: Filtro) {

    this.filtroService.createOrUpdate(filtro).subscribe((filtro: Filtro) => {

      let newFiltros = this.filtros().filter(f => f.id !== filtro.id);
      newFiltros.push(filtro)

      this.filtros.set(newFiltros);
      this.filtro.set(filtro);

      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Filtro salvo com sucesso!' });
      this.showSalvar = false;
    });

  }

}
