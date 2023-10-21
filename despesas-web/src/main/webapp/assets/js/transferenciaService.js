app.service('transferenciaService', function($http, filtroParser) {

	var pathBase = 'http://localhost:8080/despesas/services/transferencia/';

	this.getNovaTransferencia = function() {
		return {
			descricao: '',
			vencimento: null,
			valor: null,
			debitavel: null,
			creditavel: null,
			moeda: null
		};
	};

	this.listar = function(filtro, fn) {

		$http.get(pathBase, {
			params: filtroParser.getFiltro(filtro)
		}).success(function(data) {
			fn(data);
		});
	};

	this.novo = function(transferencia, fn) {
		$http.post(pathBase, transferencia).success(function(data) {
			fn(data);
		});
	};

	this.salvar = function(transferencia, fn) {
		$http.put(pathBase, transferencia).success(function(data) {
			fn(data);
		});
	};

	this.setTipoDespesa = function(novoTipoDespesa) {
		this.tipodespesa = novoTipoDespesa;
	}

	this.getTransferencia = function() {
		return this.transferencia;
	}

	this.buscarPorId = function(id, fn) {
		$http.get(pathBase + id).success(function(data) {
			fn(data);
		});
	};

	this.deletar = function(id, fn) {
		$http.delete(pathBase + id).success(function(data) {
			fn(data);
		});
	};
});