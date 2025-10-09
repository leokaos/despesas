import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GraficoTipoDespesa } from './grafico-tipo-despesa';

describe('GraficoTipoDespesa', () => {
  let component: GraficoTipoDespesa;
  let fixture: ComponentFixture<GraficoTipoDespesa>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GraficoTipoDespesa]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GraficoTipoDespesa);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
