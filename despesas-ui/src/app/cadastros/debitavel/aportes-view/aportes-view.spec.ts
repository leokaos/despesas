import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AportesView } from './aportes-view';

describe('AportesView', () => {
  let component: AportesView;
  let fixture: ComponentFixture<AportesView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AportesView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AportesView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
