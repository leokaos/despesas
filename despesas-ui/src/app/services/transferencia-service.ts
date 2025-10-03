import { Debitavel, Moeda } from './../models/debitavel.model';
import { Transferencia } from './../models/movimentacao.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';

export interface TransferenciaFiltro {
  dataInicial: Date;
  dataFinal: Date;
}

@Injectable({
  providedIn: 'root',
})
export class TransferenciaService {
  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) {}

  fetch(filtro: TransferenciaFiltro): Observable<Transferencia[]> {
    let params = new HttpParams();

    if (filtro) {
      Object.keys(filtro).forEach((key) => {
        const value = filtro[key as keyof TransferenciaFiltro];
        if (value !== undefined && value !== null) {
          params = params.set(key, value.toString());
        }
      });
    }

    return this.http
      .get<Transferencia[]>(`${this.config.apiUrl}/transferencia`, { params })
      .pipe(
        map((data: Transferencia[]) =>
          data.map((transferencia: Transferencia) => this.process(transferencia))
        )
      );
  }

  fetchById(id: number): Observable<Transferencia> {
    return this.http
      .get<Transferencia>(`${this.config.apiUrl}/transferencia/${id}`)
      .pipe(map((data: Transferencia) => this.process(data)));
  }

  remove(transferencia: Transferencia) {
    return this.http.delete(`${this.config.apiUrl}/transferencia/${transferencia.id}`);
  }

  create(transferencia: Transferencia): Observable<Transferencia> {
    let payload = {
      transferencia: transferencia,
    };
    return this.http.post<Transferencia>(`${this.config.apiUrl}/transferencia/`, payload);
  }

  update(transferencia: Transferencia, id: number): Observable<Transferencia> {
    return this.http.put<Transferencia>(`${this.config.apiUrl}/transferencia/`, transferencia);
  }

  createOrUpdate(transferencia: Transferencia): Observable<Transferencia> {
    var innerTransferencia = this.convert(transferencia);
    return innerTransferencia.id
      ? this.update(innerTransferencia, innerTransferencia.id)
      : this.create(innerTransferencia);
  }

  private process(transferencia: any): Transferencia {
    let debitavel = this.processDebitavel(transferencia.debitavel);
    let creditavel = this.processDebitavel(transferencia.creditavel);
    return {
      ...transferencia,
      creditavel: creditavel,
      debitavel: debitavel,
      moeda: Moeda.fromCodigo(transferencia.moeda),
    } as Transferencia;
  }

  private processDebitavel(debitavel: any): Debitavel {
    let moeda = debitavel.moeda;
    return {
      ...debitavel,
      moeda: Moeda.fromCodigo(moeda),
    };
  }

  private convert(transferencia: any): Transferencia {
    let debitavel = this.convertDebitavel(transferencia.debitavel);
    let creditavel = this.convertDebitavel(transferencia.creditavel);
    return {
      ...transferencia,
      creditavel: creditavel,
      debitavel: debitavel,
      moeda: transferencia.moeda?.codigo || debitavel.moeda,
    } as Transferencia;
  }

  private convertDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: debitavel.moeda.codigo,
    };
  }
}
