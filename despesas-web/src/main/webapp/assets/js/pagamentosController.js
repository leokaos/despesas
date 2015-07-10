app.controller('pagamentosController',function($scope,$http,$location,$routeParams,growl,movimentacaoService) {

	$scope.movimentacaoSelecionada = null;

	$scope.events = function(start,end,timezone,callback) {

		movimentacaoService.buscarMovimentacaoPorPeriodo(start._d,end._d,function(data) {

			var eventos = [];

			for (var i = 0 ; i < data.length ; i++) {
				var movimentacao = data[i];

				eventos.push({
				    title: movimentacao.descricao,
				    color: movimentacao.tipo.cor,
				    start: movimentacao.vencimento,
				    movimentacao: movimentacao
				});
			}

			callback(eventos);
		});
	};

	$scope.limparCarrregar = function() {
		$('#calendar-movimentacao').fullCalendar('refetchEvents');
		$scope.movimentacaoSelecionada = null;
	};

	$scope.selecionar = function(movimentacao) {
		$scope.movimentacaoSelecionada = movimentacao;
		$scope.$apply();
	};

});
