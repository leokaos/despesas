import { Moeda } from './../models/debitavel.model';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Conta } from '../models/debitavel.model';
import { map, Observable } from 'rxjs';
import { DebitavelFiltro } from './debitavel-service';

export interface ContaFiltro extends DebitavelFiltro { }

@Injectable({
  providedIn: 'root',
})
export class ContaService {
  private readonly path: string = 'conta';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro?: ContaFiltro): Observable<Conta[]> {

    let params = new HttpParams();

    if (filtro?.ativo) {
      params = params.append("ativo", filtro.ativo);
    }

    if (filtro?.moeda) {
      params = params.append("moeda", filtro.moeda.codigo);
    }

    return this.http
      .get<Conta[]>(`${this.config.apiUrl}/${this.path}`, { params })
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
