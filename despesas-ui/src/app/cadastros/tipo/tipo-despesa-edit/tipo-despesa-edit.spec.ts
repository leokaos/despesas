import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoDespesaEdit } from './tipo-despesa-edit';

describe('TipoDespesaEdit', () => {
  let component: TipoDespesaEdit;
  let fixture: ComponentFixture<TipoDespesaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TipoDespesaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoDespesaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
