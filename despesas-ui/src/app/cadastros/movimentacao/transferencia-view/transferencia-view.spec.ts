import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransferenciaView } from './transferencia-view';

describe('TransferenciaView', () => {
  let component: TransferenciaView;
  let fixture: ComponentFixture<TransferenciaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TransferenciaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TransferenciaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
