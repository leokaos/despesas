import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SelectMes } from './select-mes';

describe('SelectMes', () => {
  let component: SelectMes;
  let fixture: ComponentFixture<SelectMes>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SelectMes]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SelectMes);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
