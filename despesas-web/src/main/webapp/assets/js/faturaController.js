app.controller('faturaController', function ($scope, faturaService, cartaoService, despesaService, $location, $routeParams, usSpinnerService) {

    $scope.cartaoCreditoId = $routeParams.id;

    $scope.faturas = [];

    cartaoService.buscarPorId($scope.cartaoCreditoId, function (data) {
        $scope.cartao = data;
    });

    faturaService.buscarFaturaPorCartaoCredito($scope.cartaoCreditoId, function (data) {

        for (var i = 0; i < data.length; i++) {
            $scope.faturas.push(new Fatura(data[i]));
        }
    });

    $scope.mostrarItens = function (fatura) {
        $scope.despesas = fatura.despesas;

        $scope.valorTotal = 0.0;

        for (var i = 0; i < $scope.despesas.length; i++) {
            $scope.valorTotal += $scope.despesas[i].valor;
        }
    };

    $scope.cancelar = function () {
        $location.path('/cartoes');
    };

    $scope.pagarFatura = function (fatura) {

        $scope.despesa = despesaService.getNovoDespesa();

        $scope.despesa.descricao = 'Pagamento fatura ' + fatura.cartao.descricao + ' de ' + fatura.periodo.toString();
        $scope.despesa.vencimento = fatura.dataVencimento;
        $scope.despesa.valor = fatura.valorFatura;

        despesaService.setDespesa($scope.despesa);

        $location.path('/despesa');
    };

});

function Fatura(dados) {
    angular.extend(this, dados);

    if (this.dataVencimento != null) {
        var data = new Date(this.dataVencimento);
        this.periodo = new Periodo(data.getMonth() + 1, data.getFullYear());
    } else {
        this.periodo = new Periodo(null, null);
    }
}