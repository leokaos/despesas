app.controller('faturaController', function($scope, faturaService, contaService, cartaoService, despesaService, $location, $routeParams, usSpinnerService, growl) {

	$scope.cartaoCreditoId = $routeParams.id;

	$scope.faturas = [];
	$scope.faturaSelecionada = null;
	$scope.debitavelPagar = null;
	$scope.debitaveis = [];

	$scope.selecionarFatura = function(fatura) {
		$scope.faturaSelecionada = fatura;
	};

	cartaoService.buscarPorId($scope.cartaoCreditoId, function(data) {
		$scope.cartao = data;
	});

	faturaService.buscarFaturaPorCartaoCredito($scope.cartaoCreditoId, function(data) {

		for (var i = 0; i < data.length; i++) {
			$scope.faturas.push(data[i]);
		}
	});

	contaService.listar(function(data) {
		$scope.debitaveis = data;
	});

	$scope.mostrarItens = function(fatura) {
		$scope.faturaSelecionada = fatura;
		$scope.despesas = fatura.despesas;

		$scope.valorTotal = 0.0;

		for (var i = 0; i < $scope.despesas.length; i++) {
			$scope.valorTotal += $scope.despesas[i].valor;
		}
	};

	$scope.cancelar = function() {
		$location.path('/cartoes');
	};

	$scope.pagarFatura = function() {
		faturaService.pagar($scope.faturaSelecionada, $scope.debitavelPagar, $scope.dataPagamento, function() {

			growl.info('Fatura paga com sucesso!');

			$('#modalSelecionarConta').modal('hide');

		});
	};

});
