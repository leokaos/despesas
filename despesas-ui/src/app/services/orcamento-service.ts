import { Orcamento } from './../models/orcamento.model';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Mes } from '../models/mes.model';
import { Periodo } from '../models/periodo.model';
import { TipoDespesa } from '../models/tipo-movimentacao.model';

export interface OrcamentoFiltro {
  dataInicial: Date;
  dataFinal: Date;
  tipo: TipoDespesa;
}

@Injectable({
  providedIn: 'root',
})
export class OrcamentoService {
  private readonly path: string = 'orcamento';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: OrcamentoFiltro): Observable<Orcamento[]> {
    let params = new HttpParams();

    if (filtro.dataInicial) {
      params = params.append("dataInicial", filtro.dataInicial.toUTCString());
    }

    if (filtro.dataFinal) {
      params = params.append("dataFinal", filtro.dataFinal.toUTCString());
    }

    if (filtro.tipo) {
      params = params.append("tipoDespesa", filtro.tipo.descricao);
    }

    return this.http
      .get<Orcamento[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(
        map((data: Orcamento[]) => data.map((orcamento: Orcamento) => this.process(orcamento)))
      );
  }

  fetchById(id: number): Observable<Orcamento> {
    return this.http
      .get<Orcamento>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data: Orcamento) => this.process(data)));
  }

  remove(orcamento: Orcamento) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${orcamento.id}`);
  }

  create(orcamento: Orcamento): Observable<Orcamento> {
    return this.http.post<Orcamento>(`${this.config.apiUrl}/${this.path}/`, orcamento);
  }

  update(orcamento: Orcamento, id: number): Observable<Orcamento> {
    return this.http.put<Orcamento>(`${this.config.apiUrl}/${this.path}/`, orcamento);
  }

  createOrUpdate(orcamento: Orcamento): Observable<Orcamento> {
    return orcamento.id ? this.update(orcamento, orcamento.id) : this.create(orcamento);
  }

  private process(orcamento: Orcamento): Orcamento {
    let dataInicial = new Date(orcamento.dataInicial);

    let periodo = {
      mes: Mes.getPorId(dataInicial.getMonth()),
      ano: dataInicial.getFullYear(),
    } as Periodo;

    return {
      ...orcamento,
      periodo: periodo,
      descricao: `${periodo.mes.name} de ${periodo.ano}`,
    } as Orcamento;
  }
}
