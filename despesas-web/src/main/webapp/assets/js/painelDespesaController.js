app.controller('painelDespesaController',function($scope,despesaService,tipoDespesaService,orcamentoService,debitavelService,$location,$routeParams,growl,$http,$parse) {

	$scope.despesas = [];
	$scope.tiposDespesa = [];
	$scope.debitaveis = [];
	$scope.totalTable = 0.0;
	$scope.despesaUpload = null;

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

	$scope.uploadFile = function() {

		var fd = new FormData();

		var file = document.getElementById("arquivo");

		fd.append('arquivo',file.files[0]);

		$http.post('services/despesa/upload',fd,{
		    transformRequest: angular.identity,
		    headers: {
			    'Content-Type': undefined
		    }
		}).success(function(data) {
			$scope.despesas = data;

			for (var x = 0 ; x < $scope.despesas.length ; x++) {
				$scope.despesas[x].debitavel = $scope.despesaUpload;
			}

			$('#modalUpload').modal('hide');

		}).error(function() {});
	};

});
