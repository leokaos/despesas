import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InvestimentoView } from './investimento-view';

describe('InvestimentoView', () => {
  let component: InvestimentoView;
  let fixture: ComponentFixture<InvestimentoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InvestimentoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(InvestimentoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
