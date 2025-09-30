import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoReceitaEdit } from './tipo-receita-edit';

describe('TipoReceitaEdit', () => {
  let component: TipoReceitaEdit;
  let fixture: ComponentFixture<TipoReceitaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TipoReceitaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoReceitaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
