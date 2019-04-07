app.service('parametroService',function($http) {

	var pathBase = '/despesas/services/parametro';

	this.buscarPorId = function(id,fn) {
		$http.get(pathBase + '?nome=' + id).success(function(data) {
			fn(data);
		});
	};

});
