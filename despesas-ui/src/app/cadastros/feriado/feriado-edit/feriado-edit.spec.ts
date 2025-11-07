import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FeriadoEdit } from './feriado-edit';

describe('FeriadoEdit', () => {
  let component: FeriadoEdit;
  let fixture: ComponentFixture<FeriadoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FeriadoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FeriadoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
