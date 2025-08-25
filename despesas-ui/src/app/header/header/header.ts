import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-header',
  imports: [RouterModule],
  templateUrl: './header.html',
  styleUrl: './header.scss'
})
export class Header {

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
