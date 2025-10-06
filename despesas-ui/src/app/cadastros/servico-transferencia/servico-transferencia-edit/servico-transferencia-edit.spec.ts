import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ServicoTransferenciaEdit } from './servico-transferencia-edit';

describe('ServicoTransferenciaEdit', () => {
  let component: ServicoTransferenciaEdit;
  let fixture: ComponentFixture<ServicoTransferenciaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ServicoTransferenciaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ServicoTransferenciaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
