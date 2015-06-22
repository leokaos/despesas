app.controller('painelDespesaController',function($scope,despesaService,tipoDespesaService,orcamentoService,debitavelService,$location,$routeParams,growl) {

	$scope.despesas = [];
	$scope.tiposDespesa = [];
	$scope.debitaveis = [];
	$scope.totalTable = 0.0;

	$scope.add = function() {
		$scope.despesas.push(despesaService.getNovoDespesa());
	};

	$scope.remove = function(index) {
		$scope.despesas.splice(index,1);
	};

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
	});

});
