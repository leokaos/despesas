app.service('cartaoService', function ($http) {

    var cartao = null;
    var pathBase = '/despesas/services/cartao/';

    this.getNovoCartao = function () {
        return {
            descricao: '',
            limite: 0.0,
            diaDeVencimento: null,
            diaDeFechamento: null,
            bandeiraCartaoCredito: ''
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

    this.setCartao = function (novaCartao) {
        this.cartao = novaCartao;
    }

    this.getCartao = function () {
        return this.cartao;
    }

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