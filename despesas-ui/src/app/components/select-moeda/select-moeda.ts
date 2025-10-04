import { Component, EventEmitter, forwardRef, Input, Output } from '@angular/core';
import { SelectChangeEvent, SelectModule } from 'primeng/select';
import { Moeda } from '../../models/debitavel.model';
import { ControlValueAccessor, FormsModule, NG_VALUE_ACCESSOR } from '@angular/forms';

@Component({
  selector: 'app-select-moeda',
  imports: [SelectModule, FormsModule],
  templateUrl: './select-moeda.html',
  styleUrl: './select-moeda.scss',
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => SelectMoeda),
      multi: true,
    },
  ],
})
export class SelectMoeda implements ControlValueAccessor {

  @Input()
  initialValue?: Moeda;
  @Input()
  disabled: boolean = false;
  @Input()
  placeholder?: string;
  @Output()
  onSelect: EventEmitter<Moeda> = new EventEmitter<Moeda>();

  moedas: Moeda[] = Moeda.values();
  value: Moeda | null = null;

  private onChange: (value: Moeda | null) => void = () => { };
  private onTouched: () => void = () => { };

  onChangeValue(value: Moeda | null): void {
    this.value = value;
    this.onChange(value);
  }

  onBlur(): void {
    this.onTouched();
  }

  writeValue(value: Moeda | null): void {
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

  emitChange(event: SelectChangeEvent) {
    this.onSelect.emit(event.value);
  }
}
