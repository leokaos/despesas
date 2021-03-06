app.controller('compararServicosTransferenciaController', function (MOEDAS, parametroService, cotacaoService, servicoTransferenciaService, transferenciaService, debitavelService, $scope, growl) {

	$scope.MOEDAS = MOEDAS;
	$scope.MOEDAS_NAMES = [];

	$scope.spot = 0.0;
	$scope.iof = 0.0;
	$scope.valorTotal = 0.0;

	$scope.cotacao = {
		taxa: 0.0
	};

	$scope.cotacoes = [];
	$scope.servicosFiltrados = [];

	$scope.debitavel = {};
	$scope.creditavel = {};

	parametroService.buscarPorId('IOF', function (data) {
		$scope.iof = parseFloat(data);
	});

	parametroService.buscarPorId('SPOT', function (data) {
		$scope.spot = parseFloat(data);
	});

	cotacaoService.buscarPorFiltro({
		'data': new Date().toGMTString()
	}, function (data) {

		if (data[0]) {
			$scope.cotacao = data[0];
		}
	});

	for (item in MOEDAS) {
		$scope.MOEDAS_NAMES.push(item);
	}

	$scope.filtro = {
		destino: null,
		origem: null
	};

	debitavelService.listar(function (debitaveis) {
		$scope.debitaveis = debitaveis;
	});

	$scope.filtroServico = {
		nome: ""
	};

	$scope.efetuar = function () {

		var transferenciaVO = {
			"transferencia": {
				"valor": $scope.valorTotal,
				"debitavel": $scope.debitavel,
				"creditavel": $scope.creditavel
			},
			"servicoTransferencia": $scope.servicoSelecionado,
			"cotacao": $scope.cotacao
		};

		transferenciaService.novo(transferenciaVO, function () {
			$('#modalEfetuar').modal('hide');
			growl.info('Transferência salva com sucesso!');
		});

	};

	$scope.selecionarServico = function (servico) {
		$scope.servicoSelecionado = servico;
	}

	$scope.buscarCotacoes = function () {

		cotacaoService.buscarPorOrigemDestino($scope.filtro.origem, $scope.filtro.destino, function (data) {
			$scope.cotacoes = data;
		});
	};

	$scope.selecionar = function (cotacao) {
		$scope.cotacao = cotacao;
		$('#modalSelecionarCotacao').modal('hide');
	};

	$scope.servicos = [];

	$scope.calcularTotalBruto = function (servico) {
		
		var cotacaoSemSpot = $scope.cotacao.taxa - $scope.spot;
		
		var cotacaoDepoisSpred = Math.round(((cotacaoSemSpot * (1 - servico.spred/100)) + Number.EPSILON) * 100) / 100;
		
		var total = parseFloat(cotacaoDepoisSpred * $scope.valorTotal);
		
		return total;
	};

	$scope.calcularTotalLiquido = function (servico) {

		var totalBruto = $scope.calcularTotalBruto(servico);

		if (totalBruto <= 0.0) {
			return 0.0;
		}

		return totalBruto * (1 - $scope.iof / 100) - servico.taxas;
	};

	$scope.adicionarServico = function (servico) {

		for (var i = 0; i < $scope.servicosFiltrados.length; i++) {
			if (servico.nome == $scope.servicosFiltrados[i].nome) {
				$scope.servicosFiltrados.splice(i, 1);
				break;
			}
		}

		if (servico.custoVariavel) {
			servico.taxas = 0.0;
		}

		$scope.servicos.push(servico);
	};

	$scope.buscarServicos = function () {

		servicoTransferenciaService.buscarPorFiltro($scope.filtroServico, function (data) {

			$scope.servicosFiltrados = data.filter(function (servico) {

				for (var i = 0; i < $scope.servicos.length; i++) {
					if (servico.nome == $scope.servicos[i].nome) {
						return false;
					}
				}

				return true;
			});

		});
	};

});
