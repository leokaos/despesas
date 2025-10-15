import { HttpClient, HttpParams } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { Moeda, Debitavel } from '../models/debitavel.model';
import { Receita } from '../models/movimentacao.model';
import { TipoReceita } from '../models/tipo-movimentacao.model';
import { DebitavelService } from './debitavel-service';

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
      .pipe(map((receitas: Receita[]) => receitas.map((receita: Receita) => this.toDTO(receita))));;
  }

  fetchById(id: number): Observable<Receita> {
    return this.http.get<Receita>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((receita: any) => this.toDTO(receita)));
  }

  remove(receita: Receita) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${receita.id}`);
  }

  create(receita: Receita): Observable<Receita> {
    return this.http.post<Receita>(`${this.config.apiUrl}/${this.path}/`, this.toEntity(receita));
  }

  update(receita: Receita, id: number): Observable<Receita> {
    return this.http.put<Receita>(`${this.config.apiUrl}/${this.path}/`, this.toEntity(receita));
  }

  createOrUpdate(receita: Receita): Observable<Receita> {
    return receita.id ? this.update(receita, receita.id) : this.create(receita);
  }

  uploadFile(file: File): Observable<Receita[]> {
    const formData = new FormData();

    formData.append('arquivo', file, file.name);

    return this.http.post<Receita[]>(`${this.config.apiUrl}/${this.path}/upload`, formData)
      .pipe(map((data: Receita[]) => data.map((receita: Receita) => this.toDTO(receita))));
  }

  private toDTO(receita: any): Receita {
    return {
      ...receita,
      vencimento: receita.vencimento ? new Date(receita.vencimento) : null,
      pagamento: receita.pagamento ? new Date(receita.pagamento) : null,
      moeda: Moeda.fromCodigo(receita.moeda),
      debitavel: receita.debitavel ? DebitavelService.toDTO(receita.debitavel) : null,
    };
  }

  private toEntity(receita: any): Receita {
    return {
      ...receita,
      moeda: receita.moeda.codigo,
      debitavel: DebitavelService.toEntity(receita.debitavel)
    } as Receita;
  }

}
