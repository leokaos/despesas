app.service('cartaoService', function ($http) {

    var pathBase = '/despesas/services/cartao/';

    this.getNovoCartao = function () {
        return {
            descricao: '',
            cor: null,
            limite: 0.0,
            diaDeVencimento: null,
            diaDeFechamento: null,
            bandeiraCartaoCredito: '',
            tipo: 'CARTAO'
        };
    };

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (cartao, fn) {
        $http.post(pathBase, cartao).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (cartao, fn) {
        $http.put(pathBase, cartao).success(function (data) {
            fn(data);
        });
    };

    this.buscarPorId = function (id, fn) {
        var url = pathBase + id;

        $http.get(url).success(function (data) {
            fn(data);
        });
    };

    this.deletar = function (id, fn) {
        var url = pathBase + id;

        $http.delete(url).success(function (data) {
            fn(data);
        });
    };

});