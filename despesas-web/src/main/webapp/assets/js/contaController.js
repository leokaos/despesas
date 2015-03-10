app.controller('contaController', function ($scope, contaService, usSpinnerService, $location, $routeParams) {

    $scope.originalData = [];

    $scope.contaSelecionado = null;

    $scope.numberPages = [5, 10, 25, 50];
    $scope.pageSize = $scope.numberPages[0];
    $scope.currentPage = 0;
    $scope.pages = 0;

    $scope.loadData = function () {

        contaService.listar(function (lista) {

            $scope.originalData = lista;

            $scope.pageSize = parseInt($scope.pageSize);
            $scope.first = $scope.pageSize * $scope.currentPage;
            $scope.sliceData = $scope.originalData.slice($scope.first, $scope.first + $scope.pageSize);
            $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);
        })
    };

    $scope.changePage = function (page) {
        $scope.currentPage = page;
        $scope.loadData();
    }

    $scope.changePageSize = function () {
        $scope.currentPage = 0;
        $scope.loadData();
    }

    $scope.nextPage = function () {
        $scope.currentPage++;
        $scope.loadData();
    }

    $scope.previousPage = function () {
        $scope.currentPage--;
        $scope.loadData();
    }

    $scope.firstPage = function () {
        $scope.currentPage = 0;
        $scope.loadData();
    }

    $scope.lastPage = function () {
        $scope.currentPage = $scope.pages - 1;
        $scope.loadData();
    }

    $scope.isLastPage = function () {
        return (($scope.currentPage + 1) == $scope.pages);
    }

    $scope.isFirstPage = function () {
        return $scope.currentPage == 0;
    }

    $scope.novo = function () {
        contaService.setConta(contaService.getNovoConta());

        $location.path('/conta');
    };

    $scope.editar = function (id) {

        contaService.buscarPorId(id, function (conta) {
            contaService.setConta(conta);

            $location.path('/conta');
        });

    };

    $scope.select = function (conta) {
        $scope.contaSelecionado = conta;
    };

    $scope.deletar = function () {

        contaService.deletar($scope.contaSelecionado.id, function (data) {

            for (var x = 0; x < $scope.originalData.length; x++) {
                var tp = $scope.originalData[x];
                if (tp.id == $scope.contaSelecionado.id) {
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

app.controller('edicaoContaController', function ($scope, contaService, $location, $routeParams) {

    $scope.conta = contaService.getConta();

    $scope.cancelar = function () {
        $location.path('/contas');
    };

    $scope.salvar = function (valid) {

        if (valid) {

            if ($scope.conta.id) {

                contaService.salvar($scope.conta, function (data) {
                    $('#modalSalvar').modal('hide');
                    $location.path('/contas');
                });

            } else {

                contaService.novo($scope.conta, function (data) {
                    $('#modalSalvar').modal('hide');
                    $location.path('/contas');
                });
            }
        }
    };
});