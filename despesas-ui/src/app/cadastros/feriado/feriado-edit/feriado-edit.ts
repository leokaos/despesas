import { Component, inject, OnInit, signal } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ButtonModule } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { Loader } from '../../../components/loader/loader';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { FeriadoService } from '../../../services/feriado-service';
import { Feriado } from '../../../models/feriado.model';
import { DatePicker, DatePickerModule } from "primeng/datepicker";
import { SelectModule } from 'primeng/select';

@Component({
  selector: 'app-feriado-edit',
  imports: [
    ButtonModule,
    ColorPickerModule,
    InputGroupModule,
    InputGroupAddonModule,
    InputNumberModule,
    InputTextModule,
    FormsModule,
    ReactiveFormsModule,
    Loader,
    SelectModule,
    DatePickerModule,
  ],
  templateUrl: './feriado-edit.html',
  styleUrl: './feriado-edit.scss'
})
export class FeriadoEdit implements OnInit {

  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private feriadoService = inject(FeriadoService);

  formGroup!: FormGroup;
  feriado?: Feriado;

  loading = signal<boolean>(true);

  tipos = [
    { label: 'Férias', value: 'FERIAS' },
    { label: 'Feriado', value: 'FERIADO' },
    { label: 'Fechado', value: 'FECHADO' }
  ];

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.feriadoService.fetchById(parseInt(id)).subscribe((feriado: Feriado) => {
        this.feriado = feriado;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {

    this.formGroup = this.formBuilder.group({
      tipo: [this.feriado?.tipo, Validators.required],
      data: [this.feriado?.data, Validators.required]
    });

    this.loading.set(false);
  }

  save() {

    var feriado = {
      ...this.formGroup.value
    } as Feriado;

    this.feriadoService.createOrUpdate(feriado).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Feriado salvo com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['feriados']);
  }

  cancel() {
    this.returnToView();
  }

}
