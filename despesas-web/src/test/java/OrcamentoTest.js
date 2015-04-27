describe('OrcamentoVO Test ',function() {

	var objOriginal = {
	    id: 10,
	    valorConsolidado: 50,
	    valor: 100,
	    dataInicial: new Date(2015,0,1,0,0,0),
	    tipoDespesa: {
		    descricao: 'Tipo Despesa'
	    }
	};

	var orcamentoVO = null;

	beforeEach(function() {
		orcamentoVO = new OrcamentoVO(objOriginal);
	});

	it('Deveria retornar null',function() {
		var vo = new OrcamentoVO({});

		expect(vo.valorConsolidado).toEqual(0);
		expect(vo.periodo.ano).toEqual(null);
		expect(vo.periodo.mes).toEqual(null);

		expect(vo.getValueOrcamento()).toEqual(0);
	});

	it('Deveria retornar 50',function() {
		expect(orcamentoVO.getValueOrcamento()).toEqual(50);
	});

	it('Deveria retornar success',function() {
		orcamentoVO.valorConsolidado = 50;
		expect(orcamentoVO.getClassProgressBar()).toEqual('success');
	});

	it('Deveria retornar warning',function() {
		orcamentoVO.valorConsolidado = 72;
		expect(orcamentoVO.getClassProgressBar()).toEqual('warning');
	});

	it('Deveria retornar danger',function() {
		orcamentoVO.valorConsolidado = 90;
		expect(orcamentoVO.getClassProgressBar()).toEqual('danger');
	});

	it('Deveria retornar Orçamento de janeiro de 2015 para Tipo Despesa',function() {
		expect(orcamentoVO.toString()).toEqual('Orçamento de janeiro de 2015 para Tipo Despesa');
	});

	it('Deveria retornar Orçamento de janeiro de 2015 para ',function() {
		orcamentoVO.tipoDespesa = null;
		expect(orcamentoVO.toString()).toEqual('Orçamento de janeiro de 2015 para ');
	});

	it('Deveria retornar um JSON correto',function() {
		var json = {
		    id: 10,
		    tipoDespesa: {
			    descricao: 'Tipo Despesa'
		    },
		    dataInicial: new Date(2015,0,1,0,0,0,0),
		    dataFinal: new Date(2015,0,31,23,59,59,999),
		    valor: 100
		};

		expect(orcamentoVO.toOrcamento()).toEqual(json);
	});

});
