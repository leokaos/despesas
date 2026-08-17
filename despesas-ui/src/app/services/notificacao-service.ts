import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Notificacao } from '../models/notificacao.model';
import { map, Observable } from 'rxjs';

export interface NotificacaoFiltro {
  executado: boolean;
}

@Injectable({
  providedIn: 'root',
})
export class NotificacaoService {

  private readonly path: string = 'notificacao';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(filtro?: NotificacaoFiltro): Observable<Notificacao[]> {

    let params = new HttpParams();

    if (filtro?.executado !== undefined) {
      params = params.append("executado", filtro.executado);
    }

    return this.http
      .get<Notificacao[]>(`${this.config.apiUrl}/${this.path}`, { params })
      .pipe(map((data) => data.map((notificacao) => NotificacaoService.toDTO(notificacao))));
  }

  fetchById(id: number): Observable<Notificacao> {
    return this.http
      .get<Notificacao>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => data));
  }

  remove(notificacao: Notificacao) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${notificacao.id}`);
  }

  create(notificacao: Notificacao): Observable<Notificacao> {
    return this.http.post<Notificacao>(`${this.config.apiUrl}/${this.path}/`, notificacao);
  }

  update(notificacao: Notificacao, id: number): Observable<Notificacao> {
    return this.http.put<Notificacao>(`${this.config.apiUrl}/${this.path}/`, notificacao);
  }

  createOrUpdate(notificacao: Notificacao): Observable<Notificacao> {
    var innerNotificacao = notificacao;
    return innerNotificacao.id ? this.update(innerNotificacao, innerNotificacao.id) : this.create(innerNotificacao);
  }

  public static toDTO(notificacao: any): Notificacao {
    return {
      ...notificacao,
      targetDate: new Date(notificacao.targetDate)
    };
  }

  public static toEntity(notificacao: any): Notificacao {
    return {
      ...notificacao,
    } as Notificacao;
  }

}
