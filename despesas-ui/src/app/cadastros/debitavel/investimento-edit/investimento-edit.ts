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
import { Conta, Investimento, Moeda } from './../../../models/debitavel.model';
import { InvestimentoService } from './../../../services/investimento-service';
import { Component, inject, signal } from '@angular/core';
import { SelectModule } from 'primeng/select';

@Component({
  selector: 'app-investimento-edit',
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
    SelectModule,
  ],
  templateUrl: './investimento-edit.html',
  styleUrl: './investimento-edit.scss',
})
export class InvestimentoEdit {
  private investimentoService = inject(InvestimentoService);
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);

  formGroup!: FormGroup;
  investimento?: Investimento;
  periodicidade: string[] = ['MENSAL', 'SEMESTRAL', 'VARIAVEL'];

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.investimentoService.fetchById(parseInt(id)).subscribe((investimento: Investimento) => {
        this.investimento = investimento;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.investimento?.descricao || null, Validators.required],
      cor: [this.investimento?.cor, Validators.required],
      montante: [this.investimento?.montante, Validators.required],
      moeda: [this.investimento?.moeda || null, Validators.required],
      periodicidade: [this.investimento?.periodicidade, Validators.required],
      rendimento: [this.investimento?.rendimento, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var conta = {
      id: this.investimento?.id,
      ...this.formGroup.value,
    } as Investimento;

    this.investimentoService.createOrUpdate(conta).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Investimento salvo com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  cancel() {
    this.returnToView();
  }

  returnToView() {
    this.router.navigate(['investimentos']);
  }

}
