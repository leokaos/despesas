app.controller('sumarioController', function($scope, $http, $location, $routeParams, growl, receitaService, despesaService) {
	
	$scope.dataInicial = new Date(2020, 0, 1, 0, 0, 0);
	$scope.dataFinal = new Date(2020, 11, 31, 20, 59, 59);
	$scope.moeda = null;

	$scope.gerar = function() {

		var filtro = {
			'dataInicial' : $scope.dataInicial,
			'dataFinal' : $scope.dataFinal,
			'moeda' : $scope.moeda
		}
		

		receitaService.listar(filtro, function(receitas) {
			
			$scope.receitas = receitas;

			despesaService.listar(filtro, function(despesas) {

				$scope.despesas = despesas;

				$scope.createPeriodo();

				$scope.createTipos();

			});
		});

	};

	$scope.getSumario = function(mes) {
		
		var total = 0.0;

		for (var x = 0; x < $scope.despesas.length; x++) {

			var vencimento = new Date($scope.despesas[x].vencimento);

			if (mes.mes == (vencimento.getMonth() + 1) && mes.ano == vencimento.getFullYear()) {
				total += $scope.despesas[x].valor;
			}
		}
		
		return total;
	};
	
	$scope.getReceitas = function(mes) {
		
		var total = 0.0;

		for (var x = 0; x < $scope.receitas.length; x++) {

			var vencimento = new Date($scope.receitas[x].vencimento);

			if (mes.mes == (vencimento.getMonth() + 1) && mes.ano == vencimento.getFullYear()) {
				total += $scope.receitas[x].valor;
			}
		}
		
		return total;
	};

	$scope.getTotal = function(tipo, mes) {
		

		var total = 0.0;

		for (var x = 0; x < $scope.despesas.length; x++) {

			var vencimento = new Date($scope.despesas[x].vencimento);

			if ($scope.despesas[x].tipo.descricao == tipo && mes.mes == (vencimento.getMonth() + 1) && mes.ano == vencimento.getFullYear()) {
				total += $scope.despesas[x].valor;
			}
		}

		return total;
	};

	$scope.createTipos = function() {

		$scope.tipos = [];

		for (i = 0; i < $scope.despesas.length; i++) {
			if ($scope.tipos.indexOf($scope.despesas[i].tipo.descricao) == -1) {
				$scope.tipos.push($scope.despesas[i].tipo.descricao);
			}
		}

		$scope.tipos.sort();
	};

	$scope.createPeriodo = function() {

		$scope.meses = [];

		var atual = new Date($scope.dataInicial.getTime());

		while (true) {

			$scope.meses.push({
				mes : atual.getMonth() + 1,
				ano : atual.getFullYear()
			});

			atual = new Date(atual.setMonth(atual.getMonth() + 1));

			if (atual > $scope.dataFinal) {
				break;
			}
		}
	};

});
