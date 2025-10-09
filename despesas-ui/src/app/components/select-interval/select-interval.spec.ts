import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SelectInterval } from './select-interval';

describe('SelectInterval', () => {
  let component: SelectInterval;
  let fixture: ComponentFixture<SelectInterval>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SelectInterval]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SelectInterval);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
