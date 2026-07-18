import { Component, output, signal } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { DataViewModule } from 'primeng/dataview';
import { DialogModule } from 'primeng/dialog';
import { IconFieldModule } from 'primeng/iconfield';
import { InputIconModule } from 'primeng/inputicon';
import { InputTextModule } from 'primeng/inputtext';
import { SelectButtonModule } from 'primeng/selectbutton';
import { TableModule } from 'primeng/table';
import { ToggleButtonModule } from 'primeng/togglebutton';

@Component({
  selector: 'app-debitavel-header',
  imports: [
    ButtonModule,
    DataViewModule,
    TableModule,
    IconFieldModule,
    FormsModule,
    DialogModule,
    InputIconModule,
    ReactiveFormsModule,
    ColorPickerModule,
    InputTextModule,
    SelectButtonModule,
    ToggleButtonModule
  ],
  templateUrl: './debitavel-header.html',
  styleUrl: './debitavel-header.scss',
})
export class DebitavelHeader {

  mostrarApenasAtivos = signal<boolean>(true);
  searchValue = signal<string>('');

  onApenasAtivosChanged = output<boolean>();
  onReloadClicked = output<void>();
  onSearchValueChanged = output<string>();

  changeAtivos(value: boolean) {
    this.mostrarApenasAtivos.set(value);
    this.onApenasAtivosChanged.emit(value);
  }

  reload() {
    this.onReloadClicked.emit();
  }

  search() {
    this.onSearchValueChanged.emit(this.searchValue());
  }

}
