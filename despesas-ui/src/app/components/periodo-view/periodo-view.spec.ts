import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PeriodoView } from './periodo-view';

describe('PeriodoView', () => {
  let component: PeriodoView;
  let fixture: ComponentFixture<PeriodoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PeriodoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PeriodoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
