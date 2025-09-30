import { TipoMovimentacao, TipoReceita } from './../../../models/tipo-movimentacao.model';
import { TipoReceitaService } from './../../../services/tipo-receita-service';
import { CommonModule } from '@angular/common';
import { ChangeDetectorRef, Component, inject, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';
import { TipoView } from '../tipo-view/tipo-view';
import { Router } from '@angular/router';

@Component({
  selector: 'app-tipo-receitas-view',
  imports: [TipoView, CommonModule],
  providers: [MessageService],
  templateUrl: './tipo-receitas-view.html',
  styleUrl: './tipo-receitas-view.scss'
})
export class TipoReceitasView implements OnInit {

  data: TipoReceita[] = [];
  loading: boolean = true;

  private tipoReceitaService = inject(TipoReceitaService);
  private messageService = inject(MessageService);
  private cdRef = inject(ChangeDetectorRef);
  private router = inject(Router);

  constructor() { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    this.tipoReceitaService.buscarTipoReceitas().subscribe((data: TipoReceita[]) => {
      this.data = [...data];
      this.loading = false;
      this.cdRef.detectChanges();
    });

  }

  removerTipoReceita(tipoReceita: TipoReceita) {

    this.tipoReceitaService.removerTipoReceita(tipoReceita).subscribe(() => {
      this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Tipo Receita removida com sucesso!' });
      this.loadData();
    });

  }

  editTipoReceita(TipoReceita: TipoMovimentacao) {
    this.router.navigate(["tipo-receita", TipoReceita.id]);
  }

  adicionarTipoReceita() {
    this.router.navigate(["tipo-receita"]);
  }
}
