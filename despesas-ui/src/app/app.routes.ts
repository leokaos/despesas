import { Routes } from '@angular/router';
import { TipoDespesasView } from './cadastros/tipo/tipo-despesas-view/tipo-despesas-view';
import { TipoReceitasView } from './cadastros/tipo/tipo-receitas-view/tipo-receitas-view';
import { TipoDespesaEdit } from './cadastros/tipo/tipo-despesa-edit/tipo-despesa-edit';
import { TipoReceitaEdit } from './cadastros/tipo/tipo-receita-edit/tipo-receita-edit';
import { ContaView } from './cadastros/debitavel/conta-view/conta-view';
import { ContaEdit } from './cadastros/debitavel/conta-edit/conta-edit';
import { MetaView } from './cadastros/meta/meta-view/meta-view';
import { MetaEdit } from './cadastros/meta/meta-edit/meta-edit';
import { OrcamentoView } from './cadastros/orcamento/orcamento-view/orcamento-view';

export const routes: Routes = [
  { path: 'tipo-despesas', component: TipoDespesasView },
  { path: 'tipo-receitas', component: TipoReceitasView },
  { path: 'tipo-despesa', component: TipoDespesaEdit },
  { path: 'tipo-despesa/:id', component: TipoDespesaEdit },
  { path: 'tipo-receita', component: TipoReceitaEdit },
  { path: 'tipo-receita/:id', component: TipoReceitaEdit },
  { path: 'contas', component: ContaView },
  { path: 'conta', component: ContaEdit },
  { path: 'conta/:id', component: ContaEdit },
  { path: 'metas', component: MetaView },
  { path: 'meta', component: MetaEdit },
  { path: 'meta/:id', component: MetaEdit },
  { path: 'orcamentos', component: OrcamentoView },
];
