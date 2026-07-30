import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient } from '@angular/common/http';
import { Alerta } from '../models/alerta.model';
import { map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AlertaService {

  private readonly path: string = 'alerta';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Alerta[]> {
    return this.http
      .get<Alerta[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((alerta) => alerta)));
  }

  fetchById(id: number): Observable<Alerta> {
    return this.http
      .get<Alerta>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => data));
  }

  remove(alerta: Alerta) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${alerta.id}`);
  }

  create(alerta: Alerta): Observable<Alerta> {
    return this.http.post<Alerta>(`${this.config.apiUrl}/${this.path}/`, alerta);
  }

  update(alerta: Alerta, id: number): Observable<Alerta> {
    return this.http.put<Alerta>(`${this.config.apiUrl}/${this.path}/`, alerta);
  }

  createOrUpdate(alerta: Alerta): Observable<Alerta> {
    var innerAlerta = alerta;
    return innerAlerta.id ? this.update(innerAlerta, innerAlerta.id) : this.create(innerAlerta);
  }

}
