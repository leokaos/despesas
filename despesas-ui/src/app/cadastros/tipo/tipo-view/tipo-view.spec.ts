import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TipoView } from './tipo-view';

describe('TipoView', () => {
  let component: TipoView;
  let fixture: ComponentFixture<TipoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TipoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TipoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
