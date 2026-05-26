import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PanelFiltro } from './panel-filtro';

describe('PanelFiltro', () => {
  let component: PanelFiltro;
  let fixture: ComponentFixture<PanelFiltro>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PanelFiltro]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PanelFiltro);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
