app.service('graficoService', function($http) {

	var pathBase = '/despesas/services/grafico/';

	this.buscarGraficoDespesas = function(dataInicio, dataFim, fn) {

		var request = $http({
			method : 'get',
			url : pathBase + 'despesas',
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