app.controller('painelReceitaController', function($scope, receitaService, tipoReceitaService, orcamentoService, debitavelService, $location,
		$routeParams, growl, $http) {

	$scope.receitas = [];
	$scope.tiposReceita = [];
	$scope.debitaveis = [];
	$scope.receitaUpload = null;
	$scope.receitasDespositadas = true;
	$scope.total = 0.0;

	$scope.add = function() {
		$scope.receitas.push(receitaService.getNovoReceita());
	};

	$scope.remove = function(index) {
		$scope.receitas.splice(index, 1);
	};

	tipoReceitaService.listar(function(tiposReceita) {
		$scope.tiposReceita = tiposReceita;
	});

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
	});

	$scope.uploadFile = function() {

		var fd = new FormData();

		var file = document.getElementById("arquivo");

		fd.append('arquivo', file.files[0]);

		$http.post('services/receita/upload', fd, {
			transformRequest : angular.identity,
			headers : {
				'Content-Type' : undefined
			}
		}).success(function(data) {
			$scope.receitas = data;

			for (var x = 0; x < $scope.receitas.length; x++) {
				$scope.receitas[x].debitavel = $scope.receitaUpload;
				$scope.receitas[x].depositado = $scope.receitasDespositadas;
			}

			$('#modalUpload').modal('hide');

		}).error(function() {
		});
	};

	$scope.salvar = function() {

		var parte = parseInt(100 / $scope.receitas.length);

		var fn = function() {

			var auxTotal = $scope.total + parte;

			if (auxTotal > 100) {

				$scope.total = 100;

				$('#modalSalvar').modal('hide');
				$scope.receitas = [];

				growl.info('Receitas salvas com sucesso!');

			} else {
				$scope.total += parte;
			}
		}

		for (var x = 0; x < $scope.receitas.length; x++) {
			receitaService.salvar($scope.receitas[x], fn);
		}

	};

});
