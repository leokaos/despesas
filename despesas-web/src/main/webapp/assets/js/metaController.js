app.controller('metaController', function($scope, metaService, $location, $routeParams, usSpinnerService,MESES) {

	var dataInicial = new Date();
	dataInicial.setDate(1);

	var dataFinal = new Date();
	dataFinal.setMonth(dataFinal.getMonth() + 1);
	dataFinal.setDate(0);
	
	$scope.MESES = MESES;

	$scope.metasSelecionadas = [];

	$scope.filtro = {
		'dataInicial' : dataInicial,
		'dataFinal' : dataFinal
	};

	$scope.metaSelecionada = null;

	$scope.getTitulo = function() {
		return 'Metas';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.metaSelecionada != null) {
			return $scope.metaSelecionada.descricao;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Meta deletada com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'meta-spin';
	};

	$scope.listar = function() {
		metaService.listar($scope.filtro, function(data) {

			$.each(data, function(index, value) {
				data[index] = new MetaVO(value);
			});

			$scope.loadData(data);
		});
	};
	
	$scope.novo = function() {
		$location.path('/meta');
	};

	$scope.editar = function(id) {
		$location.path('/meta/' + id);
	};

	$scope.select = function(meta) {
		$scope.metaSelecionada = meta;
	};

	$scope.getItemSelecionado = function() {
		return $scope.metaSelecionada;
	};

	$scope.doDelete = function() {
		metaService.deletar($scope.metaSelecionada.id, $scope.deletar);
	};

	$scope.hasFiltro = function() {
		return true;
	};

	$scope.getFiltro = function() {
		return 'partial/meta/filtro.html';
	};

	$scope.seleciona = function(meta) {

		var index = $scope.metasSelecionadas.indexOf(meta);

		if (index == -1) {
			$scope.metasSelecionadas.push(meta);
		} else {
			$scope.metasSelecionadas.splice(index, 1);
		}

	};

});

app.controller('edicaoMetaController', function($scope, metaService, $location, $routeParams, growl,MESES) {

	var id = $routeParams.id;
	$scope.MESES = MESES;

	if (id != null) {
		metaService.buscarPorId(id, function(meta) {
			$scope.meta = new MetaVO(meta);
		});
	} else {
		$scope.meta = metaService.getNovaMeta();
	}

	$scope.cancelar = function() {
		$location.path('/metas');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Meta salva com sucesso!');
	};

	$scope.salvar = function(valid) {

		if (valid) {

			if ($scope.despesa.id) {
				metaService.salvar($scope.meta, $scope.salvo);
			} else {
				dmetaService.novo($scope.meta, $scope.salvo);
			}
		}
	};
});
