import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReceitaView } from './receita-view';

describe('ReceitaView', () => {
  let component: ReceitaView;
  let fixture: ComponentFixture<ReceitaView>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ReceitaView]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ReceitaView);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
