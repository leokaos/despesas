app.controller('faturaController', function($scope, faturaService, cartaoService, contaService, $location, $routeParams, usSpinnerService) {

	$scope.cartaoCreditoId = $routeParams.id;

	$scope.faturas = [];
	$scope.contas = [];

	cartaoService.buscarPorId($scope.cartaoCreditoId, function(data) {
		$scope.cartao = data;
	});

	contaService.listar(function(contas) {
		$scope.contas = contas;
	});

	faturaService.buscarFaturaPorCartaoCredito($scope.cartaoCreditoId, function(data) {

		for (var i = 0; i < data.length; i++) {
			$scope.faturas.push(new Fatura(data[i]));
		}
	});

	$scope.mostrarItens = function(fatura) {
		$scope.despesas = fatura.despesas;

		$scope.valorTotal = 0.0;

		for (var i = 0; i < $scope.despesas.length; i++) {
			$scope.valorTotal += $scope.despesas[i].valor;
		}
	};

	$scope.cancelar = function() {
		$location.path('/cartoes');
	};

	$scope.selecionarFatura = function(fatura) {
		$scope.faturaSelecionada = fatura;
	};

	$scope.selecionarConta = function(conta) {
		$scope.contaSelecionada = conta;
	};

	$scope.pagarFatura = function() {
		faturaService.pagar($scope.faturaSelecionada.id, $scope.contaSelecionada.id, function() {
			$location.path('/faturas');
		});
	};

});

function Fatura(dados) {
	angular.extend(this, dados);

	if (this.dataVencimento != null) {
		var data = new Date(this.dataVencimento);
		this.periodo = new Periodo(data.getMonth() + 1, data.getFullYear());
	} else {
		this.periodo = new Periodo(null, null);
	}
}