//PERIODO
function Periodo(mes, ano) {
    this.mes = --mes;
    this.ano = ano;
};

Periodo.prototype.getDataInicial = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes);
    dataInicial.setDate(1);

    return dataInicial;
};

Periodo.prototype.getDataFinal = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes + 1);
    dataInicial.setDate(0);

    return dataInicial;
};


app.controller('orcamentoController', function ($scope, orcamentoService, $location, usSpinnerService, MESES) {

    $scope.originalData = [];
    $scope.MESES = MESES;
    $scope.orcamentoSecionado = null;

    $scope.numberPages = [5, 10, 25, 50];
    $scope.pageSize = $scope.numberPages[0];
    $scope.currentPage = 0;
    $scope.pages = 0;

    $scope.loadData = function () {

        orcamentoService.listar(function (lista) {

            for (x = 0; x < lista.length; x++) {
                var orcamento = lista[x];
                var data = new Date(orcamento.dataInicial);
                orcamento.periodo = new Periodo(data.getMonth(), data.getFullYear());
            }

            $scope.originalData = lista;

            $scope.pageSize = parseInt($scope.pageSize);
            $scope.first = $scope.pageSize * $scope.currentPage;
            $scope.sliceData = $scope.originalData.slice($scope.first, $scope.first + $scope.pageSize);
            $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);

            usSpinnerService.stop('spin-orcamentos');
        });
    };

    $scope.changePage = function (page) {
        $scope.currentPage = page;
        $scope.loadData();
    };

    $scope.changePageSize = function () {
        $scope.currentPage = 0;
        $scope.loadData();
    };

    $scope.nextPage = function () {
        $scope.currentPage++;
        $scope.loadData();
    };

    $scope.previousPage = function () {
        $scope.currentPage--;
        $scope.loadData();
    };

    $scope.firstPage = function () {
        $scope.currentPage = 0;
        $scope.loadData();
    };

    $scope.lastPage = function () {
        $scope.currentPage = $scope.pages - 1;
        $scope.loadData();
    };

    $scope.isLastPage = function () {
        return (($scope.currentPage + 1) == $scope.pages);
    };

    $scope.isFirstPage = function () {
        return $scope.currentPage == 0;
    };

    $scope.novo = function () {
        orcamentoService.setOrcamento(orcamentoService.getNovoOrcamento());

        $location.path('/orcamento');
    };

    $scope.editar = function (id) {

        orcamentoService.buscarPorId(id, function (orcamento) {
            orcamentoService.setOrcamento(orcamento);

            $location.path('/orcamento');
        });

    };

    $scope.getValueOrcamento = function (orcamento) {
        return orcamento.valorConsolidado / orcamento.valor * 100;
    }

    $scope.select = function (orcamento) {
        $scope.orcamentoSecionado = orcamento;
    };

    $scope.deletar = function () {

        orcamentoService.deletar($scope.orcamentoSecionado.id, function (data) {

            for (var x = 0; x < $scope.originalData.length; x++) {
                var tp = $scope.originalData[x];
                if (tp.id == $scope.orcamentoSecionado.id) {
                    $scope.originalData.splice(x, 1);
                }
            }

            $('#modalExcluir').modal('hide');
            $('#modalOk').modal('show');

            $scope.loadData();

        });

    };

    $scope.loadData();


});

app.controller('edicaoOrcamentoController', function ($scope, MESES, orcamentoService, tipoDespesaService, $location, growl) {

    $scope.MESES = MESES;
    $scope.orcamento = orcamentoService.getOrcamento();
    $scope.tiposDespesa = [];
    $scope.tipoDespesaSelecionado = {
        descricao: 'Selecione'
    };

    if ($scope.orcamento.tipoDespesa != null) {
        $scope.tipoDespesaSelecionado = $scope.orcamento.tipoDespesa;
    }

    $scope.selecionarTipoDespesa = function (tipoDespesa) {
        $scope.tipoDespesaSelecionado = tipoDespesa;
        $scope.orcamento.tipoDespesa = $scope.tipoDespesaSelecionado;
    };

    tipoDespesaService.listar(function (tiposDespesa) {
        $scope.tiposDespesa = tiposDespesa;
    });

    $scope.cancelar = function () {
        $location.path('/orcamentos');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Orçamento salvo com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {

            var orcamentoTransformado = {
                id: $scope.orcamento.id,
                tipoDespesa: $scope.orcamento.tipoDespesa,
                dataInicial: $scope.orcamento.periodo.getDataInicial(),
                dataFinal: $scope.orcamento.periodo.getDataFinal(),
                valor: $scope.orcamento.valor
            };

            if ($scope.orcamento.id) {
                orcamentoService.salvar(orcamentoTransformado, $scope.salvo);
            } else {
                orcamentoService.novo(orcamentoTransformado, $scope.salvo);
            }
        }
    };

});