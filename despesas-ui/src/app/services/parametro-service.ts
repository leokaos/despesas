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
  private readonly VALOR_DIARIO: string = 'VALOR_DIARIO'
  private readonly PERCENT_IVA: string = 'PERCENT_IVA'
  private readonly PERCENT_IRS: string = 'PERCENT_IRS'

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetchById(nome: string): Observable<string> {

    let params = new HttpParams().append("nome", nome);

    return this.http.get<string>(`${this.config.apiUrl}/${this.path}`, { params: params });
  }

  fetchIOF(): Observable<number> {
    return this.fetchById(this.IOF).pipe(map((data: string) => parseFloat(data)));
  }

  fetchSPOT(): Observable<number> {
    return this.fetchById(this.SPOT).pipe(map((data: string) => parseFloat(data)));
  }

  fetchValorDiario(): Observable<number> {
    return this.fetchById(this.VALOR_DIARIO).pipe(map((data: string) => parseFloat(data)));
  }

  fetchPercentIVA(): Observable<number> {
    return this.fetchById(this.PERCENT_IVA).pipe(map((data: string) => parseFloat(data)));
  }

  fetchPercentIRS(): Observable<number> {
    return this.fetchById(this.PERCENT_IRS).pipe(map((data: string) => parseFloat(data)));
  }


}
