import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient, HttpParams } from '@angular/common/http';
import { DebitavelFiltro } from './debitavel-service';
import { map, Observable } from 'rxjs';
import { Ativo, Moeda } from '../models/debitavel.model';

export interface AtivoFiltro extends DebitavelFiltro { }

@Injectable({
  providedIn: 'root',
})
export class AtivoService {

  private readonly path: string = 'ativo';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro?: AtivoFiltro): Observable<Ativo[]> {

    let params = new HttpParams();

    if (filtro?.ativo) {
      params = params.append("ativo", filtro.ativo);
    }

    if (filtro?.moeda) {
      params = params.append("moeda", filtro.moeda.codigo);
    }

    return this.http
      .get<AtivoFiltro[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data) => data.map((ativo) => AtivoService.toDTO(ativo))));
  }

  fetchById(id: number): Observable<Ativo> {
    return this.http
      .get<Ativo>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => AtivoService.toDTO(data)));
  }

  remove(ativo: Ativo) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${ativo.id}`);
  }

  create(ativo: Ativo): Observable<Ativo> {
    return this.http.post<Ativo>(`${this.config.apiUrl}/${this.path}/`, ativo);
  }

  update(ativo: Ativo, id: number): Observable<Ativo> {
    return this.http.put<Ativo>(`${this.config.apiUrl}/${this.path}/`, ativo);
  }

  createOrUpdate(ativo: Ativo): Observable<Ativo> {
    var innerAtivo = AtivoService.toEntity(ativo);
    return innerAtivo.id ? this.update(innerAtivo, innerAtivo.id) : this.create(innerAtivo);
  }

  public static toDTO(ativo: any): Ativo {
    return {
      ...ativo,
      moeda: Moeda.fromCodigo(ativo.moeda),
    };
  }

  public static toEntity(ativo: any): Ativo {
    return {
      ...ativo,
      tipo: 'ATIVO',
      moeda: ativo.moeda.codigo,
    };
  }

}
