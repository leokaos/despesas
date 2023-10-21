app.service('parametroService',function($http) {

	var pathBase = 'http://localhost:8080/despesas/services/parametro';

	this.buscarPorId = function(id,fn) {
		$http.get(pathBase + '?nome=' + id).success(function(data) {
			fn(data);
		});
	};

});
