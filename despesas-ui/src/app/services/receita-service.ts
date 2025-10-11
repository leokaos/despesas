import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Moeda, Debitavel } from '../models/debitavel.model';
import { Receita } from '../models/movimentacao.model';
import { TipoReceita } from '../models/tipo-movimentacao.model';

export interface ReceitaFiltro {
  dataInicial: Date;
  dataFinal: Date;
  moeda: Moeda;
  tipo: TipoReceita;
  debitavel: Debitavel;
}

@Injectable({
  providedIn: 'root'
})
export class ReceitaService {

  private readonly path: string = 'receita';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro: ReceitaFiltro): Observable<Receita[]> {

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
      params = params.append("tipoReceita", filtro.tipo.descricao);
    }

    if (filtro?.debitavel) {
      params = params.append("debitavel_id", filtro.debitavel.id);
    }

    return this.http.get<Receita[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((receitas: Receita[]) => receitas.map((receita: Receita) => this.process(receita))));;
  }

  fetchById(id: number): Observable<Receita> {
    return this.http.get<Receita>(`${this.config.apiUrl}/${this.path}/${id}`);
  }

  remove(receita: Receita) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${receita.id}`);
  }

  create(receita: Receita): Observable<Receita> {
    return this.http.post<Receita>(`${this.config.apiUrl}/${this.path}/`, this.convert(receita));
  }

  update(receita: Receita, id: number): Observable<Receita> {
    return this.http.put<Receita>(`${this.config.apiUrl}/${this.path}/`, receita);
  }

  createOrUpdate(receita: Receita): Observable<Receita> {
    return receita.id ? this.update(receita, receita.id) : this.create(receita);
  }

  uploadFile(file: File): Observable<Receita[]> {
    const formData = new FormData();

    formData.append('arquivo', file, file.name);

    return this.http.post<Receita[]>(`${this.config.apiUrl}/${this.path}/upload`, formData)
      .pipe(map((data: Receita[]) => data.map((receita: Receita) => this.process(receita))));
  }

  private process(receita: any): Receita {
    return {
      ...receita,
      vencimento: new Date(receita.vencimento),
      pagamento: new Date(receita.pagamento),
      moeda: Moeda.fromCodigo(receita.moeda),
      debitavel: receita.debitavel ? this.processDebitavel(receita.debitavel) : null,
    };
  }

  private processDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: Moeda.fromCodigo(debitavel.Moeda),
    } as Debitavel;
  }

  private convert(receita: any): Receita {
    return {
      ...receita,
      moeda: receita.moeda.codigo,
      debitavel: this.convertDebitavel(receita.debitavel)
    } as Receita;
  }

  private convertDebitavel(debitavel: any): Debitavel {
    return {
      ...debitavel,
      moeda: debitavel.moeda.codigo,
    } as Debitavel
  }
}
