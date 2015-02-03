app.service('despesaService', function ($http) {

    var despesa = null;

    this.getNovoDespesa = function () {
        return {};
    };

    this.listar = function (fn) {
        $http.get('/despesas/services/despesa').success(function (data) {
            fn(data);
        });
    };

    this.novo = function (despesa, fn) {
        $http.post('/despesas/services/despesa', despesa).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (despesa, fn) {
        $http.put('/despesas/services/despesa', despesa).success(function (data) {
            fn(data);
        });
    };

    this.setDespesa = function (novoDespesa) {
        this.despesa = novoDespesa;
    };

    this.getDespesa = function () {
        return this.conta;
    };

    this.buscarPorId = function (id, fn) {
        $http.get('/despesas/services/despesa/' + id).success(function (data) {
            fn(data);
        });
    };

    this.deletar = function (id, fn) {
        $http.delete('/despesas/services/despesa/' + id).success(function (data) {
            fn(data);
        });
    };

    this.buscarDespesasPorTipo = function (dataInicio, dataFim, fn) {

        var request = $http({
            method: 'get',
            url: '/despesas/services/despesa/grafico',
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
            url: '/despesas/services/despesa/periodo',
            params: {
                dataInicial: dataInicio.toGMTString(),
                dataFinal: dataFim.toGMTString()
            }
        });

        request.success(function (data) {
            fn(data);
        });

    };
});