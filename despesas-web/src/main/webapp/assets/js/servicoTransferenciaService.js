app.service('servicoTransferenciaService',function($http) {

	var pathBase = '/despesas/services/servicotransferencia/';

	this.getNovoServicoTransferencia = function() {
		return {
		    nome: null,
		    spred: null,
		    taxas: null,
		};
	};

	this.listar = function(fn) {
		$http.get(pathBase).success(function(data) {
			fn(data);
		});
	};

	this.novo = function(orcamento,fn) {
		$http.post(pathBase,orcamento).success(function(data) {
			fn(data);
		});
	};

	this.salvar = function(orcamento,fn) {
		$http.put(pathBase,orcamento).success(function(data) {
			fn(data);
		});
	};

	this.buscarPorId = function(id,fn) {
		$http.get(pathBase + id).success(function(data) {
			fn(data);
		});
	};
	
	this.buscarPorFiltro = function(filtro,fn) {
		
		var url = '/despesas/services/servicotransferencia?';
		
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
