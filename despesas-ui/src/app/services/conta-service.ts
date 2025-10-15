import { Moeda } from './../models/debitavel.model';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient } from '@angular/common/http';
import { Conta } from '../models/debitavel.model';
import { map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ContaService {
  private readonly path: string = 'conta';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Conta[]> {
    return this.http
      .get<Conta[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((conta) => ContaService.toDTO(conta))));
  }

  fetchById(id: number): Observable<Conta> {
    return this.http
      .get<Conta>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => ContaService.toDTO(data)));
  }

  remove(conta: Conta) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${conta.id}`);
  }

  create(conta: Conta): Observable<Conta> {
    return this.http.post<Conta>(`${this.config.apiUrl}/${this.path}/`, conta);
  }

  update(conta: Conta, id: number): Observable<Conta> {
    return this.http.put<Conta>(`${this.config.apiUrl}/${this.path}/`, conta);
  }

  createOrUpdate(conta: Conta): Observable<Conta> {
    var innerConta = ContaService.toEntity(conta);
    return innerConta.id ? this.update(innerConta, innerConta.id) : this.create(innerConta);
  }

  public static toDTO(conta: any): Conta {
    return {
      ...conta,
      moeda: Moeda.fromCodigo(conta.moeda),
    };
  }

  public static toEntity(conta: any): Conta {
    return {
      ...conta,
      tipo: 'CONTA',
      moeda: conta.moeda.codigo,
    };
  }
}
