import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoReceitasView } from './tipo-receitas-view';

describe('TipoReceitasView', () => {
  let component: TipoReceitasView;
  let fixture: ComponentFixture<TipoReceitasView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TipoReceitasView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoReceitasView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
