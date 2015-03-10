app.controller('tipoDespesasController', function ($scope, tipoDespesaService, $location, $routeParams, usSpinnerService) {

    $scope.originalData = [];

    $scope.tipoDespesaSecionado = null;

    $scope.numberPages = [5, 10, 25, 50];
    $scope.pageSize = $scope.numberPages[0];
    $scope.currentPage = 0;
    $scope.pages = 0;

    $scope.loadData = function () {

        tipoDespesaService.listar(function (lista) {

            $scope.originalData = lista;

            $scope.pageSize = parseInt($scope.pageSize);
            $scope.first = $scope.pageSize * $scope.currentPage;
            $scope.sliceData = $scope.originalData.slice($scope.first, $scope.first + $scope.pageSize);
            $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);

            usSpinnerService.stop('spin-tipo-despesas');
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
        tipoDespesaService.setTipoDespesa(tipoDespesaService.getNovoTipoDespesa());

        $location.path('/tipodespesa');
    };

    $scope.editar = function (id) {

        tipoDespesaService.buscarPorId(id, function (tipoDespesa) {
            tipoDespesaService.setTipoDespesa(tipoDespesa);

            $location.path('/tipodespesa');
        });

    };

    $scope.select = function (tipoDespesa) {
        $scope.tipoDespesaSecionado = tipoDespesa;
    };

    $scope.deletar = function () {

        tipoDespesaService.deletar($scope.tipoDespesaSecionado.id, function (data) {

            for (var x = 0; x < $scope.originalData.length; x++) {
                var tp = $scope.originalData[x];
                if (tp.id == $scope.tipoDespesaSecionado.id) {
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

app.controller('edicaoTipoDespesasController', function ($scope, tipoDespesaService, $location, $routeParams, growl) {

    $scope.tipodespesa = tipoDespesaService.getTipoDespesa();

    $scope.cancelar = function () {
        $location.path('/tipodespesas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Tipo de Despesa salva com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {
            if ($scope.tipodespesa.id) {
                tipoDespesaService.salvar($scope.tipodespesa, $scope.salvo);
            } else {
                tipoDespesaService.novo($scope.tipodespesa, $scope.salvo);
            }
        }
    };
});