app.service('tipoDespesaService', function ($http) {

    var pathBase = '/despesas/services/tipodespesa/';

    this.getNovoTipoDespesa = function () {
        return {
            id: null,
            descricao: '',
            cor: ''
        };
    };

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (tipodespesa, fn) {
        $http.post(pathBase, tipodespesa).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (tipodespesa, fn) {
        $http.put(pathBase, tipodespesa).success(function (data) {
            fn(data);
        });
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
});