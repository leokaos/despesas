// ORCAMENTOVO
function OrcamentoVO(obj) {
  angular.extend(this, obj);

  if (this.dataInicial != null) {
    var data = new Date(this.dataInicial);
    this.periodo = new Periodo(data.getMonth() + 1, data.getFullYear());
  } else {
    this.periodo = new Periodo(null, null);
  }

  if (this.valorConsolidado == null) {
    this.valorConsolidado = 0;
  }
};

OrcamentoVO.prototype.getValueOrcamento = function() {
  return this.valorConsolidado / this.valor * 100;
};

OrcamentoVO.prototype.getClassProgressBar = function() {
  var classe = '';
  var percent = this.getValueOrcamento();

  if (percent <= 70.0) {
    classe = 'success';
  } else if (percent > 70.0 && percent <= 80.0) {
    classe = 'warning'
  } else {
    classe = 'danger';
  }

  return classe;
};

OrcamentoVO.prototype.toOrcamento = function() {
  return {
    id: this.id,
    tipoDespesa: this.tipoDespesa,
    dataInicial: this.periodo.getDataInicial(),
    dataFinal: this.periodo.getDataFinal(),
    valor: this.valor
  };
};

OrcamentoVO.prototype.toString = function() {
  var tipoDespesa = this.tipoDespesa != null ? this.tipoDespesa.descricao : '';
  return 'Orçamento de ' + this.periodo.toString() + ' para ' + tipoDespesa;
}
