app.controller('dashboardController', function($scope, $http, dashboardService, debitavelService, metaService, orcamentoService, $location, $routeParams, movimentacaoService, MESES, MOEDAS) {

	$scope.dataAtual = new Date();
	$scope.MESES = MESES;
	$scope.MOEDAS = MOEDAS;

	$scope.ano = $scope.dataAtual.getFullYear();
	$scope.mes = $scope.dataAtual.getMonth();

	$scope.dataInicio = new Date(Date.UTC($scope.ano, $scope.mes, 1));
	$scope.dataFim = new Date(Date.UTC($scope.ano, $scope.mes + 1, 0, 23, 59, 59));

	$scope.loadChart = function() {

		$scope.dataInicio = new Date(Date.UTC($scope.ano, $scope.mes, 1));
		$scope.dataFim = new Date(Date.UTC($scope.ano, $scope.mes + 1, 0, 23, 59, 59));

		dashboardService.buscarDespesasPorPeriodo($scope.dataInicio, $scope.dataFim, function(data) {

			$scope.graficos = [];

			for (var x = 0; x < data.length; x++) {
				$scope.graficos.push(GraficoVOFactory.create(data[x]));
			}

			for (var y = 0; y < $scope.graficos.length; y++) {
				$scope.buildCharts($scope.graficos[y]);
			}

		});

		dashboardService.buscarSaldoPorPeriodo($scope.dataInicio, $scope.dataFim, function(data) {
			$scope.saldo = data;
		});

		orcamentoService.buscarPorMes(new Periodo($scope.mes + 1, $scope.ano), function(data) {
			$scope.orcamentos = data;
		});

		var metaFiltro = {
			ano : $scope.ano,
			mes : $scope.mes + 1
		};

		metaService.listar(metaFiltro, function(data) {
			$scope.metaDoMes = data[0];
		});
	};

	$scope.buildCharts = function(graficoVO) {

		nv.addGraph(function() {

			var chart = graficoVO.getChart();

			d3.select("#" + graficoVO.id).datum(graficoVO.getDados()).transition().duration(1200).call(chart);

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

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis.filter(x => x.ativo);
	});

	movimentacaoService.buscarMovimentacaoPorPeriodo($scope.dataInicio, $scope.dataFim, function(data) {
		$scope.movimentacoes = data;
	});

});