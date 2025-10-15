import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient, HttpParams } from '@angular/common/http';
import { map, Observable } from 'rxjs';
import { Meta } from '../models/meta.model';
import { Mes } from '../models/mes.model';

export interface MetaFiltro {
  mes?: number;
  ano?: number;
}

@Injectable({
  providedIn: 'root',
})
export class MetaService {

  private readonly path: string = 'meta';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: MetaFiltro): Observable<Meta[]> {
    let params = new HttpParams();

    if (filtro?.mes) {
      params = params.append("mes", filtro.mes);
    }

    if (filtro?.ano) {
      params = params.append("ano", filtro.ano);
    }

    return this.http
      .get<Meta[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data: Meta[]) => data.map((meta: Meta) => MetaService.toDTO(meta))));
  }

  fetchById(id: number): Observable<Meta> {
    return this.http
      .get<Meta>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((meta: Meta) => MetaService.toDTO(meta)));
  }

  remove(meta: Meta) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${meta.id}`);
  }

  create(meta: Meta): Observable<Meta> {
    return this.http.post<Meta>(`${this.config.apiUrl}/${this.path}/`, meta);
  }

  update(meta: Meta, id: number): Observable<Meta> {
    return this.http.put<Meta>(`${this.config.apiUrl}/${this.path}/`, meta);
  }

  createOrUpdate(meta: Meta): Observable<Meta> {
    return meta.id ? this.update(meta, meta.id) : this.create(meta);
  }

  public static toDTO(meta: any): Meta {
    let mes = Mes.getPorId(meta.mes?.mes - 1);

    return {
      ...meta,
      descricao: `${mes?.name} de ${meta.mes.ano}`,
    };
  }
}
