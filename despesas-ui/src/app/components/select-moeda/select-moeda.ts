import { Component, EventEmitter, Input, Output } from '@angular/core';
import { SelectChangeEvent, SelectModule } from 'primeng/select';
import { Moeda } from '../../models/debitavel.model';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-select-moeda',
  imports: [SelectModule, FormsModule],
  templateUrl: './select-moeda.html',
  styleUrl: './select-moeda.scss',
})
export class SelectMoeda {
  moedas: Moeda[] = Moeda.values();

  @Input()
  initialValue?: Moeda;

  @Output()
  onSelect: EventEmitter<Moeda> = new EventEmitter<Moeda>();

  emitChange(event: SelectChangeEvent) {
    this.onSelect.emit(event.value);
  }
}
