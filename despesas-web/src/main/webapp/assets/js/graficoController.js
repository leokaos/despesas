app.controller('graficoController', function($scope, graficoService) {

	$scope.listarDespesas = function() {

		graficoService.buscarGraficoDespesas($scope.dataInicial, $scope.dataFinal, function(data) {
			$scope.gerarGrafico(data);
		});
	};
	
	$scope.listarReceitas = function() {

		graficoService.buscarGraficoReceitas($scope.dataInicial, $scope.dataFinal, function(data) {
			$scope.gerarGrafico(data);
		});
	};	
	
	$scope.gerarGrafico = function(data){
		
		nv.addGraph(function() {

			var datum = $scope.getData(data);

			var chart = nv.models.lineChart().useInteractiveGuideline(true).showLegend(true).showYAxis(true).showXAxis(true).margin({
				top : 30,
				right : 20,
				bottom : 50,
				left : 50
			});

			chart.xAxis.axisLabel('Mês').tickValues($scope.getValoresX(datum)).tickFormat(function(d) {
				return d3.time.format('%m/%Y')(new Date(d))
			});

			chart.yAxis.axisLabel('Gasto em R$').tickFormat(d3.format('.02f'));

			d3.select('#grafico svg').datum(datum).call(chart);

			nv.utils.windowResize(function() {
				chart.update();
			});

			return chart;
		});
	}

	$scope.getData = function(data) {

		var dados = [];

		for (var x = 0; x < data.series.length; x++) {

			var serie = data.series[x];

			dados.push({
				key : serie.nome,
				color : serie.cor,
				values : serie.pontos
			});
		}

		return dados;
	};

	$scope.getValoresX = function(data) {

		var valores = [];

		for (var x = 0; x < data.length; x++) {

			var serie = data[x];

			for (var y = 0; y < serie.values.length; y++) {

				if (valores.indexOf(serie.values[y].x) == -1) {
					valores.push(serie.values[y].x);
				}
			}
		}

		return valores;
	};
	
	$scope.getMaxValueY = function(data){
		
		var max = 0;
		
		for (var x = 0; x < data.length; x++) {
			
			var serie = data[x];

			for (var y = 0; y < serie.values.length; y++) {
				if ( max < serie.values[y].y){
					max = serie.values[y].y;
				}
			}
		}
		
		return max;
	}

});