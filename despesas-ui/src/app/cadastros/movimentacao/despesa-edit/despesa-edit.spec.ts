import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DespesaEdit } from './despesa-edit';

describe('DespesaEdit', () => {
  let component: DespesaEdit;
  let fixture: ComponentFixture<DespesaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DespesaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DespesaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
