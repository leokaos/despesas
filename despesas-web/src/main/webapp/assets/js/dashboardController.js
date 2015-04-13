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

            for (var x = 0; x < data.length; x++) {
                $scope.graficos.push(new GraficoVO(data[x]));
            }

            for (var y = 0; y < $scope.graficos.length; y++) {
               // $scope.buildCharts($scope.graficos[y]);
            }

        });
    };

    $scope.buildCharts = function (graficoVO) {

        nv.addGraph(function () {

            var chart = null;

            if (graficoVO.isBarra()) {
                chart = nv.models.discreteBarChart();
            }

            if (graficoVO.isPizza()) {
                chart = nv.models.pieChart().donut(true).labelType("percent").showLegend(false);
            }

            chart.x(function (d) {
                return d.legenda;
            })
                .y(function (d) {
                    return d.valor;
                })
                .color(graficoVO.getColors())
                .noData("Sem Dados");

            d3.select("#" + graficoVO.id).datum(graficoVO.dados).transition().duration(1200).call(chart);

            return chart;
        });
    };

    $scope.anterior = function () {
        if ($scope.mes == 0) {
            $scope.mes = 11;
            $scope.ano--;
        } else {
            $scope.mes--;
        }

        $scope.loadChart();
    };

    $scope.posterior = function () {
        if ($scope.mes == 11) {
            $scope.mes = 0;
            $scope.ano++;
        } else {
            $scope.mes++;
        }

        $scope.loadChart();
    };

    $scope.loadChart();






    //TESTE

    nv.addGraph(function () {
        var chart = nv.models.discreteBarChart()
            .x(function (d) {
                return d.label
            }) //Specify the data accessors.
            .y(function (d) {
                return d.value
            })
            .staggerLabels(true) //Too many bars and not enough room? Try staggering labels.
            .tooltips(false) //Don't show tooltips
            .showValues(true); //...instead, show the bar value right on top of each bar.
            //.transitionDuration(350);

        d3.select('#extrato_mensal')
            .datum(exampleData())
            .call(chart);

        nv.utils.windowResize(chart.update);

        return chart;
    });

    //Each bar represents a single discrete quantity.
    function exampleData() {
        return [
            {
                key: "Cumulative Return",
                values: [
                    {
                        "label": "A Label",
                        "value": -29.765957771107
        },
                    {
                        "label": "B Label",
                        "value": 0
        },
                    {
                        "label": "C Label",
                        "value": 32.807804682612
        },
                    {
                        "label": "D Label",
                        "value": 196.45946739256
        },
                    {
                        "label": "E Label",
                        "value": 0.19434030906893
        },
                    {
                        "label": "F Label",
                        "value": -98.079782601442
        },
                    {
                        "label": "G Label",
                        "value": -13.925743130903
        },
                    {
                        "label": "H Label",
                        "value": -5.1387322875705
        }
      ]
    }
  ]

    }


    //TESTE

});