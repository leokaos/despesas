import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'avg',
  pure: false,
})
export class AvgPipe implements PipeTransform {

  transform(items: any[], attr: string): any {
    if (!items || !Array.isArray(items) || items.length == 0) return 0;
    return items.reduce((a, b) => a + (parseFloat(b[attr]) || 0), 0) / items.length;
  }


}
