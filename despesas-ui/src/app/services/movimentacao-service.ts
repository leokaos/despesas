import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Movimentacao } from '../models/movimentacao.model';

export interface MovimentacaoFiltro {
  dataInicial: Date,
  dataFinal: Date
}

@Injectable({
  providedIn: 'root'
})
export class MovimentacaoService {
  private readonly path: string = 'movimentacao';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: MovimentacaoFiltro): Observable<Movimentacao[]> {

    let params = new HttpParams()
      .append("dataInicial", filtro.dataInicial.toUTCString())
      .append("dataFinal", filtro.dataFinal.toUTCString());

    return this.http.get<Movimentacao[]>(`${this.config.apiUrl}/${this.path}/buscarPorPeriodo`, { params: params });
  }
}
