import { Component, inject, signal } from '@angular/core';
import { CartaoCreditoService } from '../../../services/cartao-credito-service';
import { Bandeira, CartaoCredito, Moeda } from '../../../models/debitavel.model';
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
import { SelectModule } from 'primeng/select';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { CheckboxModule } from 'primeng/checkbox';

@Component({
  selector: 'app-cartao-credito-edit',
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
    SelectMoeda,
    InputNumberModule,
    SelectModule,
    FontAwesomeModule,
    CheckboxModule,
  ],
  templateUrl: './cartao-credito-edit.html',
  styleUrl: './cartao-credito-edit.scss',
})
export class CartaoCreditoEdit {
  private cartaoCreditoService = inject(CartaoCreditoService);
  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);

  formGroup!: FormGroup;
  cartaoCredito?: CartaoCredito;
  dias = Array.from({ length: 31 }, (_, i) => i + 1);
  loading = signal<boolean>(true);
  bandeiras: Bandeira[] = Bandeira.values();

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.cartaoCreditoService
        .fetchById(parseInt(id))
        .subscribe((cartaoCredito: CartaoCredito) => {
          this.cartaoCredito = cartaoCredito;
          this.buildForm();
        });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      descricao: [this.cartaoCredito?.descricao, Validators.required],
      cor: [this.cartaoCredito?.cor, Validators.required],
      limite: [this.cartaoCredito?.limite, Validators.required],
      moeda: [this.cartaoCredito?.moeda, Validators.required],
      diaDeFechamento: [this.cartaoCredito?.diaDeFechamento, Validators.required],
      diaDeVencimento: [this.cartaoCredito?.diaDeVencimento, Validators.required],
      bandeira: [this.cartaoCredito?.bandeira, Validators.required],
      ativo: [this.cartaoCredito?.ativo || false, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    var cartaoCredito = {
      ...this.formGroup.value,
      id: this.cartaoCredito?.id,
    } as CartaoCredito;

    this.cartaoCreditoService.createOrUpdate(cartaoCredito).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Cartão de Crédito salvo com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  cancel() {
    this.returnToView();
  }

  returnToView() {
    this.router.navigate(['cartoes']);
  }

  selectMoeda(moeda: Moeda) {
    this.formGroup.get('moeda')?.setValue(moeda);
  }
}
