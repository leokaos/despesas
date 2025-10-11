import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'sum',
  pure: false
})
export class SumPipe implements PipeTransform {

  transform(items: any[], attr: string): any {
    if (!items || !Array.isArray(items)) return 0;
    return items.reduce((a, b) => a + (parseFloat(b[attr]) || 0), 0);
  }

}