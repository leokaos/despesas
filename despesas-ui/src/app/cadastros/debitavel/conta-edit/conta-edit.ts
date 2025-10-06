import { MessageService } from 'primeng/api';
import { Component, inject, signal } from '@angular/core';
import { Button } from 'primeng/button';
import { ContaService } from '../../../services/conta-service';
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
import { Conta, Moeda } from '../../../models/debitavel.model';
import { Loader } from '../../../components/loader/loader';

@Component({
  selector: 'app-conta-edit',
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
  ],
  templateUrl: './conta-edit.html',
  styleUrl: './conta-edit.scss',
})
export class ContaEdit {
  private contaService = inject(ContaService);
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);

  formGroup!: FormGroup;
  conta?: Conta;

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.contaService.fetchById(parseInt(id)).subscribe((conta: Conta) => {
        this.conta = conta;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.conta?.descricao || null, Validators.required],
      cor: [this.conta?.cor, Validators.required],
      saldo: [this.conta?.saldo || 0, Validators.required],
      moeda: [this.conta?.moeda || null, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var conta = {
      id: this.conta?.id,
      ...this.formGroup.value,
    } as Conta;

    this.contaService.createOrUpdate(conta).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Conta salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  cancel() {
    this.returnToView();
  }

  returnToView() {
    this.router.navigate(['contas']);
  }

}
