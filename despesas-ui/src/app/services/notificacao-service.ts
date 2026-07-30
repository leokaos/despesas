import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient } from '@angular/common/http';
import { Notificacao } from '../models/notificacao.model';
import { map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class NotificacaoService {

  private readonly path: string = 'notificacao';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Notificacao[]> {
    return this.http
      .get<Notificacao[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((notificacao) => notificacao)));
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

}
