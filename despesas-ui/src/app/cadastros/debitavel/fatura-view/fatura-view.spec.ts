import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FaturaView } from './fatura-view';

describe('FaturaView', () => {
  let component: FaturaView;
  let fixture: ComponentFixture<FaturaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FaturaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FaturaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
