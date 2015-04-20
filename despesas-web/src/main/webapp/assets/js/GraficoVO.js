GraficoVOFactory = function() {};

GraficoVOFactory.prototype.create = function(obj) {

	var PIZZA = 'PIZZA';
	var BARRAS = 'BARRAS';

	if (obj.tipoGrafico == PIZZA) {
		return new GraficoVOPizza(obj);
	}

	if (obj.tipoGrafico == BARRAS) {
		return new GraficoVOBarras(obj);
	}
};

// GraficoVO
GraficoVO = function(obj) {
	this.init(obj);
};

GraficoVO.prototype.init = function(obj) {
	angular.extend(this,obj);

	this.id = this.titulo.split(" ").join("_").toLowerCase();
};

GraficoVO.prototype.getColors = function() {

	var colors = [];

	for (var y = 0 ; y < this.dados.length ; y++) {
		colors.push(this.dados[y].cor);
	}

	return colors;
};

GraficoVO.prototype.getDados = function() {
	return this.dados;
};

GraficoVO.prototype.getChart = function() {
	var chart = this.getChartConfigurado();

	chart.x(function(d) {
		return d.legenda;
	});

	chart.y(function(d) {
		return d.valor;
	});

	chart.color(this.getColors());
	chart.noData("Sem Dados");
};

// GraficoVOPizza
GraficoVOPizza = function(obj) {
	this.prototype = GraficoVOPizza.prototype;
	this.init(obj);
};

GraficoVOPizza.prototype.getChartConfigurado = function() {
	return nv.models.pieChart().donut(true).labelType("percent").showLegend(false);
};

// GraficoVOBarras
GraficoVOBarras = function(obj) {
	this.prototype = GraficoVOPizza.prototype;
	this.init(obj);
};

GraficoVOBarras.prototype.getDados = function() {
	return [
		{
		    key: this.titulo,
		    values: this.dados
		}
	];
};

GraficoVOBarras.prototype.getChartConfigurado = function() {
	return nv.models.discreteBarChart();
};
