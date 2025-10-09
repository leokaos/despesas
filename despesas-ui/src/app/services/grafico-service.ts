import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Debitavel } from '../models/debitavel.model';
import { Extrato } from '../models/extrato.model';
import { GraficoLinha } from '../models/grafico.model';

@Injectable({
  providedIn: 'root'
})
export class GraficoService {
  private readonly path: string = 'grafico';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetchDespesas(dataInicial?: Date, dataFinal?: Date): Observable<GraficoLinha> {

    let params = this.buildParams(dataInicial, dataFinal);

    return this.http.get<GraficoLinha>(`${this.config.apiUrl}/${this.path}/despesas`, { params });
  }

  fetchReceitas(dataInicial?: Date, dataFinal?: Date): Observable<GraficoLinha> {

    let params = this.buildParams(dataInicial, dataFinal);

    return this.http.get<GraficoLinha>(`${this.config.apiUrl}/${this.path}/receitas`, { params });
  }

  private buildParams(dataInicial: Date | undefined, dataFinal: Date | undefined) {

    let params = new HttpParams();

    if (dataInicial) {
      params = params.append("dataInicial", dataInicial.toUTCString());
    }

    if (dataFinal) {
      params = params.append("dataFinal", dataFinal.toUTCString());
    }

    return params;
  }
}
