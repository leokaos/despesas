import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoEdit } from './tipo-edit';

describe('TipoEdit', () => {
  let component: TipoEdit;
  let fixture: ComponentFixture<TipoEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TipoEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
