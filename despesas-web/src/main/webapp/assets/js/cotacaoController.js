app.controller('cotacaoController', function (MOEDAS,$scope, cotacaoService, $location, $routeParams, usSpinnerService) {

    $scope.cotacaoSelecionada= null;
    $scope.MOEDAS = MOEDAS;

    $scope.getTitulo = function () {
        return 'Cotações';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.cotacaoSelecionada != null) {
            return $scope.cotacaoSelecionada.toString();
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Cotação deletada com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-cotacao-spin';
    };

    $scope.listar = function () {
        cotacaoService.listar(function(data) {

			$.each(data, function(index, value) {
				data[index] = new CotacaoVO(value);
			});

			$scope.loadData(data);
		});
    };

    $scope.novo = function () {
        $location.path('/cotacao');
    };

    $scope.editar = function (id) {
        $location.path('/cotacao/' + id);
    };

    $scope.select = function (conta) {
        $scope.cotacaoSelecionada = conta;
    };

    $scope.getItemSelecionado = function () {
        return $scope.cotacaoSelecionada;
    };

    $scope.doDelete = function () {
    	cotacaoService.deletar($scope.cotacaoSelecionada.id, $scope.deletar);
    };

});

app.controller('edicaoCotacaoController', function (MOEDAS, $scope, cotacaoService, $location, $routeParams, growl) {

    var id = $routeParams.id;
    
    $scope.MOEDAS = MOEDAS;
    $scope.MOEDAS_NAMES = [];

    for(item in MOEDAS) {
    	$scope.MOEDAS_NAMES.push(item);
    }
    
    if (id != null) {
    	cotacaoService.buscarPorId(id, function (cotacao) {
            $scope.cotacao = new CotacaoVO(cotacao);
        });
    } else {
        $scope.cotacao = new CotacaoVO(cotacaoService.getNovaCotacao());
    }

    $scope.cancelar = function () {
        $location.path('/cotacoes');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Cotação salva com sucesso!');
    };
    
    $scope.buscarCotacao = function() {
    	cotacaoService.buscarCotacao($scope.cotacao.origem, $scope.cotacao.destino, function(data){
    		$scope.cotacao = new CotacaoVO(data);
    	});
    };

    $scope.salvar = function (valid) {

        if (valid) {
            if ($scope.cotacao.id) {
            	cotacaoService.salvar($scope.cotacao.toCotacao(), $scope.salvo);
            } else {
            	cotacaoService.novo($scope.cotacao.toCotacao(), $scope.salvo);
            }
        }
    };
});