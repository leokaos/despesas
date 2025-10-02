import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrcamentoView } from './orcamento-view';

describe('OrcamentoView', () => {
  let component: OrcamentoView;
  let fixture: ComponentFixture<OrcamentoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrcamentoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrcamentoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
