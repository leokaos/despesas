import { Bandeira } from './../models/debitavel.model';
import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Observable, map } from 'rxjs';
import { APP_CONFIG, AppConfig } from '../app-config';
import { CartaoCredito, Moeda } from '../models/debitavel.model';

@Injectable({
  providedIn: 'root',
})
export class CartaoCreditoService {
  private readonly path: string = 'cartao';

  constructor(@Inject(APP_CONFIG) private config: AppConfig, private http: HttpClient) { }

  fetch(): Observable<CartaoCredito[]> {
    return this.http
      .get<CartaoCredito[]>(`${this.config.apiUrl}/${this.path}`)
      .pipe(map((data) => data.map((cartaoCredito) => CartaoCreditoService.toDTO(cartaoCredito))));
  }

  fetchById(id: number): Observable<CartaoCredito> {
    return this.http
      .get<CartaoCredito>(`${this.config.apiUrl}/${this.path}/${id}`)
      .pipe(map((data) => CartaoCreditoService.toDTO(data)));
  }

  remove(cartaoCredito: CartaoCredito) {
    return this.http.delete(`${this.config.apiUrl}/${this.path}/${cartaoCredito.id}`);
  }

  create(cartaoCredito: CartaoCredito): Observable<CartaoCredito> {
    return this.http.post<CartaoCredito>(`${this.config.apiUrl}/${this.path}/`, cartaoCredito);
  }

  update(cartaoCredito: CartaoCredito, id: number): Observable<CartaoCredito> {
    return this.http.put<CartaoCredito>(`${this.config.apiUrl}/${this.path}/`, cartaoCredito);
  }

  createOrUpdate(conta: CartaoCredito): Observable<CartaoCredito> {
    var innerCartaoCredito = CartaoCreditoService.toEntity(conta);
    return innerCartaoCredito.id ? this.update(innerCartaoCredito, innerCartaoCredito.id) : this.create(innerCartaoCredito);
  }

  public static toDTO(cartaoCredito: any): CartaoCredito {
    return {
      ...cartaoCredito,
      moeda: Moeda.fromCodigo(cartaoCredito.moeda),
      bandeira: Bandeira.fromCodigo(cartaoCredito.bandeira),
    };
  }

  public static toEntity(cartaoCredito: any): CartaoCredito {
    return {
      ...cartaoCredito,
      tipo: 'CARTAO',
      moeda: cartaoCredito.moeda.codigo,
      bandeira: cartaoCredito.bandeira.codigo,
    };
  }
}
