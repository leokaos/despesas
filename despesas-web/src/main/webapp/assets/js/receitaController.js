app.controller('receitaController', function($scope, receitaService, $location, $routeParams, usSpinnerService) {

	var dataInicial = new Date();
	dataInicial.setDate(1);

	var dataFinal = new Date();
	dataFinal.setMonth(dataFinal.getMonth() + 1);
	dataFinal.setDate(0);

	$scope.receitasSelecionadas = [];

	$scope.filtro = {
		'dataInicial' : dataInicial,
		'dataFinal' : dataFinal
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
		return 'receita deletada com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-receita-spin';
	};

	$scope.listar = function() {
		receitaService.listar($scope.filtro, $scope.loadData);
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
		receitaService.deletar($scope.receitaSelecionada.id, $scope.deletar);
	};

	$scope.hasFiltro = function() {
		return true;
	};

	$scope.getFiltro = function() {
		return 'partial/receita/filtro.html';
	};

	$scope.seleciona = function(receita) {

		var index = $scope.receitasSelecionadas.indexOf(receita);

		if (index == -1) {
			$scope.receitasSelecionadas.push(receita);
		} else {
			$scope.receitasSelecionadas.splice(index, 1);
		}

	};

});

app.controller('edicaoReceitaController', function($scope, receitaService, tipoReceitaService, debitavelService, $location, $routeParams, growl) {

	$scope.tiposReceita = [];
	$scope.debitaveis = [];
	$scope.tiposParcelamento = [ 'Semanal', 'Mensal', 'Semestral', 'Anual' ];
	$scope.parcelar = false;
	$scope.orcamento = null;
	$scope.parcelamento = {};

	var id = $routeParams.id;

	if (id != null) {
		receitaService.buscarPorId(id, function(receita) {
			$scope.receita = receita;
		});
	} else {
		$scope.receita = receitaService.getNovoReceita();
	}

	$scope.openData = function() {
		$scope.dataPickerOpened = true;
	};

	tipoReceitaService.listar(function(tiposreceita) {
		$scope.tiposReceita = tiposreceita;
	});

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
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
	
	$scope.setMoeda = function(debitavel){
		
		$scope.debitavelSelecionado = debitavel;
		
		$scope.receita.debitavel = debitavel;
		$scope.receita.moeda = debitavel.moeda;
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
