app.service('despesaService', function ($http) {

    var despesa = null;
    var pathBase = '/despesas/services/despesa/';

    this.getNovoDespesa = function () {
        return {
            descricao: '',
            vencimento: null,
            valor: null,
            tipoDespesa: null,
            debitavel: null,
            paga: false,
            parcelamento: null,
            numeroParcelas: null
        };
    };

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (despesa,parcelamento, fn) {
    	
    	var dados = {
    			"despesa" : despesa,
    			"parcelamentoVO" : parcelamento
    	};
    	
    	var request = $http({
            method: 'post',
            url: pathBase,
            data: dados
        });

        request.success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (despesa,parcelamento, fn) {
        $http.put(pathBase, despesa).success(function (data) {
            fn(data);
        });
    };

    this.setDespesa = function (novoDespesa) {
        this.despesa = novoDespesa;
    };

    this.getDespesa = function () {
        return this.despesa;
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

    this.buscarDespesasPorTipo = function (dataInicio, dataFim, fn) {

        var request = $http({
            method: 'get',
            url: pathBase + 'grafico',
            params: {
                dataInicial: dataInicio.toGMTString(),
                dataFinal: dataFim.toGMTString()
            }
        });

        request.success(function (data) {
            fn(data);
        });

    };

    this.buscarDespesasPorPeriodo = function (dataInicio, dataFim, fn) {

        var request = $http({
            method: 'get',
            url: pathBase + 'periodo',
            params: {
                dataInicial: dataInicio.toGMTString(),
                dataFinal: dataFim.toGMTString()
            }
        });

        request.success(function (data) {
            fn(data);
        });

    };

    this.pagarDespesa = function (despesa, fn) {
        $http.post(pathBase + 'pagar', despesa.id).success(function (data) {
            fn(data);
        });
    };

    this.buscarPorFiltro = function (filtro, fn) {
        $http.post(pathBase + 'filtro', filtro).success(function (data) {
            fn(data);
        });
    };
});