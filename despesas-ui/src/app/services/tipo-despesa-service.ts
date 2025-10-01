import { TipoDespesa } from './../models/tipo-movimentacao.model';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TipoDespesaService {

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<TipoDespesa[]> {
    return this.http.get<TipoDespesa[]>(`${this.config.apiUrl}/tipodespesa`);
  }

  fetchById(id: number): Observable<TipoDespesa> {
    return this.http.get<TipoDespesa>(`${this.config.apiUrl}/tipodespesa/${id}`);
  }

  remove(tipoDespesa: TipoDespesa) {
    return this.http.delete(`${this.config.apiUrl}/tipodespesa/${tipoDespesa.id}`);
  }

  create(tipoDespesa: TipoDespesa): Observable<TipoDespesa> {
    return this.http.post<TipoDespesa>(`${this.config.apiUrl}/tipodespesa/`, tipoDespesa);
  }

  update(tipoDespesa: TipoDespesa, id: number): Observable<TipoDespesa> {
    return this.http.put<TipoDespesa>(`${this.config.apiUrl}/tipodespesa/`, tipoDespesa);
  }

  createOrUpdate(tipoDespesa: TipoDespesa): Observable<TipoDespesa> {
    return tipoDespesa.id ? this.update(tipoDespesa, tipoDespesa.id) : this.create(tipoDespesa);
  }
}

