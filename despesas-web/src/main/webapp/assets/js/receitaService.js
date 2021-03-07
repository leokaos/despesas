app.service('receitaService', function($http, filtroParser) {

	pathBaseReceita = '/despesas/services/receita/';

	this.getNovoReceita = function() {
		return {
			descricao : '',
			vencimento : null,
			valor : null,
			debitavel : null,
			depositado : false,
			moeda : null
		};
	};

	this.listar = function(filtro, fn) {

		$http.get(pathBaseReceita, {
			params : filtroParser.getFiltro(filtro)
		}).success(function(data) {
			fn(data);
		});
	};

	this.novo = function(receita, fn) {
		
		receita.moeda = receita.debitavel.moeda;
		
		$http.post(pathBaseReceita, receita).success(function(data) {
			fn(data);
		});
	};

	this.salvar = function(receita, fn) {
		$http.put(pathBaseReceita, receita).success(function(data) {
			fn(data);
		});
	};

	this.setReceita = function(novoReceita) {
		this.receita = novoReceita;
	};

	this.getReceita = function() {
		return this.receita;
	};

	this.buscarPorId = function(id, fn) {
		$http.get(pathBaseReceita + id).success(function(data) {
			fn(data);
		});
	};

	this.deletar = function(id, fn) {
		$http['delete'](pathBaseReceita + id).success(function(data) {
			fn(data);
		});
	};

	this.buscarReceitasPorTipo = function(dataInicio, dataFim, fn) {

		var request = $http({
			method : 'get',
			url : pathBaseReceita + 'grafico',
			params : {
				dataInicial : dataInicio.toGMTString(),
				dataFinal : dataFim.toGMTString()
			}
		});

		request.success(function(data) {
			fn(data);
		});

	};

	this.depositarReceita = function(receita, fn) {
		$http.post(pathBaseReceita + 'pagar', receita.id).success(function(data) {
			fn(data);
		});
	};

});