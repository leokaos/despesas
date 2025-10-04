import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CotacaoView } from './cotacao-view';

describe('CotacaoView', () => {
  let component: CotacaoView;
  let fixture: ComponentFixture<CotacaoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CotacaoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CotacaoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
