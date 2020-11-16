app.service('metaService', function($http, filtroParser) {

	pathBaseMeta = '/despesas/services/meta/';

	this.getNovaMeta = function() {
		return {
			"valor" : null,
			"mes" : {
				"mes" : new Date().getMonth() + 1,
				"ano" : new Date().getYear() + 1900
			}
		}
	};

	this.listar = function(filtro, fn) {

		$http.get(pathBaseMeta, {
			params : filtroParser.getFiltro(filtro)
		}).success(function(data) {
			fn(data);
		});
	};

	this.novo = function(meta, fn) {

		var request = $http({
			method : 'post',
			url : pathBaseMeta,
			data : meta
		});

		request.success(function(data) {
			fn(data);
		});
	};

	this.salvar = function(meta, fn) {
		$http.put(pathBaseMeta, meta).success(function(data) {
			fn(data);
		});
	};

	this.setMeta = function(novaMeta) {
		this.meta = novaMeta;
	};

	this.getMeta = function() {
		return this.meta;
	};

	this.buscarPorId = function(id, fn) {
		$http.get(pathBaseMeta + id).success(function(data) {
			fn(data);
		});
	};

	this.deletar = function(id, fn) {
		$http['delete'](pathBaseMeta + id).success(function(data) {
			fn(data);
		});
	};

});