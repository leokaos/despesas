app.service('projecaoService', function($http) {

	pathBase = '/despesas/services/projecao/';

	this.gerarProjecao = function(numeroMeses, debitavel, fn) {

		var request = $http({
			method : 'get',
			url : pathBase,
			params : {
				meses :numeroMeses,
				debitavelId : debitavel.id
			}
		});

		request.success(function(data) {
			fn(data);
		});

	};

});