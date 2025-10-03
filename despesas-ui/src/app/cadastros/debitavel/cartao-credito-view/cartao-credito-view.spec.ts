import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CartaoCreditoView } from './cartao-credito-view';

describe('CartaoCreditoView', () => {
  let component: CartaoCreditoView;
  let fixture: ComponentFixture<CartaoCreditoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CartaoCreditoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CartaoCreditoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
