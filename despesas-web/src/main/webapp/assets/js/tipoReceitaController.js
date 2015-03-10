app.controller('tipoReceitaController', function ($scope, tipoReceitaService, $location, $routeParams, usSpinnerService) {

    $scope.originalData = [];

    $scope.tipoReceitaSelecionado = null;

    $scope.numberPages = [5, 10, 25, 50];
    $scope.pageSize = $scope.numberPages[0];
    $scope.currentPage = 0;
    $scope.pages = 0;

    $scope.loadData = function () {

        tipoReceitaService.listar(function (lista) {

            $scope.originalData = lista;

            $scope.pageSize = parseInt($scope.pageSize);
            $scope.first = $scope.pageSize * $scope.currentPage;
            $scope.sliceData = $scope.originalData.slice($scope.first, $scope.first + $scope.pageSize);
            $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);

            usSpinnerService.stop('spin-tipo-receitas');
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
        tipoReceitaService.setTipoReceita(tipoReceitaService.getNovoTipoReceita());

        $location.path('/tiporeceita');
    };

    $scope.editar = function (id) {

        tipoReceitaService.buscarPorId(id, function (tipoReceita) {
            tipoReceitaService.setTipoReceita(tipoReceita);

            $location.path('/tiporeceita');
        });

    };

    $scope.select = function (tipoReceita) {
        $scope.tipoReceitaSelecionado = tipoReceita;
    };

    $scope.deletar = function () {

        tipoReceitaService.deletar($scope.tipoReceitaSelecionado.id, function (data) {

            for (var x = 0; x < $scope.originalData.length; x++) {
                var tp = $scope.originalData[x];
                if (tp.id == $scope.tipoReceitaSelecionado.id) {
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

app.controller('edicaoTipoReceitaController', function ($scope, tipoReceitaService, $location, $routeParams, growl) {

    $scope.tiporeceita = tipoReceitaService.getTipoReceita();

    $scope.cancelar = function () {
        $location.path('/tiporeceitas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Tipo de Receita salvo com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {
            if ($scope.tiporeceita.id) {
                tipoReceitaService.salvar($scope.tiporeceita, $scope.salvo);
            } else {
                tipoReceitaService.novo($scope.tiporeceita, $scope.salvo);
            }
        }
    };
});