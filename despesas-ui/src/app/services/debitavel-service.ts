import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Debitavel, Moeda } from '../models/debitavel.model';

export interface DebitavelFiltro {
  ativo: boolean;
}

@Injectable({
  providedIn: 'root',
})
export class DebitavelService {
  private readonly path: string = 'debitavel';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: DebitavelFiltro): Observable<Debitavel[]> {
    let params = new HttpParams();

    if (filtro.ativo) {
      params = params.append("ativo", filtro.ativo);
    }

    return this.http
      .get<Debitavel[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data: Debitavel[]) => data.map((debitavel: Debitavel) => DebitavelService.toDTO(debitavel))));
  }

  fetchById(id: number): Observable<Debitavel> {
    return this.http.get<Debitavel>(`${this.config.apiUrl}/${this.path}/${id}`);
  }

  remove(debitavel: Debitavel) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${debitavel.id}`);
  }

  create(debitavel: Debitavel): Observable<Debitavel> {
    return this.http.post<Debitavel>(`${this.config.apiUrl}/${this.path}/`, debitavel);
  }

  update(debitavel: Debitavel, id: number): Observable<Debitavel> {
    return this.http.put<Debitavel>(`${this.config.apiUrl}/${this.path}/`, debitavel);
  }

  createOrUpdate(debitavel: Debitavel): Observable<Debitavel> {
    return debitavel.id ? this.update(debitavel, debitavel.id) : this.create(debitavel);
  }

  public static toDTO(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: Moeda.fromCodigo(debitavel.moeda),
    };
  }

  public static toEntity(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: debitavel.moeda.codigo,
    };
  }
}
