import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ColorDisplay } from './color-display';

describe('ColorDisplay', () => {
  let component: ColorDisplay;
  let fixture: ComponentFixture<ColorDisplay>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ColorDisplay]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ColorDisplay);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
