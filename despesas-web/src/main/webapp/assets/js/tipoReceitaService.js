app.service('tipoReceitaService', function ($http) {

    var pathBase = '/despesas/services/tiporeceita/';

    this.getNovoTipoReceita = function () {
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

    this.novo = function (tiporeceita, fn) {
        $http.post(pathBase, tiporeceita).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (tiporeceita, fn) {
        $http.put(pathBase, tiporeceita).success(function (data) {
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