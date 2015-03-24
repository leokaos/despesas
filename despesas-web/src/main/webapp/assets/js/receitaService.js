app.service('receitaService', function ($http) {

    var receita = null;
    var pathBase = '/despesas/services/receita/';

    this.getNovoReceita = function () {
        return {
            descricao: '',
            vencimento: null,
            valor: null,
            tiporeceita: null,
            debitavel: null,
            depositado: false
        };
    };

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (receita, fn) {
        $http.post(pathBase, receita).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (receita, fn) {
        $http.put(pathBase, receita).success(function (data) {
            fn(data);
        });
    };

    this.setReceita = function (novoReceita) {
        this.receita = novoReceita;
    };

    this.getReceita = function () {
        return this.receita;
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

    this.buscarReceitasPorTipo = function (dataInicio, dataFim, fn) {

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

    this.buscarReceitasPorPeriodo = function (dataInicio, dataFim, fn) {

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

    this.pagarReceita = function (receita, fn) {
        $http.post(pathBase + 'pagar', receita.id).success(function (data) {
            fn(data);
        });
    };

    this.buscarPorFiltro = function (filtro, fn) {
        $http.post(pathBase + 'filtro', filtro).success(function (data) {
            fn(data);
        });
    };
});