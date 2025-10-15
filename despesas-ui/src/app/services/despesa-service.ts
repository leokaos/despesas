import { Debitavel, Moeda } from './../models/debitavel.model';
import { Inject, Injectable } from '@angular/core';
import { Despesa } from '../models/movimentacao.model';
import { map, Observable } from 'rxjs';
import { HttpClient, HttpParams } from '@angular/common/http';
import { APP_CONFIG, AppConfig } from '../app-config';
import { TipoDespesa } from '../models/tipo-movimentacao.model';
import { DebitavelService } from './debitavel-service';

export interface DespesaFiltro {
  dataInicial: Date;
  dataFinal: Date;
  moeda: Moeda;
  tipo: TipoDespesa;
  debitavel: Debitavel;
}

@Injectable({
  providedIn: 'root'
})
export class DespesaService {

  private readonly path: string = 'despesa';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: DespesaFiltro): Observable<Despesa[]> {

    let params = new HttpParams();

    if (filtro?.dataInicial) {
      params = params.append("dataInicial", filtro?.dataInicial.toUTCString());
    }

    if (filtro?.dataFinal) {
      params = params.append("dataFinal", filtro?.dataFinal.toUTCString());
    }

    if (filtro?.moeda) {
      params = params.append("moeda", filtro.moeda?.codigo);
    }

    if (filtro?.tipo) {
      params = params.append("tipoDespesa", filtro.tipo.descricao);
    }

    if (filtro?.debitavel) {
      params = params.append("debitavel_id", filtro.debitavel.id);
    }

    return this.http.get<Despesa[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((despesas: Despesa[]) => despesas.map((despesa: Despesa) => DespesaService.toDTO(despesa))));
  }

  fetchById(id: number): Observable<Despesa> {
    return this.http.get<Despesa>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((despesa: Despesa) => DespesaService.toDTO(despesa)));
  }

  remove(despesa: Despesa) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${despesa.id}`);
  }

  create(despesa: Despesa): Observable<Despesa> {
    let payload = {
      despesa: DebitavelService.toEntity(despesa)
    }

    return this.http.post<Despesa>(`${this.config.apiUrl}/${this.path}/`, payload);
  }

  update(despesa: Despesa, id: number): Observable<Despesa> {
    return this.http.put<Despesa>(`${this.config.apiUrl}/${this.path}/`, DespesaService.toEntity(despesa));
  }

  createOrUpdate(despesa: Despesa): Observable<Despesa> {
    return despesa.id ? this.update(despesa, despesa.id) : this.create(despesa);
  }

  uploadFile(file: File): Observable<Despesa[]> {
    const formData = new FormData();

    formData.append('arquivo', file, file.name);

    return this.http.post<Despesa[]>(`${this.config.apiUrl}/${this.path}/upload`, formData)
      .pipe(map((data: Despesa[]) => data.map((despesa: Despesa) => DespesaService.toDTO(despesa))));
  }

  public static toDTO(despesa: any): Despesa {
    return {
      ...despesa,
      vencimento: despesa.vencimento ? new Date(despesa.vencimento) : null,
      pagamento: despesa.pagamento ? new Date(despesa.pagamento) : null,
      moeda: Moeda.fromCodigo(despesa.moeda),
      debitavel: despesa.debitavel ? DebitavelService.toEntity(despesa) : null,
    };
  }

  public static toEntity(despesa: any): Despesa {
    return {
      ...despesa,
      moeda: despesa.moeda.codigo,
      debitavel: DebitavelService.toEntity(despesa.debitavel),
    } as Despesa;
  }

}
