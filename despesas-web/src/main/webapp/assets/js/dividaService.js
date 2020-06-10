app.service('dividaService', function ($http) {

    var pathBase = '/despesas/services/divida/';

    this.getNovaDivida = function () {
        return {
            descricao: '',
            vencimento: null,
            valor: null,
            moeda: null,
            tipo: "DIVIDA"
        };
    };

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (divida, fn) {
        $http.post(pathBase, divida).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (divida, fn) {
        $http.put(pathBase, divida).success(function (data) {
            fn(data);
        });
    };

    this.getdivida = function () {
        return this.divida;
    }

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
});