app.service('graficoService', function($http) {

	pathBase = '/despesas/services/grafico/';

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
	
	this.buscarGraficoReceitas = function(dataInicio, dataFim, fn) {

		var request = $http({
			method : 'get',
			url : pathBase + 'receitas',
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