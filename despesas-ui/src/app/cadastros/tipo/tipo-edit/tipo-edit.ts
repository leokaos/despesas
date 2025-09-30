import { Component, inject, Input } from '@angular/core';
import { InputTextModule } from 'primeng/inputtext';
import { ColorPickerModule } from 'primeng/colorpicker';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';

@Component({
  selector: 'app-tipo-edit',
  imports: [InputTextModule, ReactiveFormsModule, FormsModule, ColorPickerModule],
  templateUrl: './tipo-edit.html',
  styleUrl: './tipo-edit.scss'
})
export class TipoEdit {

  @Input()
  titulo: string = "Tipos";

  private formBuilder = inject(FormBuilder);

  formGroup: FormGroup;

  constructor() {

    this.formGroup = this.formBuilder.group({
      descricao: ['', Validators.required],
      cor: ['', Validators.required]
    });
  }

}
