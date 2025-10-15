import { Debitavel, Moeda } from './../models/debitavel.model';
import { Transferencia } from './../models/movimentacao.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { ServicoTransferencia } from '../models/servico-transferencia.model';
import { Cotacao } from '../models/cotacao.model';
import { DebitavelService } from './debitavel-service';
import { CotacaoService } from './cotacao-service';

export interface TransferenciaFiltro {
  dataInicial: Date;
  dataFinal: Date;
}

@Injectable({
  providedIn: 'root',
})
export class TransferenciaService {

  private readonly path: string = 'transferencia';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: TransferenciaFiltro): Observable<Transferencia[]> {
    let params = new HttpParams();

    if (filtro?.dataInicial) {
      params = params.append("dataInicial", filtro.dataInicial.toUTCString());
    }

    if (filtro?.dataFinal) {
      params = params.append("dataFinal", filtro.dataFinal.toUTCString());
    }

    return this.http
      .get<Transferencia[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data: Transferencia[]) => data.map((transferencia: Transferencia) => TransferenciaService.toDTO(transferencia))));
  }

  fetchById(id: number): Observable<Transferencia> {
    return this.http.get<Transferencia>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data: Transferencia) => TransferenciaService.toDTO(data)));
  }

  remove(transferencia: Transferencia) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${transferencia.id}`);
  }

  create(transferencia: Transferencia): Observable<Transferencia> {
    let payload = {
      transferencia: transferencia,
    };
    return this.http.post<Transferencia>(`${this.config.apiUrl}/${this.path}/`, payload);
  }

  update(transferencia: Transferencia, id: number): Observable<Transferencia> {
    return this.http.put<Transferencia>(`${this.config.apiUrl}/${this.path}/`, transferencia);
  }

  createOrUpdate(transferencia: Transferencia): Observable<Transferencia> {
    var innerTransferencia = TransferenciaService.toEntity(transferencia);
    return innerTransferencia.id ? this.update(innerTransferencia, innerTransferencia.id) : this.create(innerTransferencia);
  }

  createRemessa(
    servico: ServicoTransferencia,
    debitavel: Debitavel,
    creditavel: Debitavel,
    cotacao: Cotacao,
    valor: number
  ): Observable<Transferencia> {

    let payload = {

      transferencia: {
        creditavel: DebitavelService.toEntity(creditavel),
        debitavel: DebitavelService.toEntity(debitavel),
        valor: valor
      },
      cotacao: CotacaoService.toEntity(cotacao),
      servicoTransferencia: servico,
    }

    return this.http.post<Transferencia>(`${this.config.apiUrl}/${this.path}/`, payload);
  }

  public static toDTO(transferencia: any): Transferencia {
    return {
      ...transferencia,
      creditavel: DebitavelService.toDTO(transferencia.creditavel),
      debitavel: DebitavelService.toDTO(transferencia.debitavel),
      moeda: Moeda.fromCodigo(transferencia.moeda),
      vencimento: new Date(transferencia.vencimento),
    } as Transferencia;
  }

  public static toEntity(transferencia: any): Transferencia {
    return {
      ...transferencia,
      moeda: transferencia.moeda?.codigo || transferencia.debitavel.moeda?.codigo,
      creditavel: DebitavelService.toEntity(transferencia.creditavel),
      debitavel: DebitavelService.toEntity(transferencia.debitavel),
    } as Transferencia;
  }

}
