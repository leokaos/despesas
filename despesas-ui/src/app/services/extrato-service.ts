import { Debitavel } from './../models/debitavel.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Extrato } from '../models/extrato.model';

@Injectable({
  providedIn: 'root'
})
export class ExtratoService {
  private readonly path: string = 'extrato';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(dataInicial?: Date, dataFinal?: Date, debitavel?: Debitavel): Observable<Extrato[]> {

    let params = new HttpParams();

    if (dataInicial) {
      params = params.append("dataInicial", dataInicial.toUTCString());
    }

    if (dataFinal) {
      params = params.append("dataFinal", dataFinal.toUTCString());
    }

    if (debitavel) {
      params = params.append("id", debitavel.id);
    }

    return this.http.get<Extrato[]>(`${this.config.apiUrl}/${this.path}`, { params });
  }

}
