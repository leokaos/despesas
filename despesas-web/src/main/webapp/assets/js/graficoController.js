app.controller('graficoController', function($scope, graficoService) {

	$scope.listar = function() {

		graficoService.buscarGraficoDespesas($scope.dataInicial, $scope.dataFinal, function(data) {

			nv.addGraph(function() {

				var chart = nv.models.lineChart().showLegend(true).showYAxis(true).showXAxis(true);

				chart.xAxis.axisLabel('Mês').tickValues(1, 1430449200000, 1433127600000, 1533127600000).tickFormat(function(d) {
					return d3.time.format('%m/%Y')(new Date(d))
				});

				chart.yAxis // Chart y-axis settings
				.axisLabel('Gasto em R$').tickFormat(d3.format('.02f'));

				/* Done setting the chart up? Time to render it! */
				var myData = $scope.getData(data); // You need data...

				d3.select('#grafico svg') // Select the <svg> element you want
				// to
				// render the chart in.
				.datum(myData) // Populate the <svg> element with chart data...
				.call(chart); // Finally, render the chart!

				// Update the chart when window resizes.
				nv.utils.windowResize(function() {
					chart.update();
				});

				return chart;
			});

		});
	};

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

});