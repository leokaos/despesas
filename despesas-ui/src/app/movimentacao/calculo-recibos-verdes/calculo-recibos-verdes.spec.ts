import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CalculoRecibosVerdes } from './calculo-recibos-verdes';

describe('CalculoRecibosVerdes', () => {
  let component: CalculoRecibosVerdes;
  let fixture: ComponentFixture<CalculoRecibosVerdes>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CalculoRecibosVerdes]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CalculoRecibosVerdes);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
