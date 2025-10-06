import { TestBed } from '@angular/core/testing';

import { ServicoTransferenciaService } from './servico-transferencia-service';

describe('ServicoTransferenciaService', () => {
  let service: ServicoTransferenciaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ServicoTransferenciaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
