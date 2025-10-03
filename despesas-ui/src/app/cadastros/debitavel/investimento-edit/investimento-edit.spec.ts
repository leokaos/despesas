import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InvestimentoEdit } from './investimento-edit';

describe('InvestimentoEdit', () => {
  let component: InvestimentoEdit;
  let fixture: ComponentFixture<InvestimentoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InvestimentoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InvestimentoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
