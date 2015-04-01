app.controller('dashboardController', function ($scope, $http, dashboardService, $location, $routeParams, MESES) {

    $scope.dataAtual = new Date();
    $scope.MESES = MESES;

    $scope.ano = $scope.dataAtual.getFullYear();
    $scope.mes = $scope.dataAtual.getMonth();

    $scope.loadChart = function () {

        var dataInicio = new Date($scope.ano, $scope.mes, 1);
        var dataFim = new Date($scope.ano, $scope.mes + 1, 0);

        dashboardService.buscarDespesasPorPeriodo(dataInicio, dataFim, function (data) {

            $scope.graficos = [];

            for (x = 0; x < data.length; x++) {
                $scope.graficos.push(new GraficoVO(data[x]));
            }

            for (y = 0; y < $scope.graficos.length; y++) {
                $scope.buildCharts($scope.graficos[y]);
            }

        });
    }

    $scope.buildCharts = function (graficoVO) {

        /*var tp = function (key, y, e, graph) {
            console.log(key, e, y);
            return '<h3>' + key + '</h3>' +
                '<p>!!' + y + '!!</p>' +
                '<p>Likes: ' + e.point.likes + '</p>';
        };
        chart.tooltipContent(tp);*/

        nv.addGraph(function () {
            var chart = nv.models.pieChart()
                .x(function (d) {
                    return d.legenda;
                })
                .y(function (d) {
                    return d.valor;
                })
                .color(graficoVO.getColors())
                .noData("Sem Dados")
                .labelType("percent")
                .showLegend(false)
                .donut(true);

            d3.select("#" + graficoVO.id).datum(graficoVO.dados).transition().duration(1200).call(chart);

            return chart;
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

    $scope.loadChart();

});