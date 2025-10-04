import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { CartaoCredito, Conta, Debitavel, Fatura, Moeda } from '../models/debitavel.model';
import { map, Observable } from 'rxjs';
import { Despesa } from '../models/movimentacao.model';

@Injectable({
  providedIn: 'root',
})
export class FaturaService {
  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) {}

  fetch(cartaoCredito: CartaoCredito): Observable<Fatura[]> {
    return this.http
      .get<Fatura[]>(`${this.config.apiUrl}/cartao/${cartaoCredito.id}/fatura`)
      .pipe(map((data) => data.map((fatura) => this.process(fatura))));
  }

  pay(fatura: Fatura, conta: Conta, dataPagamento: Date): Observable<void> {
    let payload = {
      debitavel: this.convertDebitavel(conta),
      dataPagamento: dataPagamento.getTime(),
    };

    return this.http.put<void>(
      `${this.config.apiUrl}/cartao/${fatura.cartao.id}/fatura/${fatura.id}`,
      payload
    );
  }

  private process(fatura: any): Fatura {
    return {
      ...fatura,
      cartao: this.processDebitavel(fatura.cartao),
      despesas: fatura.despesas.map((despesa: any) => this.processDespesa(despesa)),
      dataFechamento: new Date(fatura.dataFechamento),
      dataVencimento: new Date(fatura.dataVencimento),
    };
  }

  private processDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: Moeda.fromCodigo(debitavel.Moeda),
    } as Debitavel;
  }

  private convertDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: debitavel.moeda.codigo,
    };
  }

  private processDespesa(despesa: any): Despesa {
    return {
      ...despesa,
      debitavel: this.processDebitavel(despesa.debitavel),
    };
  }
}
