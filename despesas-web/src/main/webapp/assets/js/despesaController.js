app.controller('despesasController', function ($scope, despesaService, $location, $routeParams, usSpinnerService) {

    $scope.originalData = [];

    var dataInicial = new Date();
    dataInicial.setDate(1);

    var dataFinal = new Date();
    dataFinal.setMonth(dataFinal.getMonth() + 1);
    dataFinal.setDate(0);

    $scope.filtro = {
        'dataInicial': dataInicial,
        'dataFinal': dataFinal
    };

    $scope.despesaSecionada = null;

    $scope.numberPages = [5, 10, 25, 50];
    $scope.pageSize = $scope.numberPages[0];
    $scope.currentPage = 0;
    $scope.pages = 0;

    $scope.loadData = function () {

        despesaService.buscarPorFiltro($scope.filtro, function (lista) {

            $scope.originalData = lista;

            $scope.pageSize = parseInt($scope.pageSize);
            $scope.first = $scope.pageSize * $scope.currentPage;
            $scope.sliceData = $scope.originalData.slice($scope.first, $scope.first + $scope.pageSize);
            $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);

            //Calculo do total
            $scope.totalTable = 0.0;

            angular.forEach($scope.originalData, function (value, key) {
                $scope.totalTable += value.valor;
            });

            usSpinnerService.stop('spin-despesas');
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
        despesaService.setDespesa(despesaService.getNovoDespesa());

        $location.path('/despesa');
    };

    $scope.editar = function (id) {

        despesaService.buscarPorId(id, function (despesa) {
            despesaService.setDespesa(despesa);

            $location.path('/despesa');
        });

    };

    $scope.select = function (despesa) {
        $scope.despesaSecionada = despesa;
    };

    $scope.deletar = function () {

        despesaService.deletar($scope.despesaSecionada.id, function (data) {

            for (var x = 0; x < $scope.originalData.length; x++) {
                var tp = $scope.originalData[x];
                if (tp.id == $scope.despesaSecionada.id) {
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

app.controller('edicaoDespesaController', function ($scope, $http, debitavelService, tipoDespesaService, despesaService, $location, $routeParams) {

    $scope.tiposDespesa = [];
    $scope.debitaveis = [];
    $scope.tiposParcelamento = ['Semanal', 'Mensal', 'Semestral', 'Anual'];
    $scope.parcelar = false;

    $scope.tipoDespesaSelecionado = {
        descricao: 'Selecione'
    };

    $scope.debitavelSelecionado = {
        descricao: 'Selecione'
    };

    $scope.despesa = despesaService.getDespesa();

    if ($scope.despesa.debitavel != null) {
        $scope.debitavelSelecionado = $scope.despesa.debitavel;
    }

    if ($scope.despesa.tipoDespesa != null) {
        $scope.tipoDespesaSelecionado = $scope.despesa.tipoDespesa;
    }

    $scope.openData = function () {
        $scope.dataPickerOpened = true;
    };

    $scope.selecionarTipoDespesa = function (tipoDespesa) {
        $scope.tipoDespesaSelecionado = tipoDespesa;
        $scope.despesa.tipoDespesa = $scope.tipoDespesaSelecionado;
    };

    $scope.selecionarDebitavel = function (debitavel) {
        $scope.debitavelSelecionado = debitavel;
        $scope.despesa.debitavel = $scope.debitavelSelecionado;
    };

    tipoDespesaService.listar(function (tiposDespesa) {
        $scope.tiposDespesa = tiposDespesa;
    });

    debitavelService.listar(function (debitaveis) {
        $scope.debitaveis = debitaveis;
    });

    $scope.salvar = function () {
        if ($scope.despesa.id) {
            despesaService.salvar($scope.despesa, $scope.complete);
        } else {
            despesaService.novo($scope.despesa, $scope.complete);
        }
    };

    $scope.complete = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.voltar();
    };

    $scope.voltar = function () {
        $location.path('/despesas');
    };
});