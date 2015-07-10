app.service('movimentacaoService', function($http) {

	var pathBase = '/despesas/services/movimentacao/';

	this.buscarMovimentacaoPorPeriodo = function(dataInicio, dataFim, fn) {

		var request = $http({
			method : 'get',
			url : pathBase + 'buscarPorPeriodo',
			params : {
				dataInicial : dataInicio.toGMTString(),
				dataFinal : dataFim.toGMTString()
			}
		});

		request.success(function(data) {
			fn(data);
		});
	};
});
