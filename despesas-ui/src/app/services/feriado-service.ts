import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Feriado } from '../models/feriado.model';

export interface FeriadoFiltro {
  dataInicial: Date;
  dataFinal: Date;
}

@Injectable({
  providedIn: 'root'
})
export class FeriadoService {
  private readonly path: string = 'feriado';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro?: FeriadoFiltro): Observable<Feriado[]> {

    let params = new HttpParams();

    if (filtro?.dataInicial) {
      params = params.append("dataInicial", filtro?.dataInicial.toUTCString());
    }

    if (filtro?.dataFinal) {
      params = params.append("dataFinal", filtro?.dataFinal.toUTCString());
    }

    return this.http.get<Feriado[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data) => data.map((feriado) => FeriadoService.toDTO(feriado))));
  }

  fetchById(id: number): Observable<Feriado> {
    return this.http.get<Feriado>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => FeriadoService.toDTO(data)));
  }

  remove(feriado: Feriado) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${feriado.id}`);
  }

  create(feriado: Feriado): Observable<Feriado> {
    return this.http.post<Feriado>(`${this.config.apiUrl}/${this.path}/`, feriado);
  }

  update(feriado: Feriado, id: number): Observable<Feriado> {
    return this.http.put<Feriado>(`${this.config.apiUrl}/${this.path}/`, feriado);
  }

  createOrUpdate(feriado: Feriado): Observable<Feriado> {
    let innerFeriado = FeriadoService.toEntity(feriado);
    return innerFeriado.id ? this.update(innerFeriado, innerFeriado.id) : this.create(innerFeriado);
  }

  public static toEntity(feriado: any): Feriado {
    return {
      ...feriado,
      data: feriado.data.getTime(),
    };
  }

  public static toDTO(feriado: any): Feriado {
    return {
      ...feriado,
      data: new Date(feriado.data),
    };
  }

}
