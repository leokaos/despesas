app.controller('investimentoController', function($scope, investimentoService, $location, $routeParams, usSpinnerService, PERIODICIDADE, MOEDAS) {

	$scope.investimentoSelecionado = null;
	$scope.PERIODICIDADE = PERIODICIDADE;
	$scope.MOEDAS = MOEDAS;

	$scope.getTitulo = function() {
		return 'Investimentos';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.investimentoSelecionado != null) {
			return $scope.investimentoSelecionado.descricao;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Investimento deletado com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'investimento-spin';
	};

	$scope.listar = function() {
		investimentoService.buscarPorFiltro($scope.filtro, $scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/investimento');
	};

	$scope.editar = function(id) {
		$location.path('/investimento/' + id);
	};

	$scope.select = function(investimento) {
		$scope.investimentoSelecionado = investimento;
	};

	$scope.getItemSelecionado = function() {
		return $scope.investimentoSelecionado;
	};

	$scope.doDelete = function() {
		investimentoService.deletar($scope.investimentoSelecionado.id, $scope.deletar);
	};
	
});

app.controller('edicaoInvestimentoController', function($scope, investimentoService, tipoDespesaService, $location, $routeParams, growl, MOEDAS) {

	$scope.MOEDAS = MOEDAS;
	$scope.investimento = null;
	$scope.tiposDespesa = [];

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	var id = $routeParams.id;

	if (id != null) {
		investimentoService.buscarPorId(id, function(investimento) {
			$scope.investimento = investimento;
		});
	} else {
		$scope.investimento = investimentoService.getNovoInvestimento();
	}

	$scope.cancelar = function() {
		$location.path('/investimentos');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Investimento salvo com sucesso!');
	};

	$scope.salvar = function(valid) {
		if (valid) {
			if ($scope.investimento.id) {
				investimentoService.salvar($scope.investimento, $scope.salvo);
			} else {
				investimentoService.novo($scope.investimento, $scope.salvo);
			}
		}
	};
});
