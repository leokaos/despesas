import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LancamentoDespesa } from './lancamento-despesa';

describe('LancamentoDespesa', () => {
  let component: LancamentoDespesa;
  let fixture: ComponentFixture<LancamentoDespesa>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LancamentoDespesa]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LancamentoDespesa);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
