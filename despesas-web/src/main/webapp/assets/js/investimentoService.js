app.service('investimentoService',function($http) {

	var pathBase = '/despesas/services/investimento/';

	this.getNovoInvestimento = function() {
		return {
			descricao: '',
			id: null,
			tipo: 'INVESTIMENTO'
		};
	};

	this.listar = function(fn) {
		$http.get(pathBase).success(function(data) {
			fn(data);
		});
	};

	this.novo = function(investimento,fn) {
		$http.post(pathBase,investimento).success(function(data) {
			fn(data);
		});
	};

	this.salvar = function(investimento,fn) {
		$http.put(pathBase,investimento).success(function(data) {
			fn(data);
		});
	};

	this.buscarPorId = function(id,fn) {
		$http.get(pathBase + id).success(function(data) {
			fn(data);
		});
	};
	
	this.buscarPorFiltro = function(filtro, fn){
		
		var url = pathBase + '?';
		
		for(key in filtro){
			url = url + key + '=' + filtro[key] + '&';
		}
		
		$http.get(url).success(function(data) {
			fn(data);
		});		
		
	};

	this.deletar = function(id,fn) {
		 $http.delete(pathBase + id).success(function(data) {
			 fn(data);
		 });
	};

});
