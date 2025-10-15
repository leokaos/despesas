import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Investimento, Moeda } from '../models/debitavel.model';

@Injectable({
  providedIn: 'root',
})
export class InvestimentoService {
  private readonly path: string = 'investimento';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Investimento[]> {
    return this.http
      .get<Investimento[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((investimento) => InvestimentoService.toDTO(investimento))));
  }

  fetchById(id: number): Observable<Investimento> {
    return this.http
      .get<Investimento>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => InvestimentoService.toDTO(data)));
  }

  remove(investimento: Investimento) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${investimento.id}`);
  }

  create(investimento: Investimento): Observable<Investimento> {
    return this.http.post<Investimento>(`${this.config.apiUrl}/${this.path}/`, investimento);
  }

  update(investimento: Investimento, id: number): Observable<Investimento> {
    return this.http.put<Investimento>(`${this.config.apiUrl}/${this.path}/`, investimento);
  }

  createOrUpdate(investimento: Investimento): Observable<Investimento> {
    let innerInvestimento = InvestimentoService.toEntity(investimento);
    return innerInvestimento.id ? this.update(innerInvestimento, innerInvestimento.id) : this.create(innerInvestimento);
  }

  public static toDTO(investimento: any): Investimento {
    return {
      ...investimento,
      moeda: Moeda.fromCodigo(investimento.moeda),
    };
  }

  public static toEntity(conta: any): Investimento {
    return {
      ...conta,
      tipo: 'INVESTIMENTO',
      moeda: conta.moeda.codigo,
    };
  }
}
