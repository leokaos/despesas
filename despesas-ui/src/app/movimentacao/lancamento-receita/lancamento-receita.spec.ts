import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LancamentoReceita } from './lancamento-receita';

describe('LancamentoReceita', () => {
  let component: LancamentoReceita;
  let fixture: ComponentFixture<LancamentoReceita>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LancamentoReceita]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LancamentoReceita);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
