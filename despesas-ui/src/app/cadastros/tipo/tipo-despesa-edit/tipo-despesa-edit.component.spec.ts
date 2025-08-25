import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoDespesaEditComponent } from './tipo-despesa-edit.component';

describe('TipoDespesaEditComponent', () => {
  let component: TipoDespesaEditComponent;
  let fixture: ComponentFixture<TipoDespesaEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TipoDespesaEditComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoDespesaEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
