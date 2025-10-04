import { TipoMovimentacao } from './../../../models/tipo-movimentacao.model';
import { Component, EventEmitter, inject, Input, OnInit, Output } from '@angular/core';
import { InputTextModule } from 'primeng/inputtext';
import { ColorPickerModule } from 'primeng/colorpicker';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ButtonModule } from 'primeng/button';

@Component({
  selector: 'app-tipo-edit',
  imports: [InputTextModule, ReactiveFormsModule, FormsModule, ColorPickerModule, ButtonModule],
  templateUrl: './tipo-edit.html',
  styleUrl: './tipo-edit.scss'
})
export class TipoEdit implements OnInit {

  @Input()
  titulo: string = "Tipos";

  @Input()
  tipo?: TipoMovimentacao;

  @Output()
  onCancel: EventEmitter<void> = new EventEmitter<void>();

  @Output()
  onSave: EventEmitter<TipoMovimentacao> = new EventEmitter<TipoMovimentacao>();

  private formBuilder = inject(FormBuilder);

  formGroup!: FormGroup;

  constructor() { }

  ngOnInit(): void {

    this.formGroup = this.formBuilder.group({
      descricao: [this.tipo?.descricao || null, Validators.required],
      cor: [this.tipo?.cor, Validators.required]
    });

  }

  emitCancel() {
    this.onCancel.emit();
  }

  emitSave() {

    var tipoMovimentacao = {
      id: this.tipo?.id,
      cor: this.formGroup.get('cor')?.getRawValue(),
      descricao: this.formGroup.get('descricao')?.getRawValue(),
    } as TipoMovimentacao;

    this.onSave.emit(tipoMovimentacao);
  }

}
