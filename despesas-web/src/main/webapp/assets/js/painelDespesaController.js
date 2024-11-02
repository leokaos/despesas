app.controller('painelDespesaController', function($scope, despesaService, tipoDespesaService, debitavelService, growl, $http) {

	$scope.despesas = [];
	$scope.tiposDespesa = [];
	$scope.debitaveis = [];
	$scope.debitavelUpload = null;
	$scope.despesasPagas = true;
	$scope.pagarTodas = false;
	$scope.debitavelTodas = null;
	$scope.loading = false;
	$scope.ordenacao = {};

	$scope.add = function() {
		$scope.despesas.push(despesaService.getNovoDespesa());
	};

	$scope.remove = function(index) {
		$scope.despesas.splice(index, 1);
	};

	$scope.configurarPagar = function() {

		for (var x = 0; x < $scope.despesas.length; x++) {
			$scope.despesas[x].paga = $scope.pagarTodas;
		}
	}

	$scope.configurarDebitaveis = function() {

		for (var x = 0; x < $scope.despesas.length; x++) {
			$scope.despesas[x].debitavel = $scope.debitavelTodas;
		}
	}

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
	});

	$scope.ordenar = function(campo) {

		var sortByFunction;

		switch (campo) {
			case 'descricao':
				sortByFunction = function(a, b) { return (a.descricao || "").localeCompare(b.descricao || ""); };
				break;
			case 'valor':
				sortByFunction = function(a, b) { return (a.valor || 0) - (b.valor || 0); };
				break;
			case 'vencimento':
				sortByFunction = function(a, b) { return (a.vencimento || 0) - (b.vencimento || 0); };
				break;
			case 'tipo':
				sortByFunction = function(a, b) { return (a.tipo?.descricao || "").localeCompare(b.tipo?.descricao || ""); };
				break;
		}

		$scope.despesas = [...$scope.despesas.sort(sortByFunction)];

		if ($scope.ordenacao.ascend === false) {
			$scope.despesas = [...$scope.despesas.reverse()];
		}

		$scope.$apply();

	}

	$scope.uploadFile = function() {

		var fd = new FormData();

		var file = document.getElementById("arquivo");

		fd.append('arquivo', file.files[0]);

		$scope.loading = true;

		$http.post('services/despesa/upload', fd, {
			transformRequest: angular.identity,
			headers: {
				'Content-Type': undefined
			}
		}).success(function(data) {
			$scope.despesas = data;

			for (var x = 0; x < $scope.despesas.length; x++) {
				$scope.despesas[x].debitavel = $scope.debitavelUpload;
				$scope.despesas[x].moeda = $scope.debitavelUpload.moeda;
				$scope.despesas[x].paga = $scope.despesasPagas;
			}

			$scope.pagarTodas = $scope.despesasPagas;
			$scope.debitavelTodas = $scope.debitavelUpload;

			$('#modalUpload').modal('hide');
			$scope.loading = false;
			$scope.ordenacao = {};

		}).error(function() {
			growl.error('Erro ao carregar do arquivo!');
			$scope.loading = false;
		});
	};

	$scope.salvar = function() {

		$scope.total = $scope.despesas.length;
		$scope.parcial = 0;
		$scope.loading = true;

		var fn = function() {

			$scope.parcial++;

			if ($scope.parcial >= $scope.total) {

				$('#modalSalvar').modal('hide');
				$scope.despesas = [];
				$scope.total = 0;
				$scope.parcial = 0;
				$scope.loading = false;

				growl.info('Despesas salvas com sucesso!');

			} else if ($scope.parcial < $scope.despesas.length) {
				$scope.$apply();
				despesaService.novo($scope.despesas[$scope.parcial], null, fn);
			}
		};

		despesaService.novo($scope.despesas[$scope.parcial], null, fn);

	};

});
