import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GraficoTipoReceita } from './grafico-tipo-receita';

describe('GraficoTipoReceita', () => {
  let component: GraficoTipoReceita;
  let fixture: ComponentFixture<GraficoTipoReceita>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GraficoTipoReceita]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GraficoTipoReceita);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
