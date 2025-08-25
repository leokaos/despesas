import { TipoDespesaEditComponent } from './cadastros/tipo/tipo-despesa-edit/tipo-despesa-edit.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TipoDespesasViewComponent } from './cadastros/tipo/tipo-despesas-view/tipo-despesas-view.component';
import { TipoReceitasViewComponent } from './cadastros/tipo/tipo-receitas-view/tipo-receitas-view.component';
import { TipoReceitaEditComponent } from './cadastros/tipo/tipo-receita-edit/tipo-receita-edit.component';

const routes: Routes = [
  { path: 'tipo-despesas', component: TipoDespesasViewComponent },
  { path: 'tipo-receitas', component: TipoReceitasViewComponent },
  { path: 'tipo-despesa', component: TipoDespesaEditComponent },
  { path: 'tipo-receita', component: TipoReceitaEditComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
