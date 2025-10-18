import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Divida, Moeda } from '../models/debitavel.model';
import { Transferencia } from '../models/movimentacao.model';
import { TransferenciaService } from './transferencia-service';

@Injectable({
  providedIn: 'root',
})
export class DividaService {
  private readonly path: string = 'divida';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Divida[]> {
    return this.http
      .get<Divida[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((divida) => DividaService.toDTO(divida))));
  }

  fetchById(id: number): Observable<Divida> {
    return this.http
      .get<Divida>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => DividaService.toDTO(data)));
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
    let innerDivida = DividaService.toEntity(divida);
    return innerDivida.id ? this.update(innerDivida, innerDivida.id) : this.create(innerDivida);
  }

  fetchPagamentos(id: number): Observable<Transferencia[]> {
    return this.http
      .get<Transferencia[]>(`${this.config.apiUrl}/${this.path}/${id}/pagamentos`)
      .pipe(map((data) => data.map((transferencia) => TransferenciaService.toDTO(transferencia))));
  }

  public static toDTO(divida: any): Divida {
    return {
      ...divida,
      dataInicio: new Date(divida.dataInicio),
      moeda: Moeda.fromCodigo(divida.moeda),
    };
  }

  public static toEntity(divida: any): Divida {
    return {
      ...divida,
      tipo: 'DIVIDA',
      moeda: divida.moeda.codigo,
      dataInicio: divida.dataInicio.toISOString()
    };
  }
}
