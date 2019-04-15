app.controller('transferenciaController', function($scope, transferenciaService, $location, $routeParams, usSpinnerService) {

	$scope.transferenciaSelecionado = null;

	$scope.getTitulo = function() {
		return 'Trânsferencias';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.transferenciaSelecionado != null) {
			return $scope.transferenciaSelecionado.descricao;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Transferencia deletada com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-receita-spin';
	};

	$scope.listar = function() {
		transferenciaService.listar($scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/transferencia');
	};

	$scope.editar = function(id) {
		$location.path('/transferencia/' + id);
	};

	$scope.select = function(transferencia) {
		$scope.transferenciaSelecionado = transferencia;
	};

	$scope.getItemSelecionado = function() {
		return $scope.transferenciaSelecionado;
	};

	$scope.doDelete = function() {
		transferenciaService.deletar($scope.transferenciaSelecionado.id, $scope.deletar);
	};

});

app.controller('edicaoTransferenciaController', function($scope, transferenciaService, debitavelService, $location, $routeParams, growl) {

	var id = $routeParams.id;

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
	});

	if (id != null) {
		transferenciaService.buscarPorId(id, function(transferencia) {
			$scope.transferencia = transferencia;
		});
	} else {
		$scope.transferencia = transferenciaService.getNovaTransferencia();
	}

	$scope.cancelar = function() {
		$location.path('/transferencias');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Transferência salva com sucesso!');
	};
	
	$scope.setMoeda = function(debitavel){
		$scope.transferencia.moeda = debitavel.moeda;
	};

	$scope.salvar = function(valid) {

		if (valid) {
			if ($scope.transferencia.id) {
				transferenciaService.salvar($scope.transferencia, $scope.salvo);
			} else {
				transferenciaService.novo($scope.transferencia, $scope.salvo);
			}
		}
	};
});
