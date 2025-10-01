import { TipoDespesa, TipoMovimentacao } from './../../../models/tipo-movimentacao.model';
import { Component, inject, OnInit, signal } from '@angular/core';
import { TipoEdit } from '../tipo-edit/tipo-edit';
import { ActivatedRoute, Router } from '@angular/router';
import { TipoDespesaService } from '../../../services/tipo-despesa-service';
import { MessageService } from 'primeng/api';
import { Loader } from '../../../components/loader/loader';

@Component({
  selector: 'app-tipo-despesa-edit',
  imports: [TipoEdit, Loader],
  templateUrl: './tipo-despesa-edit.html',
  styleUrl: './tipo-despesa-edit.scss',
})
export class TipoDespesaEdit implements OnInit {
  private activatedRoute = inject(ActivatedRoute);
  private tipoDespesaService = inject(TipoDespesaService);
  private router = inject(Router);
  private messageService = inject(MessageService);

  tipoDespesa?: TipoDespesa;
  loading = signal<boolean>(true);

  constructor() {}

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.tipoDespesaService.fetchById(parseInt(id)).subscribe((tipoDespesa: TipoDespesa) => {
        this.tipoDespesa = tipoDespesa;
        this.loading.set(false);
      });
    } else {
      this.loading.set(false);
    }
  }

  private returnView() {
    this.router.navigate(['tipo-despesas']);
  }

  cancel() {
    this.returnView();
  }

  saveTipoDespesa(tipo: TipoMovimentacao) {
    // prettier-ignore
    this.tipoDespesaService.createOrUpdate(tipo).subscribe((_: TipoDespesa) => {
      this.messageService.add({severity: 'success', summary: 'Sucesso', detail: 'Tipo Despesa salva com sucesso!', life: 3000 });
      this.returnView();
    });
  }
}
