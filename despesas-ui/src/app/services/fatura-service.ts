import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { CartaoCredito, Conta, Fatura } from '../models/debitavel.model';
import { map, Observable } from 'rxjs';
import { CartaoCreditoService } from './cartao-credito-service';
import { DespesaService } from './despesa-service';
import { ContaService } from './conta-service';

@Injectable({
  providedIn: 'root',
})
export class FaturaService {
  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(cartaoCredito: CartaoCredito): Observable<Fatura[]> {
    return this.http
      .get<Fatura[]>(`${this.config.apiUrl}/cartao/${cartaoCredito.id}/fatura`)
      .pipe(map((data) => data.map((fatura) => FaturaService.toDTO(fatura))));
  }

  pay(fatura: Fatura, conta: Conta, dataPagamento: Date): Observable<void> {
    let payload = {
      debitavel: ContaService.toEntity(conta),
      dataPagamento: dataPagamento.getTime(),
    };

    return this.http.put<void>(`${this.config.apiUrl}/cartao/${fatura.cartao.id}/fatura/${fatura.id}`, payload);
  }

  public static toDTO(fatura: any): Fatura {
    return {
      ...fatura,
      cartao: CartaoCreditoService.toDTO(fatura.cartao),
      despesas: fatura.despesas.map((despesa: any) => DespesaService.toDTO(despesa)),
      dataFechamento: new Date(fatura.dataFechamento),
      dataVencimento: new Date(fatura.dataVencimento),
    };
  }

}
