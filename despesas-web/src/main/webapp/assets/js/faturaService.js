app.service('faturaService', function ($http) {

    var pathBase = 'http://localhost:8080/despesas/services/fatura/';

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

    this.novo = function (receita, fn) {
        $http.post(pathBase, receita).success(function (data) {
            fn(data);
        });
    };

    this.salvar = function (receita, fn) {
        $http.put(pathBase, receita).success(function (data) {
            fn(data);
        });
    };

    this.setReceita = function (novoReceita) {
        this.receita = novoReceita;
    };

    this.getReceita = function () {
        return this.receita;
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

    this.buscarFaturaPorCartaoCredito = function (id, fn) {

        var request = $http({
            method: 'get',
            url: pathBase + 'cartao/' + id,
            params: {
                cartaoCredito: id
            }
        });

        request.success(function (data) {
            fn(data);
        });

    };
    
    this.pagar = function(fatura, conta, dataPagamento, fn){
    	
        var request = $http({
            method: 'get',
            url: pathBase + 'pagar/' + fatura.id + '/' + conta.id + '?dataPagamento=' + dataPagamento.toGMTString()
        });

        request.success(function (data) {
            fn(data);
        });
    };
    
});