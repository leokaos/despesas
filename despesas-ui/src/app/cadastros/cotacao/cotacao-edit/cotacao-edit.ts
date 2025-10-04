import { Cotacao } from './../../../models/cotacao.model';
import { Component, inject, signal } from '@angular/core';
import { CotacaoService } from '../../../services/cotacao-service';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { ButtonModule } from 'primeng/button';
import { DatePickerModule } from 'primeng/datepicker';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { Loader } from '../../../components/loader/loader';
import { SelectMoeda } from "../../../components/select-moeda/select-moeda";

@Component({
  selector: 'app-cotacao-edit',
  imports: [
    Loader,
    InputGroupModule,
    ButtonModule,
    InputNumberModule,
    InputGroupAddonModule,
    ReactiveFormsModule,
    InputTextModule,
    DatePickerModule,
    SelectMoeda
  ],
  templateUrl: './cotacao-edit.html',
  styleUrl: './cotacao-edit.scss'
})
export class CotacaoEdit {
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private cotacaoService = inject(CotacaoService);

  formGroup!: FormGroup;
  cotacao?: Cotacao;

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {

    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.cotacaoService.fetchById(parseInt(id)).subscribe((cotacao: Cotacao) => {
        this.cotacao = cotacao;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }

  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      taxa: [this.cotacao?.taxa, Validators.required],
      data: [this.cotacao?.data, Validators.required],
      origem: [this.cotacao?.origem, Validators.required],
      destino: [this.cotacao?.destino, Validators.required],
    });

    this.loading.set(false);
  }

  save() {

    let cotacao = {
      ...this.formGroup.value,
      id: this.cotacao?.id
    } as Cotacao;

    this.cotacaoService.createOrUpdate(cotacao).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Cotação salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['cotacoes']);
  }

  cancel() {
    this.returnToView();
  }
}
