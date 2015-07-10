app.service('dashboardService',function($http) {

	var pathBase = '/despesas/services/dashbboard/';

	this.buscarDespesasPorPeriodo = function(dataInicio,dataFim,fn) {

		var request = $http({
		    method: 'get',
		    url: pathBase + 'main',
		    params: {
		        dataInicial: dataInicio.toGMTString(),
		        dataFinal: dataFim.toGMTString()
		    }
		});

		request.success(function(data) {
			fn(data);
		});
	};
});
