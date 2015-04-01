app.controller('faturaController', function ($scope, faturaService, cartaoService, $location, $routeParams, usSpinnerService) {

    $scope.cartaoCreditoId = $routeParams.id;

    $scope.faturas = [];
    
    cartaoService.

    faturaService.buscarFaturaPorCartaoCredito($scope.cartaoCreditoId, function (data) {

        for (var i = 0; i < data.lenght; i++) {
            $scope.faturas.push(new Fatura(data[i]));
        }
    });

});

function Fatura(dados) {
    angular.extend(this, dados);

    if (this.vencimento != null) {
        var data = new Date(this.vencimento);
        this.periodo = new Periodo(data.getMonth() + 1, data.getFullYear());
    } else {
        this.periodo = new Periodo(null, null);
    }
}