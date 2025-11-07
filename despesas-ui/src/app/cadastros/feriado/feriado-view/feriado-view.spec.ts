import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FeriadoView } from './feriado-view';

describe('FeriadoView', () => {
  let component: FeriadoView;
  let fixture: ComponentFixture<FeriadoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FeriadoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FeriadoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
