import { Routes } from '@angular/router';
import { TipoDespesasView } from './cadastros/tipo/tipo-despesas-view/tipo-despesas-view';
import { TipoReceitasView } from './cadastros/tipo/tipo-receitas-view/tipo-receitas-view';
import { TipoDespesaEdit } from './cadastros/tipo/tipo-despesa-edit/tipo-despesa-edit';
import { TipoReceitaEdit } from './cadastros/tipo/tipo-receita-edit/tipo-receita-edit';

export const routes: Routes = [
    { path: 'tipo-despesas', component: TipoDespesasView },
    { path: 'tipo-receitas', component: TipoReceitasView },
    { path: 'tipo-despesa', component: TipoDespesaEdit },
    { path: 'tipo-despesa/:id', component: TipoDespesaEdit },
    { path: 'tipo-receita', component: TipoReceitaEdit },
    { path: 'tipo-receita/:id', component: TipoReceitaEdit },
];
