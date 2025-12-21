import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { TipoReceita } from '../models/tipo-movimentacao.model';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class TipoReceitaService {

  private readonly path: string = 'tiporeceita';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<TipoReceita[]> {

    let params = new HttpParams();
    params = params.append("order", "descricao");

    return this.http.get<TipoReceita[]>(`${this.config.apiUrl}/${this.path}`, { params: params });
  }

  fetchById(id: number): Observable<TipoReceita> {
    return this.http.get<TipoReceita>(`${this.config.apiUrl}/${this.path}/${id}`);
  }

  remove(tipoReceita: TipoReceita) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${tipoReceita.id}`);
  }

  create(tipoReceita: TipoReceita): Observable<TipoReceita> {
    return this.http.post<TipoReceita>(`${this.config.apiUrl}/${this.path}/`, tipoReceita);
  }

  update(tipoReceita: TipoReceita, id: number): Observable<TipoReceita> {
    return this.http.put<TipoReceita>(`${this.config.apiUrl}/${this.path}/`, tipoReceita);
  }

  createOrUpdate(tipoReceita: TipoReceita): Observable<TipoReceita> {
    return tipoReceita.id ? this.update(tipoReceita, tipoReceita.id) : this.create(tipoReceita);
  }
}
