import { CommonModule } from '@angular/common';
import { Component, forwardRef, Input } from '@angular/core';
import { ControlValueAccessor, FormsModule, NG_VALUE_ACCESSOR } from '@angular/forms';
import { SelectModule } from 'primeng/select';
import { TipoMovimentacao } from '../../models/tipo-movimentacao.model';
import { ColorDisplay } from '../color-display/color-display';

@Component({
  selector: 'app-select-tipo-movimentacao',
  templateUrl: './select-tipo-movimentacao.html',
  styleUrl: './select-tipo-movimentacao.scss',
  standalone: true,
  imports: [CommonModule, FormsModule, SelectModule, ColorDisplay],
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => SelectTipoMovimentacao),
      multi: true,
    },
  ],
})
export class SelectTipoMovimentacao implements ControlValueAccessor {
  @Input()
  tipos: TipoMovimentacao[] = [];
  @Input()
  disabled: boolean = false;

  value: TipoMovimentacao | null = null;

  private onChange: (value: TipoMovimentacao | null) => void = () => {};
  private onTouched: () => void = () => {};

  onChangeValue(value: TipoMovimentacao | null): void {
    this.value = value;
    this.onChange(value);
  }

  onBlur(): void {
    this.onTouched();
  }

  writeValue(value: TipoMovimentacao | null): void {
    this.value = value || null;
  }

  registerOnChange(fn: any): void {
    this.onChange = fn;
  }

  registerOnTouched(fn: any): void {
    this.onTouched = fn;
  }

  setDisabledState(isDisabled: boolean): void {
    this.disabled = isDisabled;
  }
}
