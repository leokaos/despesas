import { CommonModule } from '@angular/common';
import { Component, EventEmitter, forwardRef, Input, Output } from '@angular/core';
import { ControlValueAccessor, FormsModule, NG_VALUE_ACCESSOR } from '@angular/forms';
import { SelectModule } from 'primeng/select';
import { ColorDisplay } from '../color-display/color-display';
import { Debitavel } from '../../models/debitavel.model';

@Component({
  selector: 'app-select-debitavel',
  templateUrl: './select-debitavel.html',
  styleUrl: './select-debitavel.scss',
  imports: [CommonModule, FormsModule, SelectModule, ColorDisplay],
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => SelectDebitavel),
      multi: true,
    },
  ],
})
export class SelectDebitavel implements ControlValueAccessor {
  @Input()
  debitaveis: Debitavel[] = [];
  @Input()
  disabled: boolean = false;
  @Input()
  placeholder?: string;
  @Output()
  onSelect: EventEmitter<Debitavel | null> = new EventEmitter<Debitavel | null>();

  value: Debitavel | null = null;

  private onChange: (value: Debitavel | null) => void = () => { };
  private onTouched: () => void = () => { };

  onChangeValue(value: Debitavel | null): void {
    this.value = value;
    this.onChange(value);
  }

  onBlur(): void {
    this.onTouched();
  }

  writeValue(value: Debitavel | null): void {
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

  emitChange() {
    this.onSelect.emit(this.value);
  }
}
