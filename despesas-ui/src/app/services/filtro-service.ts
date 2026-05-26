import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Filtro } from '../models/filtro.model';
import { map, Observable } from 'rxjs';

export interface FiltroFiltro {
  nome?: string;
  classe?: string;
}

@Injectable({
  providedIn: 'root',
})
export class FiltroService {

  private readonly path: string = 'filtro';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro?: FiltroFiltro): Observable<Filtro[]> {

    let params = new HttpParams();

    if (filtro?.nome) {
      params = params.append("nome", filtro.nome);
    }

    if (filtro?.classe) {
      params = params.append("classe", filtro.classe);
    }

    return this.http.get<Filtro[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data) => data.map((feriado) => FiltroService.toDTO(feriado))));
  }

  fetchById(id: number): Observable<Filtro> {
    return this.http.get<Filtro>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => FiltroService.toDTO(data)));
  }

  remove(feriado: Filtro) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${feriado.id}`);
  }

  create(feriado: Filtro): Observable<Filtro> {
    return this.http.post<Filtro>(`${this.config.apiUrl}/${this.path}/`, feriado);
  }

  update(feriado: Filtro, id: number): Observable<Filtro> {
    return this.http.put<Filtro>(`${this.config.apiUrl}/${this.path}/`, feriado);
  }

  createOrUpdate(filtro: Filtro): Observable<Filtro> {
    let innerFeriado = FiltroService.toEntity(filtro);
    return innerFeriado.id ? this.update(innerFeriado, innerFeriado.id) : this.create(innerFeriado);
  }

  public static toEntity(filtro: any): Filtro {
    return {
      ...filtro,
    };
  }

  public static toDTO(feriado: any): Filtro {
    return {
      ...feriado,
    };
  }
}
