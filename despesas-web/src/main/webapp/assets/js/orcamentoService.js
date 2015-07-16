app.service('orcamentoService',function($http) {

	var pathBase = '/despesas/services/orcamento/';

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

	this.deletar = function(id,fn) {
		 $http.delete(pathBase + id).success(function(data) {
			 fn(data);
		 });
	};

	this.filtrarPorData = function(data,tipodespesa,fn) {

		var request = $http({
		    method: 'get',
		    url: pathBase + 'data/',
		    params: {
		        vencimento: data.toGMTString(),
		        tipoDespesa: tipodespesa
		    }
		});

		request.success(function(data) {
			fn(data);
		});
	};

});
