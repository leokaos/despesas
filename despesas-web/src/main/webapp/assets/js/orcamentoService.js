app.service('orcamentoService', function ($http) {

    var orcamento = null;
    var pathBase = '/despesas/services/orcamento/';

    this.getNovoOrcamento = function () {
        return {
            tipoDespesa: null,
            periodo: new Periodo(null, null),
            valor: null,
        };
    };

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (orcamento, fn) {
        $http.post(pathBase, orcamento).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (orcamento, fn) {
        $http.put(pathBase, orcamento).success(function (data) {
            fn(data);
        });
    };

    this.setOrcamento = function (novoOrcamento) {
        this.orcamento = novoOrcamento;
    };

    this.getOrcamento = function () {
        return this.orcamento;
    };

    this.buscarPorId = function (id, fn) {
        $http.get(pathBase + id).success(function (data) {
            fn(data);
        });
    };

    this.deletar = function (id, fn) {
        $http.delete(pathBase + id).success(function (data) {
            fn(data);
        });
    };

    this.filtrarPorData = function (data, tipodespesa, fn) {

        var request = $http({
            method: 'get',
            url: pathBase + 'data/',
            params: {
                vencimento: data.toGMTString(),
                tipoDespesa: tipodespesa
            }
        });

        request.success(function (data) {
            fn(new OrcamentoVO(data));
        });
    };

});

// PERIODO
function Periodo(mes, ano) {
    this.mes = mes;
    this.ano = ano;
};

Periodo.prototype.getDataInicial = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes - 1);
    dataInicial.setDate(1);

    return dataInicial;
};

Periodo.prototype.getDataFinal = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes);
    dataInicial.setDate(0);

    return dataInicial;
};

Periodo.prototype.toString = function () {
    var dataInicial = this.getDataInicial();

    if (dataInicial != null) {

        return dataInicial.toLocaleDateString('pt-BR', {
            month: 'long',
            year: 'numeric'
        });

    } else {
        return '';
    }
};

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

OrcamentoVO.prototype.getValueOrcamento = function () {
    return this.valorConsolidado / this.valor * 100;
};

OrcamentoVO.prototype.getClassProgressBar = function () {
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

OrcamentoVO.prototype.toOrcamento = function () {
    return {
        id: this.id,
        tipoDespesa: this.tipoDespesa,
        dataInicial: this.periodo.getDataInicial(),
        dataFinal: this.periodo.getDataFinal(),
        valor: this.valor
    };
};

OrcamentoVO.prototype.toString = function () {
    var tipoDespesa = this.tipoDespesa != null ? this.tipoDespesa.descricao : '';
    return 'Orçamento de ' + this.periodo.toString() + ' para ' + tipoDespesa;
}