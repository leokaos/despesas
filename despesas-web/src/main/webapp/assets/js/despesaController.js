app.controller('edicaoDespesaController', function($scope, $http, contaService, tipoDespesaService, despesaService, $location, $routeParams) {

	$scope.tiposDespesa = [];
	$scope.contas = [];

	$scope.tipoDespesaSelecionado = {
		descricao : 'Selecione'
	};

	$scope.contaSelecionada = {
		nome : 'Selecione'
	};

	$scope.despesa = {
		descricao : '',
		vencimento : null,
		valor : null,
		tipoDespesa : null,
		conta : null,
		paga : false
	};

	$scope.openData = function() {
		$scope.dataPickerOpened = true;
	};

	$scope.selecionarTipoDespesa = function(tipoDespesa) {
		$scope.tipoDespesaSelecionado = tipoDespesa;
		$scope.despesa.tipoDespesa = $scope.tipoDespesaSelecionado;
	};

	$scope.selecionarConta = function(conta) {
		$scope.contaSelecionada = conta;
		$scope.despesa.conta = $scope.contaSelecionada;
	};

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	contaService.listar(function(contas) {
		$scope.contas = contas;
	});

	$scope.salvar = function(valid) {

		if (valid) {

			if ($scope.despesa.id) {

				despesaService.salvar($scope.$scope.despesa, function(data) {
					$('#modalSalvar').modal('hide');
					$location.path('/despesa');
				});

			} else {

				despesaService.novo($scope.despesa, function(data) {
					$('#modalSalvar').modal('hide');
					$location.path('/despesa');
				});
			}
		}
	};
});