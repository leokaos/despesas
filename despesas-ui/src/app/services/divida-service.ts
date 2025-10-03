import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Divida, Moeda } from '../models/debitavel.model';

@Injectable({
  providedIn: 'root',
})
export class DividaService {
  private readonly path: string = 'divida';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) {}

  fetch(): Observable<Divida[]> {
    return this.http
      .get<Divida[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((divida) => this.process(divida))));
  }

  fetchById(id: number): Observable<Divida> {
    return this.http
      .get<Divida>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => this.process(data)));
  }

  remove(divida: Divida) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${divida.id}`);
  }

  create(divida: Divida): Observable<Divida> {
    return this.http.post<Divida>(`${this.config.apiUrl}/${this.path}/`, divida);
  }

  update(divida: Divida, id: number): Observable<Divida> {
    return this.http.put<Divida>(`${this.config.apiUrl}/${this.path}/`, divida);
  }

  createOrUpdate(divida: Divida): Observable<Divida> {
    let innerDivida = this.convert(divida);
    return innerDivida.id ? this.update(innerDivida, innerDivida.id) : this.create(innerDivida);
  }

  private process(divida: any): Divida {
    return {
      ...divida,
      dataInicio: new Date(divida.dataInicio),
      moeda: Moeda.fromCodigo(divida.moeda),
    };
  }

  private convert(conta: any): Divida {
    return {
      ...conta,
      tipo: 'DIVIDA',
      moeda: conta.moeda.codigo,
    };
  }
}
