import { EventEmitter, OnInit, Output } from '@angular/core';
import { Component } from '@angular/core';
import { Interval } from '../../models/interval.model';
import { SelectChangeEvent, SelectModule } from "primeng/select";
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-select-interval',
  imports: [SelectModule, FormsModule],
  templateUrl: './select-interval.html',
  styleUrl: './select-interval.scss'
})
export class SelectInterval {

  readonly INTERVALS: Interval[] = Interval.values();

  value?: Interval;

  @Output()
  onChange: EventEmitter<Interval> = new EventEmitter<Interval>();

  constructor() { }

  emitChange(event: SelectChangeEvent) {
    this.onChange.emit(this.value);
  }
}
