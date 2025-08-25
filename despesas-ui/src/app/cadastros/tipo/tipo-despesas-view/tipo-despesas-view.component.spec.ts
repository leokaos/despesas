import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoDespesasViewComponent } from './tipo-despesas-view.component';

describe('TipoDespesasViewComponent', () => {
  let component: TipoDespesasViewComponent;
  let fixture: ComponentFixture<TipoDespesasViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TipoDespesasViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoDespesasViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
