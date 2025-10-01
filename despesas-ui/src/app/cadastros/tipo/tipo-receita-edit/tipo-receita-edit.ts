import { ProgressSpinnerModule } from 'primeng/progressspinner';
import { TipoEdit } from './../tipo-edit/tipo-edit';
import { Component, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TipoReceitaService } from '../../../services/tipo-receita-service';
import { MessageService } from 'primeng/api';
import { TipoMovimentacao, TipoReceita } from '../../../models/tipo-movimentacao.model';

@Component({
  selector: 'app-tipo-receita-edit',
  imports: [TipoEdit, ProgressSpinnerModule],
  templateUrl: './tipo-receita-edit.html',
  styleUrl: './tipo-receita-edit.scss'
})
export class TipoReceitaEdit {

  private activatedRoute = inject(ActivatedRoute);
  private tipoReceitaService = inject(TipoReceitaService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  tipoReceita?: TipoReceita;
  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {

    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {

      this.tipoReceitaService.fetchById(parseInt(id))
        .subscribe((tipoReceita: TipoReceita) => {
          this.tipoReceita = tipoReceita;
          this.loading.set(false);
        });

    } else {
      this.loading.set(false);
    }

  }

  private returnView() {
    this.router.navigate(["tipo-receitas"]);
  }

  cancel() {
    this.returnView();
  }

  saveTipoReceita(tipo: TipoMovimentacao) {

    this.tipoReceitaService.createOrUpdate(tipo)
      .subscribe((_: TipoReceita) => {
        this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Tipo Receita salva com sucesso!', life: 3000 });
        this.returnView();
      });

  }

}
