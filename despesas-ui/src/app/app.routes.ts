import { CompararServicosTransferencia } from './movimentacao/comparar-servicos-transferencia/comparar-servicos-transferencia';
import { ServicoTransferenciaEdit } from './cadastros/servico-transferencia/servico-transferencia-edit/servico-transferencia-edit';
import { ServicoTransferenciaView } from './cadastros/servico-transferencia/servico-transferencia-view/servico-transferencia-view';
import { TransferenciaEdit } from './cadastros/movimentacao/transferencia-edit/transferencia-edit';
import { TransferenciaView } from './cadastros/movimentacao/transferencia-view/transferencia-view';
import { Routes } from '@angular/router';
import { TipoDespesasView } from './cadastros/tipo/tipo-despesas-view/tipo-despesas-view';
import { TipoReceitasView } from './cadastros/tipo/tipo-receitas-view/tipo-receitas-view';
import { TipoDespesaEdit } from './cadastros/tipo/tipo-despesa-edit/tipo-despesa-edit';
import { TipoReceitaEdit } from './cadastros/tipo/tipo-receita-edit/tipo-receita-edit';
import { ContaView } from './cadastros/debitavel/conta-view/conta-view';
import { ContaEdit } from './cadastros/debitavel/conta-edit/conta-edit';
import { MetaView } from './cadastros/meta/meta-view/meta-view';
import { MetaEdit } from './cadastros/meta/meta-edit/meta-edit';
import { OrcamentoView } from './cadastros/orcamento/orcamento-view/orcamento-view';
import { OrcamentoEdit } from './cadastros/orcamento/orcamento-edit/orcamento-edit';
import { DividaView } from './cadastros/debitavel/divida-view/divida-view';
import { DividaEdit } from './cadastros/debitavel/divida-edit/divida-edit';
import { InvestimentoView } from './cadastros/debitavel/investimento-view/investimento-view';
import { InvestimentoEdit } from './cadastros/debitavel/investimento-edit/investimento-edit';
import { CartaoCreditoView } from './cadastros/debitavel/cartao-credito-view/cartao-credito-view';
import { CartaoCreditoEdit } from './cadastros/debitavel/cartao-credito-edit/cartao-credito-edit';
import { FaturaView } from './cadastros/debitavel/fatura-view/fatura-view';
import { CotacaoView } from './cadastros/cotacao/cotacao-view/cotacao-view';
import { CotacaoEdit } from './cadastros/cotacao/cotacao-edit/cotacao-edit';
import { Pagamentos } from './movimentacao/pagamentos/pagamentos';
import { Dashboard } from './dashboard/dashboard/dashboard';
import { ExtratoMensal } from './graficos/extrato-mensal/extrato-mensal';
import { GraficoTipoDespesa } from './graficos/grafico-tipo-despesa/grafico-tipo-despesa';
import { GraficoTipoReceita } from './graficos/grafico-tipo-receita/grafico-tipo-receita';
import { Projecao } from './movimentacao/projecao/projecao';

export const routes: Routes = [
  { path: 'tipo-despesas', component: TipoDespesasView },
  { path: 'tipo-receitas', component: TipoReceitasView },
  { path: 'tipo-despesa', component: TipoDespesaEdit },
  { path: 'tipo-despesa/:id', component: TipoDespesaEdit },
  { path: 'tipo-receita', component: TipoReceitaEdit },
  { path: 'tipo-receita/:id', component: TipoReceitaEdit },
  { path: 'contas', component: ContaView },
  { path: 'conta', component: ContaEdit },
  { path: 'conta/:id', component: ContaEdit },
  { path: 'metas', component: MetaView },
  { path: 'meta', component: MetaEdit },
  { path: 'meta/:id', component: MetaEdit },
  { path: 'orcamentos', component: OrcamentoView },
  { path: 'orcamento', component: OrcamentoEdit },
  { path: 'orcamento/:id', component: OrcamentoEdit },
  { path: 'transferencias', component: TransferenciaView },
  { path: 'transferencia', component: TransferenciaEdit },
  { path: 'transferencia/:id', component: TransferenciaEdit },
  { path: 'dividas', component: DividaView },
  { path: 'divida', component: DividaEdit },
  { path: 'divida/:id', component: DividaEdit },
  { path: 'investimentos', component: InvestimentoView },
  { path: 'investimento', component: InvestimentoEdit },
  { path: 'investimento/:id', component: InvestimentoEdit },
  { path: 'cartoes', component: CartaoCreditoView },
  { path: 'cartao', component: CartaoCreditoEdit },
  { path: 'cartao/:id', component: CartaoCreditoEdit },
  { path: 'cartao/:id/fatura', component: FaturaView },
  { path: 'cotacoes', component: CotacaoView },
  { path: 'cotacao', component: CotacaoEdit },
  { path: 'cotacao/:id', component: CotacaoEdit },
  { path: 'servicos-transferencia', component: ServicoTransferenciaView },
  { path: 'servico-transferencia', component: ServicoTransferenciaEdit },
  { path: 'servico-transferencia/:id', component: ServicoTransferenciaEdit },

  //MOVIMENTACAO
  { path: 'pagamentos', component: Pagamentos },
  { path: 'compararServicosTransferencia', component: CompararServicosTransferencia },
  { path: 'projecao', component: Projecao },

  //GRAFICO
  { path: 'extrato', component: ExtratoMensal },
  { path: 'graficotipodespesa', component: GraficoTipoDespesa },
  { path: 'graficotiporeceita', component: GraficoTipoReceita },

  //DASHBOARD
  { path: '', component: Dashboard },
  { path: '**', redirectTo: '' }
];
