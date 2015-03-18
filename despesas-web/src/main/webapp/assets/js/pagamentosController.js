app.controller('pagamentosController', function ($scope, $http, $location, $routeParams, growl, despesaService) {

    $scope.events = function (start, end, timezone, callback) {

        despesaService.buscarDespesasPorPeriodo(start._d, end._d, function (data) {

            var eventos = [];

            for (var i = 0; i < data.length; i++) {
                var despesa = data[i];

                eventos.push({
                    title: despesa.descricao,
                    color: despesa.tipoDespesa.cor,
                    start: despesa.vencimento,
                    despesa: despesa
                });
            }

            callback(eventos);
        });
    };

    $scope.limparCarrregar = function () {
        $('#calendar-despesas').fullCalendar('refetchEvents');
        $scope.despesaSelecionada = {};
    };

    $scope.selecionarDespesa = function (despesa) {
        $scope.despesaSelecionada = despesa;
        $scope.$apply();
    };

    $scope.deletar = function () {
        if (angular.isDefined($scope.despesaSelecionada)) {
            despesaService.deletar($scope.despesaSelecionada.id, function (data) {
                $scope.limparCarrregar();
                growl.info('Despesa deletada com sucesso!');
            });
        }
    };

    $scope.pagar = function () {
        if (angular.isDefined($scope.despesaSelecionada)) {
            despesaService.pagarDespesa($scope.despesaSelecionada, function () {
                $scope.limparCarrregar();
                growl.info('Despesa paga com sucesso!');
            });
        }
    };

});