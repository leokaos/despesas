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
import { Mes } from '../../../models/mes.model';
import { PeriodoView } from '../../../components/periodo-view/periodo-view';
import { Periodo } from '../../../models/periodo.model';

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
    PeriodoView,
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

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.metaService.fetchById(parseInt(id)).subscribe((meta: Meta) => {
        this.meta = meta;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    let periodo =
      this.meta && this.meta.mes
        ? ({ mes: Mes.getPorId(this.meta.mes.mes - 1), ano: this.meta.mes.ano } as Periodo)
        : null;

    this.formGroup = this.formBuilder.group({
      valor: [this.meta?.valor || 0, Validators.required],
      periodo: [periodo, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var meta = {
      id: this.meta?.id,
      valor: this.formGroup.get('valor')?.getRawValue(),
      mes: {
        mes: this.formGroup.get('periodo')?.getRawValue().mes.id + 1,
        ano: this.formGroup.get('periodo')?.getRawValue().ano,
      },
    } as Meta;

    this.metaService.createOrUpdate(meta).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Meta salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['metas']);
  }

  cancel() {
    this.returnToView();
  }
}
