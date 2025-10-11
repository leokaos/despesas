import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-progress-bar',
  imports: [],
  templateUrl: './app-progress-bar.html',
  styleUrl: './app-progress-bar.scss',
})
export class AppProgressBar {
  @Input() current: number = 0;

  @Input() total: number = 100;

  @Input() striped: boolean = false;

  @Input() animated: boolean = false;

  @Input() showLabel: boolean = false;

  @Input() showState: boolean = true;

  constructor() { }

  getBarClass(): string {
    let classes = 'progress-bar ';

    let percent = this.getSize();

    if (!this.showState) {
      classes += 'progress-bar-normal';
    } else {

      if (percent <= 70.0) {
        classes += 'progress-bar-success';
      } else if (percent > 70.0 && percent <= 80.0) {
        classes += 'progress-bar-warning';
      } else {
        classes += 'progress-bar-danger';
      }

    }

    return classes;
  }

  getSize() {
    let percentage = (this.current / this.total) * 100;

    return percentage > 100 ? 100 : percentage;
  }
}
