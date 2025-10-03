import { TipoMovimentacao, TipoReceita } from './../../../models/tipo-movimentacao.model';
import { TipoReceitaService } from './../../../services/tipo-receita-service';
import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { MessageService } from 'primeng/api';
import { TipoView } from '../tipo-view/tipo-view';
import { Router } from '@angular/router';
import { Loader } from '../../../components/loader/loader';

@Component({
  selector: 'app-tipo-receitas-view',
  imports: [TipoView, CommonModule, Loader],
  templateUrl: './tipo-receitas-view.html',
  styleUrl: './tipo-receitas-view.scss',
})
export class TipoReceitasView implements OnInit {
  data: TipoReceita[] = [];
  loading = signal<boolean>(true);

  private tipoReceitaService = inject(TipoReceitaService);
  private messageService = inject(MessageService);
  private router = inject(Router);

  constructor() {}

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.tipoReceitaService.fetch().subscribe((data: TipoReceita[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  removerTipoReceita(tipoReceita: TipoReceita) {
    // prettier-ignore
    this.tipoReceitaService.remove(tipoReceita)
      .subscribe(() => {
        this.messageService.add({ severity: 'success', summary: 'Successo', detail: 'Tipo Receita removida com sucesso!', life: 3000 });
        this.loadData();
      });
  }

  reload() {
    this.loading.set(true);
    this.loadData();
  }

  editTipoReceita(tipoReceita: TipoMovimentacao) {
    this.router.navigate(['tipo-receita', tipoReceita.id]);
  }

  adicionarTipoReceita() {
    this.router.navigate(['tipo-receita']);
  }
}
