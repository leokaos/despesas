import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContaView } from './conta-view';

describe('ContaView', () => {
  let component: ContaView;
  let fixture: ComponentFixture<ContaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ContaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ContaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
