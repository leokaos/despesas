import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SelectTipoMovimentacao } from './select-tipo-movimentacao';

describe('SelectTipoMovimentacao', () => {
  let component: SelectTipoMovimentacao;
  let fixture: ComponentFixture<SelectTipoMovimentacao>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SelectTipoMovimentacao]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SelectTipoMovimentacao);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
