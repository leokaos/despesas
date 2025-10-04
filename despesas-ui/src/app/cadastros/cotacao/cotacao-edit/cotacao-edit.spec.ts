import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CotacaoEdit } from './cotacao-edit';

describe('CotacaoEdit', () => {
  let component: CotacaoEdit;
  let fixture: ComponentFixture<CotacaoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CotacaoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CotacaoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
