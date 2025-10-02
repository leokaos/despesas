import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MetaView } from './meta-view';

describe('MetaView', () => {
  let component: MetaView;
  let fixture: ComponentFixture<MetaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MetaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MetaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
