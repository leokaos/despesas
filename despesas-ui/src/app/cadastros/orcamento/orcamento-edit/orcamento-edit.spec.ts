import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrcamentoEdit } from './orcamento-edit';

describe('OrcamentoEdit', () => {
  let component: OrcamentoEdit;
  let fixture: ComponentFixture<OrcamentoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrcamentoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrcamentoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
