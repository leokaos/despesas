import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SelectMoeda } from './select-moeda';

describe('SelectMoeda', () => {
  let component: SelectMoeda;
  let fixture: ComponentFixture<SelectMoeda>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SelectMoeda]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SelectMoeda);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
