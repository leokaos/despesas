import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HeaderComponent } from './header/header.component';

import { ButtonModule } from 'primeng/button';
import { PanelModule } from 'primeng/panel';
import { TableModule } from 'primeng/table';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { ColorPickerModule } from 'primeng/colorpicker';
import { DialogModule } from 'primeng/dialog';
import { ToastModule } from 'primeng/toast';
import { ProgressSpinnerModule } from 'primeng/progressspinner';

import { TipoDespesasViewComponent } from './cadastros/tipo-despesas-view/tipo-despesas-view.component';
import { TipoReceitasViewComponent } from './cadastros/tipo-receitas-view/tipo-receitas-view.component';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { MessageService } from 'primeng/api';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    TipoDespesasViewComponent,
    TipoReceitasViewComponent
  ],
  imports: [
    BrowserAnimationsModule,
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    ButtonModule,
    PanelModule,
    TableModule,
    IconFieldModule,
    InputIconModule,
    InputTextModule,
    ColorPickerModule,
    DialogModule,
    ToastModule,
    ProgressSpinnerModule
  ],
  providers: [
    provideHttpClient(withInterceptorsFromDi()),
    MessageService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
