import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CompararServicosTransferencia } from './comparar-servicos-transferencia';

describe('CompararServicosTransferencia', () => {
  let component: CompararServicosTransferencia;
  let fixture: ComponentFixture<CompararServicosTransferencia>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CompararServicosTransferencia]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CompararServicosTransferencia);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
