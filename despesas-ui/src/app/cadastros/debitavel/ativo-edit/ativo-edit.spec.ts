import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AtivoEdit } from './ativo-edit';

describe('AtivoEdit', () => {
  let component: AtivoEdit;
  let fixture: ComponentFixture<AtivoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AtivoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AtivoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
