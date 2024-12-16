import { TipoDespesasViewComponent } from './cadastros/tipo-despesas-view/tipo-despesas-view.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: 'tipo-despesas', component: TipoDespesasViewComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
