import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ComparacaoOrcamento } from './comparacao-orcamento';

describe('ComparacaoOrcamento', () => {
  let component: ComparacaoOrcamento;
  let fixture: ComponentFixture<ComparacaoOrcamento>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ComparacaoOrcamento]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ComparacaoOrcamento);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
