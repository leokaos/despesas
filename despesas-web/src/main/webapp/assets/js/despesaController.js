app.controller('despesaController', function($scope, despesaService, $location, $routeParams, usSpinnerService) {

	var dataInicial = new Date();
	dataInicial.setDate(1);

	var dataFinal = new Date();
	dataFinal.setMonth(dataFinal.getMonth() + 1);
	dataFinal.setDate(0);

	$scope.despesasSelecionadas = [];

	$scope.filtro = {
		'dataInicial' : dataInicial,
		'dataFinal' : dataFinal
	};

	$scope.despesaSelecionada = null;

	$scope.getTitulo = function() {
		return 'Despesas';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.despesaSelecionada != null) {
			return $scope.despesaSelecionada.descricao;
		} else {
			return '';
		}
	};

	$scope.getMensagemDelete = function() {
		return 'Despesa deletada com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-despesa-spin';
	};

	$scope.listar = function() {
		despesaService.listar($scope.filtro, $scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/despesa');
	};

	$scope.editar = function(id) {
		$location.path('/despesa/' + id);
	};

	$scope.select = function(despesa) {
		$scope.despesaSelecionada = despesa;
	};

	$scope.getItemSelecionado = function() {
		return $scope.despesaSelecionada;
	};

	$scope.doDelete = function() {
		despesaService.deletar($scope.despesaSelecionada.id, $scope.deletar);
	};

	$scope.hasFiltro = function() {
		return true;
	};

	$scope.getFiltro = function() {
		return 'partial/despesa/filtro.html';
	};

	$scope.seleciona = function(despesa) {

		var index = $scope.despesasSelecionadas.indexOf(despesa);

		if (index == -1) {
			$scope.despesasSelecionadas.push(despesa);
		} else {
			$scope.despesasSelecionadas.splice(index, 1);
		}

	};

});

app.controller('edicaoDespesaController', function($scope, despesaService, tipoDespesaService, orcamentoService, debitavelService, $location, $routeParams, growl) {

	$scope.tiposDespesa = [];
	$scope.debitaveis = [];
	$scope.tiposParcelamento = [ 'Semanal', 'Mensal', 'Semestral', 'Anual' ];
	$scope.parcelar = false;
	$scope.orcamento = null;
	$scope.parcelamento = {};

	var id = $routeParams.id;

	if (id != null) {
		despesaService.buscarPorId(id, function(despesa) {
			$scope.despesa = despesa;
		});
	} else {
		$scope.despesa = despesaService.getNovoDespesa();
	}

	$scope.openData = function() {
		$scope.dataPickerOpened = true;
	};

	$scope.selecionarTipoDespesa = function(tipoDespesa) {
		$scope.tipoDespesaSelecionado = tipoDespesa;
		$scope.despesa.tipo = $scope.tipoDespesaSelecionado;

		if ($scope.tipoDespesaSelecionado != null && $scope.despesa.vencimento != null) {

			var periodo = new Periodo(new Date().getMonth(), new Date().getFullYear());

			var filtro = {
				dataInicial : periodo.getDataInicial().toGMTString(),
				dataFinal : periodo.getDataFinal().toGMTString(),
				tipoDespesa : tipoDespesa.descricao
			};

			orcamentoService.buscarPorFiltro(filtro, function(data) {
				if (data != null && data != "") {
					$scope.orcamento = data[0];
				}
			});
		}

	};

	tipoDespesaService.listar(function(tiposDespesa) {
		$scope.tiposDespesa = tiposDespesa;
	});

	debitavelService.listar(function(debitaveis) {
		$scope.debitaveis = debitaveis;
	});

	$scope.hasOrcamento = function() {
		return $scope.orcamento != null;
	};

	$scope.cancelar = function() {
		$location.path('/despesas');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('despesa salva com sucesso!');
	};

	$scope.setMoeda = function(debitavel) {

		$scope.debitavelSelecionado = debitavel;

		$scope.despesa.debitavel = debitavel;
		$scope.despesa.moeda = debitavel.moeda;
	};

	$scope.salvar = function(valid) {

		if (valid) {

			if (!$scope.parcelar) {
				$scope.parcelamento = null;
			}

			if ($scope.despesa.id) {
				despesaService.salvar($scope.despesa, $scope.parcelamento, $scope.salvo);
			} else {
				despesaService.novo($scope.despesa, $scope.parcelamento, $scope.salvo);
			}
		}
	};
});
