import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Projecao } from './projecao';

describe('Projecao', () => {
  let component: Projecao;
  let fixture: ComponentFixture<Projecao>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Projecao]
    })
    .compileComponents();

    fixture = TestBed.createComponent(Projecao);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
