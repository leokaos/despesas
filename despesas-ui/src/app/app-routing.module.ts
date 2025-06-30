import { TipoDespesasViewComponent } from './cadastros/tipo-despesas-view/tipo-despesas-view.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TipoReceitasViewComponent } from './cadastros/tipo-receitas-view/tipo-receitas-view.component';

const routes: Routes = [
  { path: 'tipo-despesas', component: TipoDespesasViewComponent },
  { path: 'tipo-receitas', component: TipoReceitasViewComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
