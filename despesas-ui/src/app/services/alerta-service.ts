import { Inject, Injectable } from '@angular/core';
import { APP_CONFIG, AppConfig } from '../app-config';
import { HttpClient } from '@angular/common/http';
import { Alerta } from '../models/alerta.model';
import { map, Observable } from 'rxjs';
import { CartaoCreditoService } from './cartao-credito-service';
import { DividaService } from './divida-service';

@Injectable({
  providedIn: 'root',
})
export class AlertaService {

  private readonly path: string = 'alerta';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<Alerta[]> {
    return this.http
      .get<Alerta[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((alerta) => AlertaService.toDTO(alerta))));
  }

  fetchById(id: number): Observable<Alerta> {
    return this.http
      .get<Alerta>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => AlertaService.toDTO(data)));
  }

  remove(alerta: Alerta) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${alerta.id}`);
  }

  create(alerta: Alerta): Observable<Alerta> {
    return this.http.post<Alerta>(`${this.config.apiUrl}/${this.path}/`, alerta);
  }

  update(alerta: Alerta, id: number): Observable<Alerta> {
    return this.http.put<Alerta>(`${this.config.apiUrl}/${this.path}/`, alerta);
  }

  createOrUpdate(alerta: Alerta): Observable<Alerta> {
    var innerAlerta = AlertaService.toEntity(alerta);
    return innerAlerta.id ? this.update(innerAlerta, innerAlerta.id) : this.create(innerAlerta);
  }

  public static toDTO(alerta: any): Alerta {
    let innerAlerta = { ...alerta } as Alerta;

    if (alerta.divida) {
      innerAlerta.divida = DividaService.toDTO(alerta.divida);
    }

    if (alerta.cartao) {
      innerAlerta.cartao = CartaoCreditoService.toDTO(alerta.cartao)
    }

    return innerAlerta;
  }

  public static toEntity(alerta: any): Alerta {

    let innerAlerta = { ...alerta } as Alerta;

    if (alerta.divida) {
      innerAlerta.divida = DividaService.toEntity(alerta.divida);
    }

    if (alerta.cartao) {
      innerAlerta.cartao = CartaoCreditoService.toEntity(alerta.cartao)
    }

    return innerAlerta;
  }

}