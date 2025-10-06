import { Inject, Injectable } from '@angular/core';
import { Moeda } from '../models/debitavel.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, map } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Cotacao } from '../models/cotacao.model';

export interface CotacaoFiltro {
  origem: Moeda;
  destino: Moeda;
  data: Date;
}

@Injectable({
  providedIn: 'root'
})
export class CotacaoService {
  private readonly path: string = 'cotacao';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro?: CotacaoFiltro): Observable<Cotacao[]> {

    let params = new HttpParams();

    if (filtro?.data) {
      params = params.set("data", filtro.data.toUTCString());
    }

    if (filtro?.origem) {
      params = params.set("origem", filtro.origem.codigo);
    }

    if (filtro?.destino) {
      params = params.set("destino", filtro.destino.codigo);
    }

    return this.http
      .get<Cotacao[]>(`${this.config.apiUrl}/${this.path}`, { params: params })
      .pipe(
        map((data: Cotacao[]) => data.map((cotacao: Cotacao) => this.process(cotacao)))
      );
  }

  fetchById(id: number): Observable<Cotacao> {
    return this.http
      .get<Cotacao>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data: Cotacao) => this.process(data)));
  }

  fetchNew(origem: Moeda, destino: Moeda): Observable<Cotacao> {
    let params = new HttpParams()
      .append("origem", origem.codigo)
      .append("destino", destino.codigo);

    return this.http
      .get<Cotacao>(`${this.config.apiUrl}/${this.path}/nova`, { params })
      .pipe(map((data: Cotacao) => this.process(data)));
  }

  remove(cotacao: Cotacao) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${cotacao.id}`);
  }

  create(cotacao: Cotacao): Observable<Cotacao> {
    return this.http.post<Cotacao>(`${this.config.apiUrl}/${this.path}/`, cotacao);
  }

  update(cotacao: Cotacao, id: number): Observable<Cotacao> {
    return this.http.put<Cotacao>(`${this.config.apiUrl}/${this.path}/`, cotacao);
  }

  createOrUpdate(cotacao: Cotacao): Observable<Cotacao> {
    let innerCotacao = this.convert(cotacao);
    return innerCotacao.id ? this.update(innerCotacao, innerCotacao.id) : this.create(innerCotacao);
  }

  private process(cotacao: any): Cotacao {
    return {
      ...cotacao,
      origem: Moeda.fromCodigo(cotacao.origem),
      destino: Moeda.fromCodigo(cotacao.destino),
      data: new Date(cotacao.data),
    } as Cotacao;
  }

  private convert(cotacao: any): Cotacao {
    return {
      ...cotacao,
      origem: cotacao.origem.codigo,
      destino: cotacao.destino.codigo,
      data: cotacao.data.getTime(),
    } as Cotacao;
  }
}
