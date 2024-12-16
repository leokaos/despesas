import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { TipoDespesa } from '../models/tipo-movimentacao.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TipoDespesaService {

  constructor(
    @Inject(APP_CONFIG) private config: AppConfig,
    private http: HttpClient) { }

  buscarTipoDespesas(): Observable<TipoDespesa[]> {
    return this.http.get<TipoDespesa[]>(`${this.config.apiUrl}/tipodespesa`);
  }

  removerTipoDespesa(tipoDespesa: TipoDespesa) {
    return this.http.delete(`${this.config.apiUrl}/tipodespesa/${tipoDespesa.id}`);
  }
}
