app.controller('extratoController', function($scope, extratoService, contaService) {

	$scope.dataInicial = null;
	$scope.dataFinal = null;
	$scope.debitavel = null;

	contaService.listar(function(data) {
		$scope.debitaveis = data;
	});

	$scope.gerar = function() {

		extratoService.gerarExtrato($scope.dataInicial, $scope.dataFinal, $scope.debitavel, function(data) {

			nv.addGraph(function() {

				var chart = nv.models.multiBarChart().reduceXTicks(true).rotateLabels(0).showControls(true).groupSpacing(0.1);

				var dados = [];

				for (var i = 0; i < data.length; i++) {

					let elemento = data[i];

					for (key in elemento) {
						
						if (key != 'ano' && key != 'mes' ) {
						
							if (!dados.filter(x => x.key == key)[0]) {
								dados.push({key: key, values: []});
							}
							
							let tipo = dados.filter(x => x.key == key)[0];
							
							tipo.values.push({
								"x": elemento.mes + '/' + elemento.ano,
								"y": elemento[key]
							});
						}
					}
				}

				d3.select('#grafico svg').datum(dados).call(chart);

				nv.utils.windowResize(chart.update);

				return chart;
			});

		});

	};

});