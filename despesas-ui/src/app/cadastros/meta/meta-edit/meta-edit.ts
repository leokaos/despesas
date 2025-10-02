import { Component, inject, signal } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { Button } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { Loader } from '../../../components/loader/loader';
import { Meta } from '../../../models/meta.model';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { MetaService } from '../../../services/meta-service';
import { SelectMes } from '../../../components/select-mes/select-mes';
import { Mes } from '../../../models/mes.model';

@Component({
  selector: 'app-meta-edit',
  imports: [
    Button,
    ColorPickerModule,
    InputGroupModule,
    InputGroupAddonModule,
    InputNumberModule,
    InputTextModule,
    FormsModule,
    ReactiveFormsModule,
    Loader,
    SelectMes,
  ],
  templateUrl: './meta-edit.html',
  styleUrl: './meta-edit.scss',
})
export class MetaEdit {
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private metaService = inject(MetaService);

  formGroup!: FormGroup;
  meta?: Meta;
  mesSelecionado: Mes = Mes.getMesAtual();
  anoSelecionado: number = new Date().getFullYear();

  loading = signal<boolean>(true);

  constructor() {}

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.metaService.fetchById(parseInt(id)).subscribe((meta: Meta) => {
        this.meta = meta;
        this.mesSelecionado = Mes.getPorId(this.meta.mes.mes - 1) || Mes.getMesAtual();
        this.buildForm();
      });
    } else {
      this.setToCurrentMonth();
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      saldo: [this.meta?.valor || 0, Validators.required],
      ano: [this.meta?.mes.ano || this.anoSelecionado, Validators.required],
      mes: [this.mesSelecionado, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    //{"valor":11111.11,"mes":{"mes":"12","ano":2025}}
  }

  returnToView() {
    this.router.navigate(['metas']);
  }

  cancel() {
    this.returnToView();
  }

  changeMes(mes: Mes) {}

  setToCurrentMonth() {
    this.mesSelecionado = Mes.getMesAtual();
    this.anoSelecionado = new Date().getFullYear();
  }
}
