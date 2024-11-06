import { Component } from '@angular/core';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrl: './header.component.scss',
})
export class HeaderComponent {

  private openSubMenus: Set<string> = new Set();

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
