import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BulkEditReceita } from './bulk-edit-receita';

describe('BulkEditReceita', () => {
  let component: BulkEditReceita;
  let fixture: ComponentFixture<BulkEditReceita>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BulkEditReceita]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BulkEditReceita);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
