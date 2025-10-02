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
  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) {}

  fetch(filtro: MetaFiltro): Observable<Meta[]> {
    let params = new HttpParams();

    if (filtro) {
      Object.keys(filtro).forEach((key) => {
        const value = filtro[key as keyof MetaFiltro];
        if (value !== undefined && value !== null) {
          params = params.set(key, value.toString());
        }
      });
    }

    return this.http
      .get<Meta[]>(`${this.config.apiUrl}/meta`, { params })
      .pipe(map((data: Meta[]) => data.map((meta: Meta) => this.processsMeta(meta))));
  }

  fetchById(id: number): Observable<Meta> {
    return this.http
      .get<Meta>(`${this.config.apiUrl}/meta/${id}`)
      .pipe(map((meta: Meta) => this.processsMeta(meta)));
  }

  remove(meta: Meta) {
    return this.http.delete(`${this.config.apiUrl}/meta/${meta.id}`);
  }

  create(meta: Meta): Observable<Meta> {
    return this.http.post<Meta>(`${this.config.apiUrl}/meta/`, meta);
  }

  update(meta: Meta, id: number): Observable<Meta> {
    return this.http.put<Meta>(`${this.config.apiUrl}/Meta/`, meta);
  }

  createOrUpdate(meta: Meta): Observable<Meta> {
    return meta.id ? this.update(meta, meta.id) : this.create(meta);
  }

  private processsMeta(meta: Meta): Meta {
    let mes = Mes.getPorId(meta.mes?.mes - 1);

    return {
      ...meta,
      descricao: `${mes?.name} de ${meta.mes.ano}`,
    };
  }
}
