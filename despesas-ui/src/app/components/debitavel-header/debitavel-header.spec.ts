import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DebitavelHeader } from './debitavel-header';

describe('DebitavelHeader', () => {
  let component: DebitavelHeader;
  let fixture: ComponentFixture<DebitavelHeader>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DebitavelHeader]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DebitavelHeader);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
