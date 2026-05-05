import { HttpClient } from '@angular/common/http';
import { Inject, Injectable } from '@angular/core';
import { Subject } from 'rxjs';
import { Observable } from 'rxjs/internal/Observable';
import { APP_CONFIG, AppConfig } from '../app-config';

@Injectable({
  providedIn: 'root',
})
export class WebsocketService {

  constructor(@Inject(APP_CONFIG) private config: AppConfig) { }

  public getTopic<T>(topic: string): Observable<T> {

    return new Observable<T>(observer => {

      let socket: WebSocket = new WebSocket(`${this.config.wsUrl}/${topic}`);

      socket.onopen = (event) => {
        console.log('Conectado:', event);
      };

      socket.onmessage = (event) => {
        try {
          const data = JSON.parse(event.data) as T;
          observer.next(data);
        } catch (error) {
          observer.error(error);
        }
      };

      socket.onerror = (event) => {
        console.error('Erro no WebSocket:', event);
        observer.error(event);
      };

      socket.onclose = (event) => {
        console.log('Conexão fechada:', event);
        observer.complete();
      };

      return () => {
        console.log('Fechando WebSocket para tópico:', topic);
        socket.close();
      };
    });

  }

}
