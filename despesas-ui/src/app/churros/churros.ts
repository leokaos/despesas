import { Component, computed, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TableModule } from 'primeng/table';
import { InputNumberModule } from 'primeng/inputnumber';
import { ButtonModule } from 'primeng/button';
import { SelectModule } from 'primeng/select';
import { TooltipModule } from 'primeng/tooltip';
import { Loader } from '../components/loader/loader';

export interface FundoFii {
  id: string;
  ticker: string;
  segmento: string;
  cor: string;
  cotaInicial: number;   // 31/10/2025
  cotaFinal: number;     // 30/10/2026
  cotaHoje: number;      // 24/11/2026
}

export interface RendimentoMensal {
  competencia: string;                        // '10/2025'
  mesPagamento: string;                       // 'Nov/2025'
  valoresPorTicker: Record<string, number>;   // { KNCR11: 1.25, ... }
}

export interface ItemCarteira {
  fundo: FundoFii;
  valorInvestir: number;
}

@Component({
  selector: 'app-churros',
  imports: [
    CommonModule,
    FormsModule,
    TableModule,
    InputNumberModule,
    ButtonModule,
    SelectModule,
    TooltipModule,
    Loader
],
  templateUrl: './churros.html',
  styleUrl: './churros.scss',
})
export class Churros {
  // ---------- Estado ----------

  loading = signal<boolean>(true);

  fundos = signal<FundoFii[]>([]);
  rendimentos = signal<RendimentoMensal[]>([]);
  carteira = signal<ItemCarteira[]>([]);
  fundoDestacado = signal<string | null>(null);

  fundoSelecionado?: FundoFii;

  // ---------- Dados mocados (equivalente ao backend) ----------

  private readonly MOCK_FUNDOS: FundoFii[] = [
    { id: 'KNCR11', ticker: 'KNCR11', segmento: 'Papel (CDI)', cor: '#e3f2fd', cotaInicial: 106.00, cotaFinal: 104.98, cotaHoje: 103.00 },
    { id: 'KNRI11', ticker: 'KNRI11', segmento: 'Tijolo (Híbrido)', cor: '#e8f5e9', cotaInicial: 148.60, cotaFinal: 150.50, cotaHoje: 141.44 },
    { id: 'KNIP11', ticker: 'KNIP11', segmento: 'Papel (IPCA)', cor: '#fff3e0', cotaInicial: 88.57, cotaFinal: 85.51, cotaHoje: 85.23 },
    { id: 'KNSC11', ticker: 'KNSC11', segmento: 'Papel (IPCA/CDI)', cor: '#f3e5f5', cotaInicial: 8.83, cotaFinal: 8.74, cotaHoje: 8.06 },
  ];

  private readonly MOCK_RENDIMENTOS: RendimentoMensal[] = [
    { competencia: '10/2025', mesPagamento: 'Nov/2025', valoresPorTicker: { KNCR11: 1.25, KNRI11: 1.00, KNIP11: 0.62, KNSC11: 0.09 } },
    { competencia: '11/2025', mesPagamento: 'Dez/2025', valoresPorTicker: { KNCR11: 1.11, KNRI11: 1.00, KNIP11: 0.70, KNSC11: 0.09 } },
    { competencia: '12/2025', mesPagamento: 'Jan/2026', valoresPorTicker: { KNCR11: 1.30, KNRI11: 1.22, KNIP11: 0.75, KNSC11: 0.09 } },
    { competencia: '01/2026', mesPagamento: 'Fev/2026', valoresPorTicker: { KNCR11: 1.20, KNRI11: 0.88, KNIP11: 0.80, KNSC11: 0.09 } },
    { competencia: '02/2026', mesPagamento: 'Mar/2026', valoresPorTicker: { KNCR11: 1.00, KNRI11: 1.10, KNIP11: 0.85, KNSC11: 0.08 } },
    { competencia: '03/2026', mesPagamento: 'Abr/2026', valoresPorTicker: { KNCR11: 1.15, KNRI11: 1.10, KNIP11: 1.05, KNSC11: 0.09 } },
    { competencia: '04/2026', mesPagamento: 'Mai/2026', valoresPorTicker: { KNCR11: 1.10, KNRI11: 1.10, KNIP11: 1.25, KNSC11: 0.10 } },
    { competencia: '05/2026', mesPagamento: 'Jun/2026', valoresPorTicker: { KNCR11: 1.10, KNRI11: 1.10, KNIP11: 1.10, KNSC11: 0.09 } },
    { competencia: '06/2026', mesPagamento: 'Jul/2026', valoresPorTicker: { KNCR11: 1.10, KNRI11: 1.10, KNIP11: 0.80, KNSC11: 0.09 } },
    { competencia: '07/2026', mesPagamento: 'Ago/2026', valoresPorTicker: { KNCR11: 1.25, KNRI11: 1.10, KNIP11: 0.75, KNSC11: 0.09 } },
    { competencia: '08/2026', mesPagamento: 'Set/2026', valoresPorTicker: { KNCR11: 1.15, KNRI11: 1.10, KNIP11: 0.70, KNSC11: 0.08 } },
    { competencia: '09/2026', mesPagamento: 'Out/2026', valoresPorTicker: { KNCR11: 1.13, KNRI11: 1.10, KNIP11: 0.65, KNSC11: 0.08 } },
    { competencia: '10/2026', mesPagamento: 'Nov/2026', valoresPorTicker: { KNCR11: 1.10, KNRI11: 1.10, KNIP11: 0.80, KNSC11: 0.08 } },
  ];

