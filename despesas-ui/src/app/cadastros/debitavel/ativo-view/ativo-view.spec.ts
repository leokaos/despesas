import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AtivoView } from './ativo-view';

describe('AtivoView', () => {
  let component: AtivoView;
  let fixture: ComponentFixture<AtivoView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AtivoView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AtivoView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
