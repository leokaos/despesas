import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { TipoReceita } from '../models/tipo-movimentacao.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TipoReceitaService {

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  buscarTipoReceitas(): Observable<TipoReceita[]> {
    return this.http.get<TipoReceita[]>(`${this.config.apiUrl}/tiporeceita`);
  }

  removerTipoReceita(tipoReceita: TipoReceita) {
    return this.http.delete(`${this.config.apiUrl}/tiporeceita/${tipoReceita.id}`);
  }
}
