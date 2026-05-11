import { Component, EventEmitter, inject, Input, Output, signal } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { DialogModule } from 'primeng/dialog';
import { MessageService } from 'primeng/api';
import { finalize, from, concatMap, tap } from 'rxjs';
import { AppProgressBar } from '../app-progress-bar/app-progress-bar';

@Component({
  selector: 'app-save-dialog',
  imports: [ButtonModule, DialogModule, AppProgressBar],
  templateUrl: './app-save-dialog.html',
  styleUrl: './app-save-dialog.scss',
})
export class AppSaveDialog {

  @Input() visible: boolean = false;
  @Input() items: any[] = [];
  @Input() saveFn!: (item: any) => any;
  @Input() successMessage: string = 'Itens salvos com sucesso!';

  @Output() visibleChange = new EventEmitter<boolean>();
  @Output() saved = new EventEmitter<void>();

  total = signal<number>(0);
  current = signal<number>(0);
  executing = signal<boolean>(false);

  private messageService = inject(MessageService);

  constructor() { }

  save() {

    this.total.set(this.items.length);
    this.current.set(0);
    this.executing.set(true);

    from(this.items).pipe(
      concatMap(item => this.saveFn(item).pipe(
        tap(() => this.current.update(v => v + 1))
      )),
      finalize(() => {

        this.visible = false;
        this.visibleChange.emit(false);

        if (this.current() === this.total()) {

          this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: this.successMessage });

          this.total.set(0);
          this.current.set(0);
          this.executing.set(false);

          this.saved.emit();
        }
      })

    ).subscribe({
      error: (error) => this.messageService.add({ severity: 'error', summary: 'Erro', detail: `Erro ao salvar: ${error.message}` })
    });

  }

  cancel() {
    this.visible = false;
    this.visibleChange.emit(false);
  }

}