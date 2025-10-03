import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DividaView } from './divida-view';

describe('DividaView', () => {
  let component: DividaView;
  let fixture: ComponentFixture<DividaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DividaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DividaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
