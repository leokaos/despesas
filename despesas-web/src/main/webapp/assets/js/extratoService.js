app.service('extratoService', function($http) {

	pathBase = '/despesas/services/extrato/';

	this.gerarExtrato = function(dataInicial, dataFinal, debitavel, fn) {

		var request = $http({
			method : 'get',
			url : pathBase,
			params : {
				dataInicial : dataInicial.toGMTString(),
				dataFinal : dataFinal.toGMTString(),
				id : debitavel.id
			}
		});

		request.success(function(data) {
			fn(data);
		});

	};

});