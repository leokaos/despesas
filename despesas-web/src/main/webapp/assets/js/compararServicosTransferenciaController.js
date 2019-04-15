app.controller('compararServicosTransferenciaController', function(MOEDAS, parametroService, cotacaoService, servicoTransferenciaService, $scope, $location, $routeParams, growl, $http) {

	$scope.MOEDAS = MOEDAS;
	$scope.MOEDAS_NAMES = [];

	$scope.spot = 0.0;
	$scope.iof = 0.0;
	$scope.valorTotal = 0.0;

	$scope.cotacao = {
		taxa : 0.0
	};

	$scope.cotacoes = [];
	$scope.servicosFiltrados = [];

	parametroService.buscarPorId('IOF', function(data) {
		$scope.iof = parseFloat(data);
	});

	parametroService.buscarPorId('SPOT', function(data) {
		$scope.spot = parseFloat(data);
	});

	for (item in MOEDAS) {
		$scope.MOEDAS_NAMES.push(item);
	}

	$scope.filtro = {
		destino : null,
		origem : null
	};

	$scope.filtroServico = {
		nome : ""
	};

	$scope.buscarCotacoes = function() {

		cotacaoService.buscarPorOrigemDestino($scope.filtro.origem, $scope.filtro.destino, function(data) {
			$scope.cotacoes = data;
		});
	};

	$scope.selecionar = function(cotacao) {
		$scope.cotacao = cotacao;
		$('#modalSelecionarCotacao').modal('hide');
	};

	$scope.servicos = [];

	$scope.calcularTotalBruto = function(servico) {
		return parseFloat((($scope.cotacao.taxa - $scope.spot) * (1 - (servico.spred / 100))).toFixed(2)) * $scope.valorTotal;
	};

	$scope.calcularTotalLiquido = function(servico) {

		var totalBruto = $scope.calcularTotalBruto(servico);

		if (totalBruto <= 0.0) {
			return 0.0;
		}

		return (totalBruto * (1 - $scope.iof / 100)) - servico.taxas;
	};

	$scope.adicionarServico = function(servico) {
		$scope.servicos.push(servico);
	};

	$scope.buscarServicos = function() {
		servicoTransferenciaService.buscarPorFiltro($scope.filtroServico, function(data) {
			$scope.servicosFiltrados = data;
		});
	};

	$scope.servicoJaAdicionado = function(servico) {

		for (var i = 0; i < $scope.servicos.length; i++) {
			if (servico.nome == $scope.servicos[i].nome) {
				return true;
			}
		}

		return false;
	};

});
