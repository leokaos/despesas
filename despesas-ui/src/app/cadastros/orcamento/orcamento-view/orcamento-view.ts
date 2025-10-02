import { Orcamento } from './../../../models/orcamento.model';
import { Component, inject, OnInit, signal } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { Loader } from '../../../components/loader/loader';
import { TableModule } from 'primeng/table';
import { IconField } from 'primeng/iconfield';
import { InputIcon } from 'primeng/inputicon';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { ColorDisplay } from '../../../components/color-display/color-display';
import { DialogModule } from 'primeng/dialog';
import { OrcamentoService } from '../../../services/orcamento-service';
import { InputTextModule } from 'primeng/inputtext';
import { CommonModule, DecimalPipe, JsonPipe } from '@angular/common';
import { ProgressBarModule } from 'primeng/progressbar';
import { AppProgressBar } from '../../../components/app-progress-bar/app-progress-bar';
import { PeriodoView } from '../../../components/periodo-view/periodo-view';
import { Periodo } from '../../../models/periodo.model';
import { Mes } from '../../../models/mes.model';

@Component({
  selector: 'app-orcamento-view',
  imports: [
    ButtonModule,
    Loader,
    TableModule,
    IconField,
    InputIcon,
    FormsModule,
    ColorDisplay,
    DialogModule,
    InputTextModule,
    DecimalPipe,
    ProgressBarModule,
    AppProgressBar,
    ReactiveFormsModule,
    CommonModule,
  ],
  templateUrl: './orcamento-view.html',
  styleUrl: './orcamento-view.scss',
})
export class OrcamentoView implements OnInit {
  data: Orcamento[] = [];
  searchValue?: string;
  loading = signal<boolean>(true);

  private orcamentoService = inject(OrcamentoService);

  ngOnInit(): void {
    this.loadData();
  }

  loadData() {
    this.orcamentoService.fetch().subscribe((data: Orcamento[]) => {
      this.data = [...data];
      this.loading.set(false);
    });
  }

  search() {}

  add() {}

  edit(orcamento: Orcamento) {}

  openDialog(orcamento: Orcamento) {}

  myForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.myForm = this.fb.group({
      username: [null, [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
    });
  }

  onSubmit() {
    console.log('Formulário enviado:', this.myForm.value);
  }
}
