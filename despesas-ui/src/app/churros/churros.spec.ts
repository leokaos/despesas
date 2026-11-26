import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Churros } from './churros';

describe('Churros', () => {
  let component: Churros;
  let fixture: ComponentFixture<Churros>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Churros]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Churros);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
