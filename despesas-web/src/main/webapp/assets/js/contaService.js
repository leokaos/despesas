app.service('contaService', function ($http) {

    var conta = null;
    var pathBase = '/despesas/services/conta/';

    this.getNovoConta = function () {
        return {
            id: null,
            descricao: '',
            cor: '',
            saldo: null
        };
    };


    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (conta, fn) {
        $http.post(pathBase, conta).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (conta, fn) {
        $http.put(pathBase, conta).success(function (data) {
            fn(data);
        });
    };

    this.setConta = function (novaConta) {
        this.conta = novaConta;
    }

    this.getConta = function () {
        return this.conta;
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