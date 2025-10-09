import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Debitavel } from '../models/debitavel.model';

@Injectable({
  providedIn: 'root'
})
export class ProjecaoService {

  private readonly path: string = 'projecao';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(meses: number, debitavel: Debitavel): Observable<any> {

    let params = new HttpParams().append("meses", meses).append("debitavelId", debitavel.id);

    return this.http.get<any>(`${this.config.apiUrl}/${this.path}`, { params: params });
  }

}
