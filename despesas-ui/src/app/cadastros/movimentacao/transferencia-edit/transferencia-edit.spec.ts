import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransferenciaEdit } from './transferencia-edit';

describe('TransferenciaEdit', () => {
  let component: TransferenciaEdit;
  let fixture: ComponentFixture<TransferenciaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TransferenciaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TransferenciaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
