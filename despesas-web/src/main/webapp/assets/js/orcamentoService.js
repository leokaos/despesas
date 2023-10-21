app.service('orcamentoService',function($http) {

	var pathBase = 'http://localhost:8080/despesas/services/orcamento/';

	this.getNovoOrcamento = function() {
		return {
		    tipoDespesa: null,
		    periodo: new Periodo(null,null),
		    valor: null,
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
	
	this.buscarPorMes = function(periodo, fn){
		
		var filtro = {
				dataInicial: periodo.getDataInicial().toGMTString(),
				dataFinal: periodo.getDataFinal().toGMTString()
		}; 
		
		this.buscarPorFiltro(filtro,fn);		
	};
	
	this.buscarPorFiltro = function(filtro, fn){
		
		var url = pathBase + '?';
		
		for(key in filtro){
			url = url + key + '=' + filtro[key] + '&';
		}
		
		$http.get(url).success(function(data) {
			
			var lista = [];
			
			for(var x = 0; x < data.length; x++){
				lista.push(new OrcamentoVO(data[x]));
			}
			
			fn(lista);
		});		
		
	};

	this.deletar = function(id,fn) {
		 $http.delete(pathBase + id).success(function(data) {
			 fn(data);
		 });
	};

});
