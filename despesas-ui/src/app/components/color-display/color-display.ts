import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-color-display',
  imports: [],
  templateUrl: './color-display.html',
  styleUrl: './color-display.scss',
})
export class ColorDisplay {
  @Input()
  color: string = '#000000';

  @Input()
  text?: string;
}
