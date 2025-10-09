import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExtratoMensal } from './extrato-mensal';

describe('ExtratoMensal', () => {
  let component: ExtratoMensal;
  let fixture: ComponentFixture<ExtratoMensal>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ExtratoMensal]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ExtratoMensal);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
