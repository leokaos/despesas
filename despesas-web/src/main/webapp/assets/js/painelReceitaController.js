app.controller('painelReceitaController',function($scope,receitaService,tipoReceitaService,orcamentoService,debitavelService,$location,$routeParams,growl,$http) {

	$scope.receitas = [];
	$scope.tiposReceita = [];
	$scope.debitaveis = [];
	$scope.totalTable = 0.0;
	$scope.receitaUpload = null;

	$scope.add = function() {
		$scope.receitas.push(receitaService.getNovaReceita());
	};

	$scope.remove = function(index) {
		$scope.receitas.splice(index,1);
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

		fd.append('arquivo',file.files[0]);

		$http.post('services/receita/upload',fd,{
		    transformRequest: angular.identity,
		    headers: {
			    'Content-Type': undefined
		    }
		}).success(function(data) {
			$scope.receitas = data;

			for (var x = 0 ; x < $scope.receitas.length ; x++) {
				$scope.receitas[x].debitavel = $scope.receitaUpload;
			}

			$('#modalUpload').modal('hide');

		}).error(function() {});
	};

});
