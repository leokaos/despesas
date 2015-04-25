app.controller('dashboardController', function($scope, $http, dashboardService,
		$location, $routeParams, MESES) {

	$scope.dataAtual = new Date();
	$scope.MESES = MESES;

	$scope.ano = $scope.dataAtual.getFullYear();
	$scope.mes = $scope.dataAtual.getMonth();

	$scope.loadChart = function() {

		var dataInicio = new Date($scope.ano, $scope.mes, 1);
		var dataFim = new Date($scope.ano, $scope.mes + 1, 0);

		dashboardService.buscarDespesasPorPeriodo(dataInicio, dataFim,
				function(data) {

					$scope.graficos = [];

					for (var x = 0; x < data.length; x++) {
						$scope.graficos.push(new GraficoVO(data[x]));
					}

					for (var y = 0; y < $scope.graficos.length; y++) {
						$scope.buildCharts($scope.graficos[y]);
					}

				});
	};

	$scope.buildCharts = function(graficoVO) {

		nv.addGraph(function() {

			var chart = null;
			var dados = graficoVO.dados;

			if (graficoVO.isBarra()) {
				chart = nv.models.discreteBarChart();

				dados = [ {
					key : graficoVO.titulo,
					values : graficoVO.dados
				} ];
			}

			if (graficoVO.isPizza()) {
				chart = nv.models.pieChart().donut(true).labelType("percent")
						.showLegend(false);
			}

			chart.x(function(d) {
				return d.legenda;
			}).y(function(d) {
				return d.valor;
			}).color(graficoVO.getColors()).noData("Sem Dados");

			d3.select("#" + graficoVO.id).datum(dados).transition().duration(
					1200).call(chart);

			return chart;
		});
	};

	$scope.anterior = function() {
		if ($scope.mes == 0) {
			$scope.mes = 11;
			$scope.ano--;
		} else {
			$scope.mes--;
		}

		$scope.loadChart();
	};

	$scope.posterior = function() {
		if ($scope.mes == 11) {
			$scope.mes = 0;
			$scope.ano++;
		} else {
			$scope.mes++;
		}

		$scope.loadChart();
	};

	$scope.loadChart();

});