import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoEditComponent } from './tipo-edit.component';

describe('TipoEditComponent', () => {
  let component: TipoEditComponent;
  let fixture: ComponentFixture<TipoEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TipoEditComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
