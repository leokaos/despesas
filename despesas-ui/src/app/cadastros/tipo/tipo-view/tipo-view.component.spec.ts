import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoViewComponent } from './tipo-view.component';

describe('TipoViewComponent', () => {
  let component: TipoViewComponent;
  let fixture: ComponentFixture<TipoViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [TipoViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
