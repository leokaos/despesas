import { TestBed } from '@angular/core/testing';

import { DebitavelService } from './debitavel-service';

describe('DebitavelService', () => {
  let service: DebitavelService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DebitavelService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
