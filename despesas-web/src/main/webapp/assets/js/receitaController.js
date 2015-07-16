app.controller('receitaController',function($scope,receitaService,$location,$routeParams,usSpinnerService) {

	var dataInicial = new Date();
	dataInicial.setDate(1);

	var dataFinal = new Date();
	dataFinal.setMonth(dataFinal.getMonth() + 1);
	dataFinal.setDate(0);

	$scope.filtro = {
	    'dataInicial': dataInicial,
	    'dataFinal': dataFinal
	};

	$scope.receitaSelecionada = null;

	$scope.getTitulo = function() {
		return 'Receitas';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.receitaSelecionada != null) {
			return $scope.receitaSelecionada.descricao;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Receita deletada com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-receita-spin';
	};

	$scope.listar = function() {
		receitaService.buscarPorFiltro($scope.filtro,$scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/receita');
	};

	$scope.editar = function(id) {
		$location.path('/receita/' + id);
	};

	$scope.select = function(receita) {
		$scope.receitaSelecionada = receita;
	};

	$scope.getItemSelecionado = function() {
		return $scope.receitaSelecionada;
	};

	$scope.doDelete = function() {
		receitaService.deletar($scope.receitaSelecionada.id,$scope.deletar);
	};

	$scope.hasFiltro = function() {
		return true;
	};

	$scope.getFiltro = function() {
		return 'partial/receita/filtro.html';
	};

});

app.controller('edicaoReceitaController',function($scope,receitaService,tipoReceitaService,contaService,$location,$routeParams,growl) {

	$scope.tiposReceita = [];
	$scope.contas = [];

	var id = $routeParams.id;

	if (id != null) {
		receitaService.buscarPorId(id,function(receita) {
			$scope.receita = receita;
		});
	} else {
		$scope.receita = receitaService.getReceita();
	}

	if ($scope.receita.debitavel != null) {
		$scope.contaSelecionada = $scope.receita.debitavel;
	}

	if ($scope.receita.tipoReceita != null) {
		$scope.tipoReceitaSelecionado = $scope.receita.tipoReceita;
	}

	$scope.openData = function() {
		$scope.dataPickerOpened = true;
	};

	$scope.hasConta = function() {
		return $scope.contaSelecionada.id != null;
	};

	tipoReceitaService.listar(function(tiposReceita) {
		$scope.tiposReceita = tiposReceita;
	});

	contaService.listar(function(contas) {
		$scope.contas = contas;
	});

	$scope.cancelar = function() {
		$location.path('/receitas');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Receita salva com sucesso!');
	};

	$scope.salvar = function(valid) {

		if (valid) {
			if ($scope.receita.id) {
				receitaService.salvar($scope.receita,$scope.salvo);
			} else {
				receitaService.novo($scope.receita,$scope.salvo);
			}
		}
	};
});
