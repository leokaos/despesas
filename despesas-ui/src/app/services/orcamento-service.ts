import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Orcamento } from '../models/orcamento.model';
import { Mes } from '../models/mes.model';
import { Periodo } from '../models/periodo.model';

@Injectable({
  providedIn: 'root',
})
export class OrcamentoService {
  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) {}

  fetch(): Observable<Orcamento[]> {
    return this.http
      .get<Orcamento[]>(`${this.config.apiUrl}/orcamento`)
      .pipe(
        map((data: Orcamento[]) => data.map((orcamento: Orcamento) => this.process(orcamento)))
      );
  }

  fetchById(id: number): Observable<Orcamento> {
    return this.http.get<Orcamento>(`${this.config.apiUrl}/orcamento/${id}`);
  }

  remove(orcamento: Orcamento) {
    return this.http.delete(`${this.config.apiUrl}/orcamento/${orcamento.id}`);
  }

  create(orcamento: Orcamento): Observable<Orcamento> {
    return this.http.post<Orcamento>(`${this.config.apiUrl}/orcamento/`, orcamento);
  }

  update(orcamento: Orcamento, id: number): Observable<Orcamento> {
    return this.http.put<Orcamento>(`${this.config.apiUrl}/orcamento/`, orcamento);
  }

  createOrUpdate(orcamento: Orcamento): Observable<Orcamento> {
    return orcamento.id ? this.update(orcamento, orcamento.id) : this.create(orcamento);
  }

  private process(orcamento: Orcamento): Orcamento {
    let dataInicial = new Date(orcamento.dataInicial);

    let periodo = {
      mes: Mes.getPorId(dataInicial.getMonth() + 1),
      ano: dataInicial.getFullYear(),
    } as Periodo;

    return {
      ...orcamento,
      periodo: periodo,
      descricao: `${periodo.mes.name} de ${periodo.ano}`,
    } as Orcamento;
  }
}
