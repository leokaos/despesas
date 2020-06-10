app.controller('dividaController', function($scope, dividaService, $location, $routeParams, usSpinnerService, PERIODICIDADE) {

	$scope.dividaSelecionada = null;

	$scope.getTitulo = function() {
		return 'Dívidas';
	};
	
	$scope.PERIODICIDADE = PERIODICIDADE;

	$scope.getDescricaoSelecionado = function() {

		if ($scope.dividaSelecionada != null) {
			return $scope.dividaSelecionada.descricao;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Dívida deletada com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'divida-spin';
	};

	$scope.listar = function() {
		dividaService.listar($scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/divida');
	};

	$scope.editar = function(id) {
		$location.path('/divida/' + id);
	};

	$scope.select = function(divida) {
		$scope.dividaSelecionada = divida;
	};

	$scope.getItemSelecionado = function() {
		return $scope.dividaSelecionada;
	};

	$scope.doDelete = function() {
		dividaService.deletar($scope.dividaSelecionada.id, $scope.deletar);
	};

});

app.controller('edicaoDividaController', function($scope, dividaService, $location, $routeParams, growl, PERIODICIDADE) {

	var id = $routeParams.id;
	
	$scope.PERIODICIDADE = PERIODICIDADE;

	if (id != null) {
		dividaService.buscarPorId(id, function(divida) {
			$scope.divida = divida;
		});
	} else {
		$scope.divida = dividaService.getNovaDivida();
	}

	$scope.cancelar = function() {
		$location.path('/dividas');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Dívida salva com sucesso!');
	};
	
	$scope.salvar = function(valid) {
		
		if (valid) {
			if ($scope.divida.id) {
				dividaService.salvar($scope.divida, $scope.salvo);
			} else {
				dividaService.novo($scope.divida, $scope.salvo);
			}
		}
	};
});
