import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { MessageService } from 'primeng/api';
import { Button } from 'primeng/button';
import { ColorPickerModule } from 'primeng/colorpicker';
import { InputGroupModule } from 'primeng/inputgroup';
import { InputGroupAddonModule } from 'primeng/inputgroupaddon';
import { InputNumberModule } from 'primeng/inputnumber';
import { InputTextModule } from 'primeng/inputtext';
import { Loader } from '../../../components/loader/loader';
import { ServicoTransferencia } from '../../../models/servico-transferencia.model';
import { ServicoTransferenciaService } from './../../../services/servico-transferencia-service';
import { Component, inject, signal } from '@angular/core';
import { ToggleSwitchModule } from 'primeng/toggleswitch';

@Component({
  selector: 'app-servico-transferencia-edit',
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
    ToggleSwitchModule,
  ],
  templateUrl: './servico-transferencia-edit.html',
  styleUrl: './servico-transferencia-edit.scss'
})
export class ServicoTransferenciaEdit {

  private router = inject(Router);
  private formBuilder = inject(FormBuilder);
  private activatedRoute = inject(ActivatedRoute);
  private messageService = inject(MessageService);
  private servicoTransferenciaService = inject(ServicoTransferenciaService);

  formGroup!: FormGroup;
  servicoTransferencia?: ServicoTransferencia;

  loading = signal<boolean>(true);

  constructor() { }

  ngOnInit(): void {
    var id = this.activatedRoute.snapshot.paramMap.get('id');

    if (id) {
      this.servicoTransferenciaService.fetchById(parseInt(id)).subscribe((servicoTransferencia: ServicoTransferencia) => {
        this.servicoTransferencia = servicoTransferencia;
        this.buildForm();
      });
    } else {
      this.buildForm();
    }
  }

  private buildForm() {
    this.formGroup = this.formBuilder.group({
      nome: [this.servicoTransferencia?.nome, Validators.required],
      spred: [this.servicoTransferencia?.spred, Validators.required],
      taxas: [this.servicoTransferencia?.taxas, Validators.required],
      custoVariavel: [this.servicoTransferencia?.custoVariavel || false, Validators.required],
    });

    this.loading.set(false);
  }

  save() {
    let servicoTransferencia = {
      ...this.formGroup.value,
      id: this.servicoTransferencia?.id,
    } as ServicoTransferencia;

    this.servicoTransferenciaService.createOrUpdate(servicoTransferencia).subscribe((_) => {
      this.messageService.add({ severity: 'success', summary: 'Sucesso', detail: 'Serviço de Transferência salva com sucesso!', life: 3000 });
      this.returnToView();
    });
  }

  returnToView() {
    this.router.navigate(['servicos-transferencia']);
  }

  cancel() {
    this.returnToView();
  }
}
