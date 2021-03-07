app.service('despesaService', function($http, filtroParser) {

	pathBaseDespesa = '/despesas/services/despesa/';

	this.getNovoDespesa = function() {
		return {
			descricao : '',
			vencimento : null,
			valor : null,
			tipo : null,
			debitavel : null,
			paga : false
		};
	};

	this.listar = function(filtro, fn) {

		$http.get(pathBaseDespesa, {
			params : filtroParser.getFiltro(filtro)
		}).success(function(data) {
			fn(data);
		});
	};

	this.novo = function(despesa, parcelamento, fn) {
		
		despesa.moeda = despesa.debitavel.moeda;

		var dados = {
			"despesa" : despesa,
			"parcelamentoVO" : parcelamento
		};

		var request = $http({
			method : 'post',
			url : pathBaseDespesa,
			data : dados
		});

		request.success(function(data) {
			fn(data);
		});
	};

	this.salvar = function(despesa, parcelamento, fn) {
		$http.put(pathBaseDespesa, despesa).success(function(data) {
			fn(data);
		});
	};

	this.setDespesa = function(novoDespesa) {
		this.despesa = novoDespesa;
	};

	this.getDespesa = function() {
		return this.despesa;
	};

	this.buscarPorId = function(id, fn) {
		$http.get(pathBaseDespesa + id).success(function(data) {
			fn(data);
		});
	};

	this.buscarDespesasPorTipo = function(dataInicio, dataFim, fn) {

		var request = $http({
			method : 'get',
			url : pathBaseDespesa + 'grafico',
			params : {
				dataInicial : dataInicio.toGMTString(),
				dataFinal : dataFim.toGMTString()
			}
		});

		request.success(function(data) {
			fn(data);
		});

	};

	this.buscarDespesasPorPeriodo = function(dataInicio, dataFim, fn) {

		var request = $http({
			method : 'get',
			url : pathBaseDespesa + 'periodo',
			params : {
				dataInicial : dataInicio.toGMTString(),
				dataFinal : dataFim.toGMTString()
			}
		});

		request.success(function(data) {
			fn(data);
		});

	};

	this.pagarDespesa = function(despesa, fn) {
		$http.post(pathBaseDespesa + 'pagar', despesa.id).success(function(data) {
			fn(data);
		});
	};

	this.deletar = function(id, fn) {
		$http['delete'](pathBaseDespesa + id).success(function(data) {
			fn(data);
		});
	};

});