app.controller('cartaoController',function($scope,cartaoService,$location,$routeParams,usSpinnerService) {

	$scope.cartaoSelecionado = null;

	$scope.getTitulo = function() {
		return 'Cartões de Crédito';
	};

	$scope.getDescricaoSelecionado = function() {

		if ($scope.cartaoSelecionado != null) {
			return $scope.cartaoSelecionado.descricao;
		} else {
			return '';
		}
	};

	$scope.verFatura = function(cartao) {
		$location.path('/fatura/' + cartao.id);
	};

	$scope.getMensagemDelete = function() {
		return 'Cartão deletado com sucesso!';
	};

	$scope.getNomeSpin = function() {
		return 'tipo-cartao-spin';
	};

	$scope.listar = function() {
		cartaoService.listar($scope.loadData);
	};

	$scope.novo = function() {
		$location.path('/cartao');
	};

	$scope.editar = function(id) {
		$location.path('/cartao/' + id);
	};

	$scope.select = function(cartao) {
		$scope.cartaoSelecionado = cartao;
	};

	$scope.getItemSelecionado = function() {
		return $scope.cartaoSelecionado;
	};

	$scope.doDelete = function() {
		cartaoService.deletar($scope.cartaoSelecionado.id,$scope.deletar);
	};

	$scope.bandeiras = {
	    'VISA': 'fa fa-cc-visa',
	    'MASTERCARD': 'fa fa-cc-mastercard',
	    'AMERICAN_EXPRESS': 'fa fa-cc-ame'
	};

});

app.controller('edicaoCartaoController',function($scope,cartaoService,$location,$routeParams,growl) {

	$scope.bandeiras = [
	        'VISA',
	        'MASTERCARD',
	        'AMERICAN EXPRESS'
	];

	var id = $routeParams.id;

	if (id != null) {
		cartaoService.buscarPorId(id,function(cartao) {
			$scope.cartao = cartao;
		});
	} else {
		$scope.cartao = cartaoService.getNovoCartao();
	}

	$scope.cancelar = function() {
		$location.path('/cartoes');
	};

	$scope.limparCarregar = function(data) {
		$('#modalSalvar').modal('hide');
		$scope.cancelar();
	};

	$scope.salvo = function(data) {
		$scope.limparCarregar(data);
		growl.info('Cartão salvo com sucesso!');
	};

	$scope.salvar = function(valid) {

		if (valid) {
			if ($scope.cartao.id) {
				cartaoService.salvar($scope.cartao,$scope.salvo);
			} else {
				cartaoService.novo($scope.cartao,$scope.salvo);
			}
		}
	};
});
