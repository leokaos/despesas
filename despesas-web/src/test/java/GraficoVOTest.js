describe('GraficoVO Test ',function() {

	var obj1 = {
	    tipoGrafico: 'PIZZA',
	    titulo: 'TESTE TITULO',
	    dados: [
	            {
	                legenda: 'leo',
	                valor: 10
	            },
	            {
	                legenda: 'leo2',
	                valor: 20
	            }
	    ]
	};

	var obj2 = {
	    tipoGrafico: 'BARRAS',
	    titulo: 'TESTE TITULO2',
	    dados: [
	            {
	                legenda: 'leo',
	                valor: 10
	            },
	            {
	                legenda: 'leo2',
	                valor: 20
	            }
	    ]
	};

	it('Deveria retornar um titulo igual a teste_titulo',function() {
		var grafico = GraficoVOFactory.create(obj1);

		expect(grafico.id).toEqual('teste_titulo');
		expect(grafico.getChartConfigurado()).not.toBe(null);
	});

	it('Deveria retornar um conjunto de dados igual ao do obj original',function() {
		var grafico = GraficoVOFactory.create(obj1);

		expect(grafico.getDados()).toEqual(obj1.dados);
	});

	it('Deveria retornar um titulo igual a teste_titulo',function() {
		var grafico = GraficoVOFactory.create(obj2);

		expect(grafico.id).toEqual('teste_titulo2');
		expect(grafico.getChartConfigurado()).not.toBe(null);
	});

	it('Deveria retornar um conjunto de dados igual ao do obj original',function() {
		var grafico = GraficoVOFactory.create(obj2);

		var dadosMod = [
			{
			    key: 'TESTE TITULO2',
			    values: obj2.dados
			}
		];

		expect(grafico.getDados()).toEqual(dadosMod);
	});

});
