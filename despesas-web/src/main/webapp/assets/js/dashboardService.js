app.service('dashboardService', function ($http) {

    var despesa = null;
    var pathBase = '/despesas/services/dashbboard/';

    this.buscarDespesasPorPeriodo = function (dataInicio, dataFim, fn) {

        var request = $http({
            method: 'get',
            url: pathBase + 'main',
            params: {
                dataInicial: dataInicio.toGMTString(),
                dataFinal: dataFim.toGMTString()
            }
        });

        request.success(function (data) {
            fn(data);
        });
    };
});

// GRAFICO VO
function GraficoVO(obj) {
    angular.extend(this, obj);

    this.id = this.titulo.split(" ").join("_").toLowerCase();
};

GraficoVO.prototype.getColors = function () {

    var colors = [];

    for (var y = 0; y < this.dados.length; y++) {
        colors.push(this.dados[y].cor);
    }

    return colors;
};

GraficoVO.prototype.isBarra = function () {
    return 'BARRAS' == this.tipoGrafico;
};

GraficoVO.prototype.isPizza = function () {
    return 'PIZZA' == this.tipoGrafico;
};