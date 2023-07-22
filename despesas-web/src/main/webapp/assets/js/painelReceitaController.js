app.controller('painelReceitaController', function($scope, receitaService, tipoReceitaService, debitavelService, growl, $http) {

	$scope.receitas = [];
	$scope.tiposReceita = [];
	$scope.debitaveis = [];
	$scope.receitaUpload = null;
	$scope.receitasDespositadas = true;

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
				$scope.receitas[x].moeda = $scope.receitaUpload.moeda;
				$scope.receitas[x].depositado = $scope.receitasDespositadas;
			}

			$('#modalUpload').modal('hide');

		}).error(function() {
			growl.error('Erro ao carregar do arquivo!');
		});
	};

	$scope.salvar = function() {

		$scope.total = $scope.receitas.length;
		$scope.parcial = 0;

		var fn = function() {

			$scope.parcial++;

			if ($scope.parcial >= $scope.total) {

				$('#modalSalvar').modal('hide');
				$scope.receitas = [];
				$scope.total = 0;
				$scope.parcial = 0;

				growl.info('Receitas salvas com sucesso!');

			} else if ($scope.parcial < $scope.receitas.length) {
				$scope.$apply();
				receitaService.novo($scope.receitas[$scope.parcial], fn);
			}
		};

		receitaService.novo($scope.receitas[$scope.parcial], fn);

	};

});
