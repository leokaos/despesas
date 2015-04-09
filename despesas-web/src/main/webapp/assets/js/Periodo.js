// PERIODO
function Periodo(mes, ano) {
  this.mes = mes;
  this.ano = ano;
};

Periodo.prototype.getDataInicial = function() {

  if (this.mes == null || this.ano == null) {
    return null;
  }

  var dataInicial = new Date();

  dataInicial.setFullYear(this.ano);
  dataInicial.setMonth(this.mes - 1);
  dataInicial.setDate(1);
  dataInicial.setHours(0);
  dataInicial.setMinutes(0);
  dataInicial.setSeconds(0);
  dataInicial.setMilliseconds(0);

  return dataInicial;
};

Periodo.prototype.getDataFinal = function() {

  if (this.mes == null || this.ano == null) {
    return null;
  }

  var dataFinal = new Date();

  dataFinal.setFullYear(this.ano);
  dataFinal.setMonth(this.mes);
  dataFinal.setDate(0);
  dataFinal.setHours(23);
  dataFinal.setMinutes(59);
  dataFinal.setSeconds(59);
  dataFinal.setMilliseconds(999);

  return dataFinal;
};

Periodo.prototype.toString = function() {
  var data = null;

  if (this.getDataInicial() != null) {
    data = this.getDataInicial();
  }

  if (data != null) {
    return data.toLocaleDateString('pt-BR', {
      month: 'long',
      year: 'numeric'
    });

  } else {
    return '';
  }
};
