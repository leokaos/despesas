import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ServicoTransferenciaView } from './servico-transferencia-view';

describe('ServicoTransferenciaView', () => {
  let component: ServicoTransferenciaView;
  let fixture: ComponentFixture<ServicoTransferenciaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ServicoTransferenciaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ServicoTransferenciaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
