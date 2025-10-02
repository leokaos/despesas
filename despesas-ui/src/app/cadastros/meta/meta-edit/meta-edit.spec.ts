import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MetaEdit } from './meta-edit';

describe('MetaEdit', () => {
  let component: MetaEdit;
  let fixture: ComponentFixture<MetaEdit>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MetaEdit]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MetaEdit);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
