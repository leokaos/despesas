import { Component, Inject } from '@angular/core';
import { RouterModule } from '@angular/router';
import { APP_CONFIG, AppConfig } from '../../app-config';

@Component({
  selector: 'app-header',
  imports: [RouterModule],
  templateUrl: './header.html',
  styleUrl: './header.scss'
})
export class Header {

  private openSubMenus: Set<string> = new Set();
  
  version: string;

  constructor(@Inject(APP_CONFIG) private config: AppConfig) {
    this.version = config.version;
   }

  toggleSubMenu(menuItem: string): void {
    if (this.openSubMenus.has(menuItem)) {
      this.openSubMenus.delete(menuItem);
    } else {
      this.openSubMenus.add(menuItem);
    }
  }

  isSubMenuOpen(menuItem: string): boolean {
    return this.openSubMenus.has(menuItem);
  }

}
