import { Debitavel, Moeda } from './../models/debitavel.model';
import { Inject, Injectable } from '@angular/core';
import { Despesa } from '../models/movimentacao.model';
import { map, Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { APP_CONFIG, AppConfig } from '../app-config';

@Injectable({
  providedIn: 'root'
})
export class DespesaService {

  private readonly path: string = 'despesa';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Despesa[]> {
    return this.http.get<Despesa[]>(`${this.config.apiUrl}/${this.path}`);
  }

  fetchById(id: number): Observable<Despesa> {
    return this.http.get<Despesa>(`${this.config.apiUrl}/${this.path}/${id}`);
  }

  remove(despesa: Despesa) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${despesa.id}`);
  }

  create(despesa: Despesa): Observable<Despesa> {
    let payload = {
      despesa: this.convert(despesa)
    }

    return this.http.post<Despesa>(`${this.config.apiUrl}/${this.path}/`, payload);
  }

  update(despesa: Despesa, id: number): Observable<Despesa> {
    return this.http.put<Despesa>(`${this.config.apiUrl}/${this.path}/`, despesa);
  }

  createOrUpdate(despesa: Despesa): Observable<Despesa> {
    return despesa.id ? this.update(despesa, despesa.id) : this.create(despesa);
  }

  uploadFile(file: File): Observable<Despesa[]> {
    const formData = new FormData();

    formData.append('arquivo', file, file.name);

    return this.http.post<Despesa[]>(`${this.config.apiUrl}/${this.path}/upload`, formData)
      .pipe(map((data: Despesa[]) => data.map((despesa: Despesa) => this.process(despesa))));
  }

  private process(despesa: any): Despesa {
    return {
      ...despesa,
      vencimento: new Date(despesa.vencimento),
      pagamento: new Date(despesa.pagamento),
      moeda: Moeda.fromCodigo(despesa.moeda),
      debitavel: despesa.debitavel ? this.processDebitavel(despesa.debitavel) : null,
    };
  }

  private processDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: Moeda.fromCodigo(debitavel.Moeda),
    } as Debitavel;
  }

  private convert(despesa: any): Despesa {
    return {
      ...despesa,
      moeda: despesa.moeda.codigo,
      debitavel: this.convertDebitavel(despesa.debitavel)
    } as Despesa;
  }

  private convertDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: debitavel.moeda.codigo,
    } as Debitavel
  }

}
