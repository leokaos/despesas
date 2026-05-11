import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppSaveDialog } from './app-save-dialog';

describe('AppSaveDialog', () => {
  let component: AppSaveDialog;
  let fixture: ComponentFixture<AppSaveDialog>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppSaveDialog]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AppSaveDialog);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
