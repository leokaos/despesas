import { Component, inject, signal } from '@angular/core';
import {
  FormsModule,
  ReactiveFormsModule,
  FormBuilder,
  FormGroup,
  Validators,
} from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Button } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { Loader } from '../../../components/loader/loader';
import { SelectMoeda } from '../../../components/select-moeda/select-moeda';
import { Divida } from '../../../models/debitavel.model';
import { DatePickerModule } from 'primeng/datepicker';
import { Select } from 'primeng/select';
import { DividaService } from '../../../services/divida-service';

@Component({
  selector: 'app-divida-edit',
  imports: [
    Button,
    ColorPickerModule,
    SelectMoeda,
    InputGroupModule,
    InputGroupAddonModule,
    InputNumberModule,
    InputTextModule,
    FormsModule,
    ReactiveFormsModule,
    Loader,
    DatePickerModule,
    Select,
  ],
  templateUrl: './divida-edit.html',
  styleUrl: './divida-edit.scss',
})
export class DividaEdit {
  private dividaService = inject(DividaService);
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);

  formGroup!: FormGroup;
  divida?: Divida;
  periodicidade: string[] = ['MENSAL', 'SEMESTRAL', 'VARIAVEL'];

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.dividaService.fetchById(parseInt(id)).subscribe((divida: Divida) => {
        this.divida = divida;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.divida?.descricao, Validators.required],
      cor: [this.divida?.cor, Validators.required],
      valorTotal: [this.divida?.valorTotal, Validators.required],
      moeda: [this.divida?.moeda, Validators.required],
      dataInicio: [this.divida?.dataInicio, Validators.required],
      periodicidade: [this.divida?.periodicidade, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    let divida = {
      id: this.divida?.id,
      tipo: this.divida?.tipo,
      ...this.formGroup.value,
    } as Divida;

    this.dividaService.createOrUpdate(divida).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Dívida salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  cancel() {
    this.returnToView();
  }

  returnToView() {
    this.router.navigate(['dividas']);
  }

}
