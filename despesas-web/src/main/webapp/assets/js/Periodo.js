// PERIODO
function Periodo(mes, ano) {
	this.mes = mes;
	this.ano = ano;
};

Periodo.prototype.getDataInicial = function() {

	if (this.mes == null || this.ano == null) {
		return null;
	}

	return new Date(this.ano, this.mes, 1, 0, 0, 0, 0);
};

Periodo.prototype.getDataFinal = function() {

	if (this.mes == null || this.ano == null) {
		return null;
	}

	return new Date(this.ano, this.mes + 1, 0, 23, 59, 59, 999);
};

Periodo.prototype.toString = function() {
	var data = null;

	if (this.getDataInicial() != null) {
		data = this.getDataInicial();
	}

	if (data != null) {
		return data.toLocaleDateString('pt-BR', {
			month : 'long',
			year : 'numeric'
		});

	} else {
		return '';
	}
};
