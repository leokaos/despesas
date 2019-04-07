app.service('cotacaoService',function($http) {

	var pathBase = '/despesas/services/cotacao/';

	this.getNovaCotacao = function() {
		return {
		    data: null,
		    origem: null,
		    destino: null,
		    taxa:null
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
	
	this.buscarPorOrigemDestino = function(origem, destino, fn) {
		
		var url = '/despesas/services/cotacao/?origem=' + origem + '&destino=' + destino + '&data=' + new Date().toGMTString();
		
		$http.get(url).success(function(data) {
			fn(data);
		});		
	};	

	this.deletar = function(id,fn) {
		 $http.delete(pathBase + id).success(function(data) {
			 fn(data);
		 });
	};
	
	this.buscarCotacao = function(origem, destino, fn) {
		
		var url = pathBase + 'nova?origem=' + origem + '&destino=' + destino; 
		
		$http.post(url).success(function(data){
			fn(data);
		});		
	};
	
});
