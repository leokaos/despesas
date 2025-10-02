import { FormsModule } from '@angular/forms';
import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { SelectChangeEvent, SelectModule } from 'primeng/select';
import { Mes } from '../../models/mes.model';

@Component({
  selector: 'app-select-mes',
  imports: [SelectModule, FormsModule],
  templateUrl: './select-mes.html',
  styleUrl: './select-mes.scss',
})
export class SelectMes {
  @Input()
  initialValue?: Mes;

  @Output()
  onSelect: EventEmitter<Mes> = new EventEmitter<Mes>();

  meses = Mes.values();
  selectedValue?: Mes;

  emitChange(event: SelectChangeEvent) {
    this.onSelect.emit(event.value);
  }
}
