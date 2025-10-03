import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DividaEdit } from './divida-edit';

describe('DividaEdit', () => {
  let component: DividaEdit;
  let fixture: ComponentFixture<DividaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DividaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DividaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
