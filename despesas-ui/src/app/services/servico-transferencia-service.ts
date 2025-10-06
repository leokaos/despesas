import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { ServicoTransferencia } from '../models/servico-transferencia.model';

@Injectable({
  providedIn: 'root'
})
export class ServicoTransferenciaService {
  private readonly path: string = 'servicotransferencia';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<ServicoTransferencia[]> {
    return this.http.get<ServicoTransferencia[]>(`${this.config.apiUrl}/${this.path}`);
  }

  fetchById(id: number): Observable<ServicoTransferencia> {
    return this.http.get<ServicoTransferencia>(`${this.config.apiUrl}/${this.path}/${id}`);
  }

  remove(servicoTransferencia: ServicoTransferencia) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${servicoTransferencia.id}`);
  }

  create(servicoTransferencia: ServicoTransferencia): Observable<ServicoTransferencia> {
    return this.http.post<ServicoTransferencia>(`${this.config.apiUrl}/${this.path}/`, servicoTransferencia);
  }

  update(servicoTransferencia: ServicoTransferencia, id: number): Observable<ServicoTransferencia> {
    return this.http.put<ServicoTransferencia>(`${this.config.apiUrl}/${this.path}/`, servicoTransferencia);
  }

  createOrUpdate(servicoTransferencia: ServicoTransferencia): Observable<ServicoTransferencia> {
    return servicoTransferencia.id ? this.update(servicoTransferencia, servicoTransferencia.id) : this.create(servicoTransferencia);
  }

}
