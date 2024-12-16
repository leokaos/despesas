import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoReceitasViewComponent } from './tipo-receitas-view.component';

describe('TipoReceitasViewComponent', () => {
  let component: TipoReceitasViewComponent;
  let fixture: ComponentFixture<TipoReceitasViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TipoReceitasViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoReceitasViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
