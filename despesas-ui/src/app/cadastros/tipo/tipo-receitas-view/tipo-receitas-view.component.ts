import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { TipoReceitaService } from '../../../services/tipo-receita.service';
import { TipoReceita } from '../../../models/tipo-movimentacao.model';

@Component({
  selector: 'app-tipo-receitas-view',
  templateUrl: './tipo-receitas-view.component.html',
  styleUrl: './tipo-receitas-view.component.scss'
})
export class TipoReceitasViewComponent {

  data: TipoReceita[] = [];

  constructor(private tipoReceitaService: TipoReceitaService, private messageService: MessageService) { }

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {

    this.tipoReceitaService.buscarTipoReceitas().subscribe((data: TipoReceita[]) => {
      this.data = [...data];
    });

  }

  removerTipoReceita(tipoReceita: TipoReceita) {

    this.tipoReceitaService.removerTipoReceita(tipoReceita).subscribe(() => {
      this.messageService.add({ severity: 'success', summary: 'Success', detail: 'Tipo receita removida com sucesso!' });
      this.loadData();
    });

  }

}
