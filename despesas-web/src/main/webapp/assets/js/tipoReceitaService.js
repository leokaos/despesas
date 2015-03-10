app.service('tipoReceitaService', function ($http) {

    var tiporeceita = null;
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

    this.setTipoReceita = function (novoTipoReceita) {
        this.tiporeceita = novoTipoReceita;
    }

    this.getTipoReceita = function () {
        return this.tiporeceita;
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