import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AlertEdit } from './alert-edit';

describe('AlertEdit', () => {
  let component: AlertEdit;
  let fixture: ComponentFixture<AlertEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AlertEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AlertEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
