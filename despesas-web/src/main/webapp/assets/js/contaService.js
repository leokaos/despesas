app.service('contaService', function ($http) {

    var conta = null;

    this.getNovoConta = function () {
        return {
            id: null,
            nome: '',
            cor: '',
            saldo: null
        };
    };

    this.listar = function (fn) {
        $http.get('/despesas/services/conta').success(function (data) {
            fn(data);
        });
    };

    this.novo = function (conta, fn) {
        $http.post('/despesas/services/conta', conta).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (conta, fn) {
        $http.put('/despesas/services/conta', conta).success(function (data) {
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
        $http.get('/despesas/services/conta/' + id).success(function (data) {
            fn(data);
        });
    };

    this.deletar = function (id, fn) {
        $http.delete('/despesas/services/conta/' + id).success(function (data) {
            fn(data);
        });
    };
});