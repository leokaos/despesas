import {
  HttpInterceptor,
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpResponse,
} from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';

@Injectable()
export class DateInterceptor implements HttpInterceptor {
  private datePattern = /^\d{4}-\d{2}-\d{2}(T\d{2}:\d{2}:\d{2}(\.\d{3})?Z?)?$/;

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(
      map((event) => {
        if (event instanceof HttpResponse && event.body) {
          return event.clone({
            body: this.convertDates(event.body),
          });
        }
        return event;
      })
    );
  }

  private convertDates(obj: any): any {
    if (!obj || typeof obj !== 'object') return obj;

    if (Array.isArray(obj)) {
      return obj.map((item) => this.convertDates(item));
    }

    const converted = { ...obj };

    for (const key of Object.keys(converted)) {
      const value = converted[key];

      if (this.isDateString(value)) {
        converted[key] = new Date(value);
      } else if (typeof value === 'object' && value !== null) {
        converted[key] = this.convertDates(value);
      }
    }

    return converted;
  }

  private isDateString(value: any): boolean {
    if (typeof value !== 'string') return false;

    if (this.datePattern.test(value)) {
      const date = new Date(value);
      return !isNaN(date.getTime());
    }

    return false;
  }
}
