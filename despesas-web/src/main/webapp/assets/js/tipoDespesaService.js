app.service('tipoDespesaService', function ($http) {

    var tipodespesa = null;

    this.getNovoTipoDespesa = function () {
        return {
            id: null,
            descricao: '',
            cor: ''
        };
    };

    this.listar = function (fn) {
        $http.get('/despesas/services/tipodespesa').success(function (data) {
            fn(data);
        });
    };

    this.novo = function (tipodespesa, fn) {
        $http.post('/despesas/services/tipodespesa', tipodespesa).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (tipodespesa, fn) {
        $http.put('/despesas/services/tipodespesa', tipodespesa).success(function (data) {
            fn(data);
        });
    };

    this.setTipoDespesa = function (novoTipoDespesa) {
        this.tipodespesa = novoTipoDespesa;
    }

    this.getTipoDespesa = function () {
        return this.tipodespesa;
    }

    this.buscarPorId = function (id, fn) {
        $http.get('/despesas/services/tipodespesa/' + id).success(function (data) {
            fn(data);
        });
    };

    this.deletar = function (id, fn) {
        $http.delete('/despesas/services/tipodespesa/' + id).success(function (data) {
            fn(data);
        });
    };
});