import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-tipo-edit',
  templateUrl: './tipo-edit.component.html',
  styleUrl: './tipo-edit.component.scss'
})
export class TipoEditComponent {

  @Input()
  titulo: string = "Tipo"

}
