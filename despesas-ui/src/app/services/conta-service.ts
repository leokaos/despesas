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

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) {}

  fetch(): Observable<Conta[]> {
    return this.http
      .get<Conta[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((conta) => this.process(conta))));
  }

  fetchById(id: number): Observable<Conta> {
    return this.http
      .get<Conta>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => this.process(data)));
  }

  remove(Conta: Conta) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${Conta.id}`);
  }

  create(Conta: Conta): Observable<Conta> {
    return this.http.post<Conta>(`${this.config.apiUrl}/${this.path}/`, Conta);
  }

  update(Conta: Conta, id: number): Observable<Conta> {
    return this.http.put<Conta>(`${this.config.apiUrl}/${this.path}/`, Conta);
  }

  createOrUpdate(conta: Conta): Observable<Conta> {
    var innerConta = this.convert(conta);
    return innerConta.id ? this.update(innerConta, innerConta.id) : this.create(innerConta);
  }

  private process(conta: any): Conta {
    return {
      ...conta,
      moeda: Moeda.fromCodigo(conta.moeda),
    };
  }

  private convert(conta: any): Conta {
    return {
      ...conta,
      tipo: 'CONTA',
      moeda: conta.moeda.codigo,
    };
  }
}
