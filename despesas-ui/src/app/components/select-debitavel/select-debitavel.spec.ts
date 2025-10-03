import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SelectDebitavel } from './select-debitavel';

describe('SelectDebitavel', () => {
  let component: SelectDebitavel;
  let fixture: ComponentFixture<SelectDebitavel>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SelectDebitavel]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SelectDebitavel);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
