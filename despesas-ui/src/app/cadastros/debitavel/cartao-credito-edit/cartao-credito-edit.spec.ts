import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CartaoCreditoEdit } from './cartao-credito-edit';

describe('CartaoCreditoEdit', () => {
  let component: CartaoCreditoEdit;
  let fixture: ComponentFixture<CartaoCreditoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CartaoCreditoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CartaoCreditoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
