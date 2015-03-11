//PERIODO
function Periodo(mes, ano) {
    this.mes = --mes;
    this.ano = ano;
};

Periodo.prototype.getDataInicial = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes);
    dataInicial.setDate(1);

    return dataInicial;
};

Periodo.prototype.getDataFinal = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes + 1);
    dataInicial.setDate(0);

    return dataInicial;
};


app.controller('orcamentoController', function ($scope) {



});