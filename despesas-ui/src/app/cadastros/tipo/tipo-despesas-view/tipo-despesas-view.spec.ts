import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoDespesasView } from './tipo-despesas-view';

describe('TipoDespesasView', () => {
  let component: TipoDespesasView;
  let fixture: ComponentFixture<TipoDespesasView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TipoDespesasView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoDespesasView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
