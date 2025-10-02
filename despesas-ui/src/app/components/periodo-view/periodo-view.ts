import { CommonModule } from '@angular/common';
import { Component, forwardRef, Input, OnInit } from '@angular/core';
import {
  ControlValueAccessor,
  FormsModule,
  NG_VALUE_ACCESSOR,
  ReactiveFormsModule,
} from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { SelectMes } from '../select-mes/select-mes';
import { InputTextModule } from 'primeng/inputtext';
import { Mes } from '../../models/mes.model';
import { Periodo } from '../../models/periodo.model';

@Component({
  selector: 'app-periodo-view',
  imports: [
    CommonModule,
    ReactiveFormsModule,
    ButtonModule,
    SelectMes,
    InputTextModule,
    FormsModule,
  ],
  templateUrl: './periodo-view.html',
  styleUrl: './periodo-view.scss',
  standalone: true,
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => PeriodoView),
      multi: true,
    },
  ],
})
export class PeriodoView implements ControlValueAccessor {
  value: any;
  mes?: Mes;
  ano?: number;
  disabled: boolean = false;

  private onChange: (value: any) => void = () => {};
  private onTouched: () => void = () => {};

  constructor() {}

  onYearInput(event: Event): void {
    const value = (event.target as HTMLInputElement).value;
    this.ano = parseInt(value);
    this.updateValue();
  }

  onYearBlur(): void {
    this.onTouched();
  }

  onMesSelected(mes: Mes) {
    this.mes = mes;
    this.updateValue();
  }

  setCurrent() {
    this.value = {
      mes: Mes.getMesAtual(),
      ano: new Date().getFullYear(),
    };

    this.ano = this.value.ano;
    this.mes = this.value.mes;

    this.onChange(this.value);
  }

  private updateValue(): void {
    if (this.isPeriodoValid()) {
      this.value = {
        mes: this.mes!,
        ano: this.ano!,
      } as Periodo;
    } else {
      this.value = null;
    }

    this.onChange(this.value);
  }

  private isPeriodoValid(): boolean {
    return !!(this.mes && this.ano);
  }

  writeValue(value: any): void {
    this.value = value;

    this.mes = this.value?.mes;
    this.ano = this.value?.ano;
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
