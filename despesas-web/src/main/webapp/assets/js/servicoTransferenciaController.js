app.controller('servicoTransferenciaController', function($scope, servicoTransferenciaService, $location, $routeParams, usSpinnerService) {

	$scope.servicoTransferenciaSelecionado = null;

	$scope.getTitulo = function() {
		return 'Serviços de Transferência';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.servicoTransferenciaSelecionado != null) {
			return $scope.servicoTransferenciaSelecionado.nome;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Serviço deletado com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-servico-spin';
	};

	$scope.listar = function() {
		servicoTransferenciaService.listar($scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/servicotransferencia');
	};

	$scope.editar = function(id) {
		$location.path('/servicotransferencia/' + id);
	};

	$scope.select = function(conta) {
		$scope.servicoTransferenciaSelecionado = conta;
	};

	$scope.getItemSelecionado = function() {
		return $scope.servicoTransferenciaSelecionado;
	};

	$scope.doDelete = function() {
		servicoTransferenciaService.deletar($scope.servicoTransferenciaSelecionado.id, $scope.deletar);
	};

});

app.controller('edicaoServicoTransferenciaController', function($scope, servicoTransferenciaService, $location, $routeParams, growl) {

	var id = $routeParams.id;

	if (id != null) {
		servicoTransferenciaService.buscarPorId(id, function(servicoTransferencia) {
			$scope.servicoTransferencia = servicoTransferencia;
		});
	} else {
		$scope.servicoTransferencia = servicoTransferenciaService.getNovoServicoTransferencia();
	}

	$scope.cancelar = function() {
		$location.path('/servicostransferencia');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Serviço Transferência salvo com sucesso!');
	};

	$scope.salvar = function(valid) {

		if (valid) {

			if ($scope.servicoTransferencia.custoVariavel) {
				$scope.servicoTransferencia.taxas = null;
			}

			if ($scope.servicoTransferencia.id) {
				servicoTransferenciaService.salvar($scope.servicoTransferencia, $scope.salvo);
			} else {
				servicoTransferenciaService.novo($scope.servicoTransferencia, $scope.salvo);
			}
		}
	};
});