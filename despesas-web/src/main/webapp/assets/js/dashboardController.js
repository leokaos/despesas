app.controller('dashboardController', function ($scope, $http, contaService, despesaService, $location, $routeParams, MESES) {

    $scope.dataAtual = new Date();
    $scope.MESES = MESES;

    $scope.configData = function () {
        $scope.ano = $scope.dataAtual.getFullYear();
        $scope.mes = $scope.dataAtual.getMonth();
    }

    $scope.loadChart = function () {

        var dataInicio = new Date($scope.ano, $scope.mes, 1);
        var dataFim = new Date($scope.ano, $scope.mes + 1, 0);

        despesaService.buscarDespesasPorTipo(dataInicio, dataFim, function (data) {

            var dataConvertido = [];

            for (var i = 0; i < data.length; i++) {

                var obj = data[i];

                dataConvertido.push({
                    label: obj.descricaoTipoDespesa,
                    value: obj.valor
                });
            }

            $('#despesasPorTipo').empty();

            Morris.Donut({
                element: 'despesasPorTipo',
                data: dataConvertido
            });
        });
    }

    $scope.anterior = function () {
        if ($scope.mes == 0) {
            $scope.mes = 11;
            $scope.ano--;
        } else {
            $scope.mes--;
        }

        $scope.loadChart();
    }

    $scope.posterior = function () {
        if ($scope.mes == 11) {
            $scope.mes = 0;
            $scope.ano++;
        } else {
            $scope.mes++;
        }

        $scope.loadChart();
    }

    $scope.configData();

});