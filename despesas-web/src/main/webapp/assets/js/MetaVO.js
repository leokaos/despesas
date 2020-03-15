// METAVO
function MetaVO(obj) {
	angular.extend(this,obj);

	if (this.periodo.dataInicial != null) {
		var data = new Date(this.periodo.dataInicial);
		this.periodo = new Periodo(data.getMonth() + 1,data.getFullYear());
	} else {
		this.periodo = new Periodo(null,null);
	}
};

OrcamentoVO.prototype.toString = function() {
	var tipoDespesa = this.tipoDespesa != null ? this.tipoDespesa.descricao : '';
	return 'Orçamento de ' + this.periodo.toString() + ' para ' + tipoDespesa;
};
