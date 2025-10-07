import { DecimalPipe, isPlatformBrowser } from '@angular/common';
import { ChangeDetectorRef, Component, effect, inject, OnInit, PLATFORM_ID } from '@angular/core';
import { ChartModule } from 'primeng/chart';
import { ButtonModule } from "primeng/button";
import { CarouselModule } from 'primeng/carousel';
import { Moeda } from '../../models/debitavel.model';

@Component({
  selector: 'app-dashboard',
  imports: [ChartModule, ButtonModule, CarouselModule, DecimalPipe],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.scss'
})
export class Dashboard {

  debitaveis = [
    {
      "limite": 10000.00,
      "bandeira": "VISA",
      "limiteAtual": null,
      "diaDeVencimento": 25,
      "diaDeFechamento": 10,
      "tipo": "CARTAO",
      "saldo": 10000.00,
      "id": 8,
      "descricao": "Porto Seguro",
      "cor": "#0058e6",
      "ativo": true,
      "moeda": Moeda.REAL
    },
    {
      "tipo": "CONTA",
      "saldo": 10000.00,
      "id": 25,
      "descricao": "Itaú",
      "cor": "#a68312",
      "ativo": true,
      "moeda": Moeda.REAL
    },
    {
      "tipo": "CONTA",
      "saldo": 500.00,
      "id": 26,
      "descricao": "N26",
      "cor": "#3fa183",
      "ativo": true,
      "moeda": Moeda.EURO
    }
  ]

  graficos: any[] = [
    {
      "tipoGrafico": "PIZZA",
      "dados": [],
      "titulo": "Despesas Por Tipo"
    },
    {
      "tipoGrafico": "PIZZA",
      "dados": [],
      "titulo": "Receitas Por Tipo"
    },
    {
      "tipoGrafico": "BARRAS",
      "dados": [
        {
          "legenda": "Receitas",
          "valor": 0,
          "cor": "#42E87D"
        },
        {
          "legenda": "Despesas",
          "valor": 0,
          "cor": "#F54047"
        },
        {
          "legenda": "Transferências",
          "valor": 0,
          "cor": "#706EBB"
        }
      ],
      "titulo": "Extrato Mensal"
    }
  ];

  anterior() { }

  posterior() { }

}