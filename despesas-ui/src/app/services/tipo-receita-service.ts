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

  fetch(): Observable<TipoReceita[]> {
    return this.http.get<TipoReceita[]>(`${this.config.apiUrl}/tiporeceita`);
  }

  fetchById(id: number): Observable<TipoReceita> {
    return this.http.get<TipoReceita>(`${this.config.apiUrl}/tiporeceita/${id}`);
  }

  remove(tipoReceita: TipoReceita) {
    return this.http.delete(`${this.config.apiUrl}/tiporeceita/${tipoReceita.id}`);
  }

  create(tipoReceita: TipoReceita): Observable<TipoReceita> {
    return this.http.post<TipoReceita>(`${this.config.apiUrl}/tiporeceita/`, tipoReceita);
  }

  update(tipoReceita: TipoReceita, id: number): Observable<TipoReceita> {
    return this.http.put<TipoReceita>(`${this.config.apiUrl}/tiporeceita/`, tipoReceita);
  }

  createOrUpdate(tipoReceita: TipoReceita): Observable<TipoReceita> {
    return tipoReceita.id ? this.update(tipoReceita, tipoReceita.id) : this.create(tipoReceita);
  }
}
