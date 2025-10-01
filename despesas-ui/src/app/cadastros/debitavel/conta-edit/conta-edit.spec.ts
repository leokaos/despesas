import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContaEdit } from './conta-edit';

describe('ContaEdit', () => {
  let component: ContaEdit;
  let fixture: ComponentFixture<ContaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ContaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ContaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
