import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';

@Injectable({
  providedIn: 'root'
})
export class ParametroService {

  private readonly path: string = 'parametro';
  private readonly IOF: string = 'IOF'
  private readonly SPOT: string = 'SPOT'

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetchById(nome: string): Observable<string> {

    let params = new HttpParams().append("nome", nome);

    return this.http.get<string>(`${this.config.apiUrl}/${this.path}`, { params: params });
  }

  fetchIOF(): Observable<number> {
    return this.fetchById(this.IOF)
      .pipe(map((data: string) => parseFloat(data)));
  }

  fetchSPOT(): Observable<number> {
    return this.fetchById(this.SPOT)
      .pipe(map((data: string) => parseFloat(data)));
  }

}
