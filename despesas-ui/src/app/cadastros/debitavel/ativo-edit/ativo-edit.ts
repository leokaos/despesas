import { MessageService } from 'primeng/api';
import { Component, inject, signal } from '@angular/core';
import { Button } from 'primeng/button';
import { AtivoService } from '../../../services/ativo-service';
import { ActivatedRoute, Router } from '@angular/router';
import { ColorPickerModule } from 'primeng/colorpicker';
import { SelectMoeda } from '../../../components/select-moeda/select-moeda';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import {
  FormBuilder,
  FormGroup,
  Validators,
  FormsModule,
  ReactiveFormsModule,
} from '@angular/forms';
import { Loader } from '../../../components/loader/loader';
import { CheckboxModule } from 'primeng/checkbox';
import { SelectModule } from 'primeng/select';
import { Ativo } from '../../../models/debitavel.model';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-ativo-edit',
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
    CheckboxModule,
    SelectModule,
    CommonModule,
  ],
  templateUrl: './ativo-edit.html',
  styleUrl: './ativo-edit.scss',
})
export class AtivoEdit {

  private ativoService = inject(AtivoService);
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);

  formGroup!: FormGroup;
  ativo?: Ativo;

  loading = signal<boolean>(true);

  tiposAtivo = [
    { label: 'Carro', value: 'CARRO', icon: 'pi pi-car' },
    { label: 'Casa', value: 'CASA', icon: 'pi pi-home' },
    { label: 'Apartamento', value: 'APARTAMENTO', icon: 'pi pi-building' },
    { label: 'Terreno', value: 'TERRENO', icon: 'pi pi-map' },
  ];

  constructor() { }

  ngOnInit(): void {
    const id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.ativoService.fetchById(parseInt(id)).subscribe((ativo: Ativo) => {
        this.ativo = ativo;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.ativo?.descricao || null, Validators.required],
      cor: [this.ativo?.cor || '#3B3B3B', Validators.required],
      tipo: [this.ativo?.tipo || 'ATIVO', Validators.required],
      moeda: [this.ativo?.moeda || null, Validators.required],
      ativo: [this.ativo?.ativo ?? true, Validators.required],
      valorTotal: [this.ativo?.valorTotal || 0, Validators.required],
      tipoAtivo: [this.ativo?.tipoAtivo || null, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    const ativo = {
      id: this.ativo?.id,
      ...this.formGroup.value,
    } as Ativo;

    this.ativoService.createOrUpdate(ativo).subscribe(() => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Ativo salvo com sucesso!', life: 3000, });
      this.returnToView();
    });
  }

  cancel() {
    this.returnToView();
  }

  returnToView() {
    this.router.navigate(['ativos']);
  }
}