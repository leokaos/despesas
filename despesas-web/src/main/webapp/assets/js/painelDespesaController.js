app.controller('painelDespesaController', function($scope, despesaService,
		tipoDespesaService, orcamentoService, debitavelService, $location,
		$routeParams, growl, $http) {

	$scope.despesas = [];
	$scope.tiposDespesa = [];
	$scope.debitaveis = [];
	$scope.debitavelUpload = null;
	$scope.despesasPagas = true;

	$scope.add = function() {
		$scope.despesas.push(despesaService.getNovoDespesa());
	};

	$scope.remove = function(index) {
		$scope.despesas.splice(index, 1);
	};

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
	});

	$scope.uploadFile = function() {

		var fd = new FormData();

		var file = document.getElementById("arquivo");

		fd.append('arquivo', file.files[0]);

		$http.post('services/despesa/upload', fd, {
			transformRequest : angular.identity,
			headers : {
				'Content-Type' : undefined
			}
		}).success(function(data) {
			$scope.despesas = data;

			for (var x = 0; x < $scope.despesas.length; x++) {
				$scope.despesas[x].debitavel = $scope.debitavelUpload;
				$scope.despesas[x].moeda = $scope.debitavelUpload.moeda;
				$scope.despesas[x].paga = $scope.despesasPagas;
				$scope.despesas[x].moeda = $scope.despesasPagas;
			}

			$('#modalUpload').modal('hide');

		}).error(function() {
		});
	};

	$scope.salvar = function() {

		if (!$scope.total) {
			$scope.total = $scope.despesas.length;
			$scope.parcial = 0;
		}

		var fn = function() {
			
			$scope.parcial++;

			if ($scope.parcial >= $scope.total) {

				$('#modalSalvar').modal('hide');
				$scope.despesas = [];

				growl.info('Despesas salvas com sucesso!');
				
			} else if ($scope.parcial < $scope.despesas.length) {
				$scope.$apply();
				despesaService.novo($scope.despesas[$scope.parcial], null, fn);
			}
		};

		despesaService.novo($scope.despesas[$scope.parcial], null, fn);

	};

});
