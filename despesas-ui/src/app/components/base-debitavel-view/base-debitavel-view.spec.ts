import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BaseDebitavelView } from './base-debitavel-view';

describe('BaseDebitavelView', () => {
  let component: BaseDebitavelView;
  let fixture: ComponentFixture<BaseDebitavelView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BaseDebitavelView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BaseDebitavelView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
