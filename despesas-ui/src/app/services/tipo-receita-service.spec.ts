import { TestBed } from '@angular/core/testing';

import { TipoReceitaService } from './tipo-receita-service';

describe('TipoReceitService', () => {
  let service: TipoReceitaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TipoReceitaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
