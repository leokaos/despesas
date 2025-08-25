import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoReceitaEditComponent } from './tipo-receita-edit.component';

describe('TipoReceitaEditComponent', () => {
  let component: TipoReceitaEditComponent;
  let fixture: ComponentFixture<TipoReceitaEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TipoReceitaEditComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoReceitaEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
