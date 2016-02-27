app.controller('orcamentoController', function($scope, orcamentoService, $location, $routeParams, usSpinnerService, MESES) {

	$scope.MESES = MESES;
	$scope.orcamentoSelecionado = null;

	$scope.getTitulo = function() {
		return 'Orçamentos';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.orcamentoSelecionado != null) {
			return $scope.orcamentoSelecionado.toString();
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Orcamento deletado com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-orcamento-spin';
	};
	
	$scope.select = function(orcamento){
		$scope.orcamentoSelecionado = orcamento;
	};

	$scope.listar = function() {

		orcamentoService.listar(function(data) {

			$.each(data, function(index, value) {
				data[index] = new OrcamentoVO(value);
			});

			$scope.loadData(data);
		});
	};

	$scope.novo = function() {
		$location.path('/orcamento');
	};

	$scope.editar = function(id) {
		$location.path('/orcamento/' + id);
	};

	$scope.getItemSelecionado = function() {
		return $scope.orcamentoSelecionado;
	};

	$scope.doDelete = function() {
		orcamentoService.deletar($scope.orcamentoSelecionado.id, $scope.deletar);
	};

});

app.controller('edicaoOrcamentoController', function($scope, orcamentoService, tipoDespesaService, $location, $routeParams, growl, MESES) {

	$scope.MESES = MESES;
	$scope.orcamentoVO = null;
	$scope.tiposDespesa = [];

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	var id = $routeParams.id;

	if (id != null) {
		orcamentoService.buscarPorId(id, function(orcamento) {
			$scope.orcamentoVO = new OrcamentoVO(orcamento);
		});
	} else {
		$scope.orcamentoVO = new OrcamentoVO(orcamentoService.getNovoOrcamento());
	}

	$scope.cancelar = function() {
		$location.path('/orcamentos');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Orçamento salvo com sucesso!');
	};

	$scope.salvar = function(valid) {
		if (valid) {
			if ($scope.orcamentoVO.id) {
				orcamentoService.salvar($scope.orcamentoVO.toOrcamento(), $scope.salvo);
			} else {
				orcamentoService.novo($scope.orcamentoVO.toOrcamento(), $scope.salvo);
			}
		}
	};
});
