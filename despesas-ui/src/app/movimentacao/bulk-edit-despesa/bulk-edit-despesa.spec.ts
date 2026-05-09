import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BulkEditDespesa } from './bulk-edit-despesa';

describe('BulkEditDespesa', () => {
  let component: BulkEditDespesa;
  let fixture: ComponentFixture<BulkEditDespesa>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BulkEditDespesa]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BulkEditDespesa);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
