app.controller('projecaoController', function($scope, projecaoService, contaService, MOEDAS) {

	$scope.debitavel = null;
	$scope.numeroMeses = null;
	$scope.MOEDAS = MOEDAS;

	contaService.listar(function(data) {
		$scope.debitaveis = data;
	});

	$scope.gerar = function() {

		projecaoService.gerarProjecao($scope.numeroMeses, $scope.debitavel, function(data) {

			nv.addGraph(function() {

				var myData = $scope.getData(data);
				var simboloMoeda = $scope.MOEDAS[$scope.debitavel.moeda].simbolo;

				var chart = nv.models.lineChart().showLegend(true).showYAxis(true).showXAxis(true).useInteractiveGuideline(true).margin({
					top : 30,
					right : 20,
					bottom : 50,
					left : 100
				});

				var xTicks = [];

				for (var x = 0; x < myData[0].values.length; x++) {
					xTicks.push(myData[0].values[x].x)
				}

				var yTicks = [];

				for (var x = 0; x < myData[0].values.length; x++) {
					yTicks.push(myData[0].values[x].y)
				}

				chart.xAxis.axisLabel('Data').tickValues(xTicks).tickFormat(function(d) {
					return d3.time.format('%m/%Y')(new Date(d))
				});

				chart.yAxis.axisLabel('Gasto em ' + simboloMoeda).axisLabelDistance(40).tickValues(yTicks).tickFormat(function(d) {
					return simboloMoeda + ' ' + d3.format(',')(d);
				});

				d3.select('#grafico svg').datum(myData).call(chart);

				nv.utils.windowResize(function() {
					chart.update();
				});

				return chart;
			});

		});
	};

	$scope.getData = function(data) {

		var projecao = [];

		for (var x = 0; x < data.itens.length; x++) {
			projecao.push({
				x : data.itens[x].data,
				y : data.itens[x].valor
			});
		}

		return [ {
			key : 'Projecao',
			values : projecao
		} ];
	};

});