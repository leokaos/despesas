import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { map, Observable } from 'rxjs';
import { Grafico } from '../models/dashboard.model';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {
  private readonly path: string = 'dashboard';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetchSaldo(dataInicial: Date, dataFinal: Date): Observable<number> {

    let params = new HttpParams();
    params = params.append("dataInicial", dataInicial.toUTCString());
    params = params.append("dataFinal", dataFinal.toUTCString());

    return this.http.get<string>(`${this.config.apiUrl}/${this.path}/saldo`, { params })
      .pipe(map((data: string) => parseFloat(data)));
  }

  fetchGraficos(dataInicial: Date, dataFinal: Date): Observable<Grafico[]> {

    let params = new HttpParams();
    params = params.append("dataInicial", dataInicial.toUTCString());
    params = params.append("dataFinal", dataFinal.toUTCString());

    return this.http.get<Grafico[]>(`${this.config.apiUrl}/${this.path}/main`, { params });
  }

}