  // ---------- Ciclo de vida ----------

  ngOnInit(): void {
    this.fundos.set(this.MOCK_FUNDOS);
    this.rendimentos.set(this.MOCK_RENDIMENTOS);
    this.loading.set(false);
  }

  // ---------- Ações ----------

  adicionarFundo(): void {
    if (!this.fundoSelecionado) return;

    const jaExiste = this.carteira().some((i) => i.fundo.id === this.fundoSelecionado!.id);
    if (jaExiste) return;

    this.carteira.update((c) => [
      ...c,
      { fundo: this.fundoSelecionado!, valorInvestir: 10000 },
    ]);
    this.fundoSelecionado = undefined;
  }

  removerItem(item: ItemCarteira): void {
    this.carteira.update((c) => c.filter((i) => i.fundo.id !== item.fundo.id));
    if (this.fundoDestacado() === item.fundo.ticker) {
      this.fundoDestacado.set(null);
    }
  }

  selecionarFundo(ticker: string): void {
    this.fundoDestacado.update((selecionado) => selecionado === ticker ? null : ticker);
  }

  // ---------- Cálculos por item ----------

  qtdCotas(item: ItemCarteira): number {
    return item.fundo.cotaHoje > 0
      ? Math.floor(item.valorInvestir / item.fundo.cotaHoje)
      : 0;
  }

  valorEfetivo(item: ItemCarteira): number {
    return this.qtdCotas(item) * item.fundo.cotaHoje;
  }

  troco(item: ItemCarteira): number {
    return item.valorInvestir - this.valorEfetivo(item);
  }

  variacaoUnitaria(item: ItemCarteira): number {
    return item.fundo.cotaFinal - item.fundo.cotaInicial;
  }

  variacaoTotal(item: ItemCarteira): number {
    return this.qtdCotas(item) * this.variacaoUnitaria(item);
  }

  proventosRecebidos(item: ItemCarteira): number {
    const qtd = this.qtdCotas(item);
    return this.rendimentos().reduce(
      (total, r) => total + (r.valoresPorTicker[item.fundo.ticker] ?? 0) * qtd,
      0
    );
  }

  ganhoLiquido(item: ItemCarteira): number {
    return this.proventosRecebidos(item) + this.variacaoTotal(item);
  }

  retornoPercent(item: ItemCarteira): number {
    const base = this.valorEfetivo(item);
    return base > 0 ? (this.ganhoLiquido(item) / base) * 100 : 0;
  }

  composicao(item: ItemCarteira): string {
    if (this.valorEfetivo(item) === 0) return 'Sem aporte';
    return this.variacaoTotal(item) < 0
      ? 'Dividendos superam depreciação da cota'
      : 'Dividendos + valorização da cota';
  }

  // ---------- Totais (computed) ----------

  totalInvestir = computed(() => this.carteira().reduce((t, i) => t + i.valorInvestir, 0));
  totalCotas = computed(() => this.carteira().reduce((t, i) => t + this.qtdCotas(i), 0));
  totalEfetivo = computed(() => this.carteira().reduce((t, i) => t + this.valorEfetivo(i), 0));
  totalTroco = computed(() => this.carteira().reduce((t, i) => t + this.troco(i), 0));
  totalProventos = computed(() => this.carteira().reduce((t, i) => t + this.proventosRecebidos(i), 0));
  totalVariacao = computed(() => this.carteira().reduce((t, i) => t + this.variacaoTotal(i), 0));
  totalGanho = computed(() => this.carteira().reduce((t, i) => t + this.ganhoLiquido(i), 0));
  totalRetorno = computed(() =>
    this.totalEfetivo() > 0 ? (this.totalGanho() / this.totalEfetivo()) * 100 : 0
  );

  // ---------- Rendimentos por linha (tabela mensal) ----------

  recebidoPorTicker(r: RendimentoMensal, item: ItemCarteira): number {
    return (r.valoresPorTicker[item.fundo.ticker] ?? 0) * this.qtdCotas(item);
  }

  subtotalMensal(r: RendimentoMensal): number {
    return this.carteira().reduce((t, i) => t + this.recebidoPorTicker(r, i), 0);
  }

}
