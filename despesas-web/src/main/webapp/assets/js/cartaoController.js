app.controller('cartaoController', function ($scope, cartaoService, usSpinnerService, $location, $routeParams) {

    $scope.originalData = [];

    $scope.cartaoSelecionado = null;

    $scope.numberPages = [5, 10, 25, 50];
    $scope.pageSize = $scope.numberPages[0];
    $scope.currentPage = 0;
    $scope.pages = 0;

    $scope.loadData = function () {

        cartaoService.listar(function (lista) {

            $scope.originalData = lista;

            $scope.pageSize = parseInt($scope.pageSize);
            $scope.first = $scope.pageSize * $scope.currentPage;
            $scope.sliceData = $scope.originalData.slice($scope.first, $scope.first + $scope.pageSize);
            $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);

            usSpinnerService.stop('spin-cartoes');
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
        cartaoService.setCartao(cartaoService.getNovoCartao());

        $location.path('/cartao');
    };

    $scope.editar = function (id) {

        cartaoService.buscarPorId(id, function (cartao) {
            cartaoService.setCartao(cartao);

            $location.path('/cartao');
        });

    };

    $scope.select = function (cartao) {
        $scope.cartaoSelecionado = cartao;
    };

    $scope.deletar = function () {

        cartaoService.deletar($scope.cartaoSelecionado.id, function (data) {

            for (var x = 0; x < $scope.originalData.length; x++) {
                var tp = $scope.originalData[x];
                if (tp.id == $scope.cartaoSelecionado.id) {
                    $scope.originalData.splice(x, 1);
                }
            }

            $('#modalExcluir').modal('hide');
            $('#modalOk').modal('show');

            $scope.loadData();

        });

    };

    $scope.loadData();
    
    $scope.bandeiras = {
        'VISA': 'fa fa-cc-visa',
        'MASTERCARD': 'fa fa-cc-mastercard',
        'AMERICAN_EXPRESS': 'fa fa-cc-ame'
    };

});

app.controller('edicaoCartaoController', function ($scope, cartaoService, $location, $routeParams) {

    $scope.bandeiras = ['VISA', 'MASTERCARD', 'AMERICAN EXPRESS'];

    $scope.cartao = cartaoService.getCartao();

    var irPaginaPesquisa = function () {
        $location.path('/cartoes');
    };

    var esconderModalSalvar = function () {
        $('#modalSalvar').modal('hide');
    };

    $scope.cancelar = function () {
        irPaginaPesquisa();
    };

    $scope.completeSalvar = function (data) {
        esconderModalSalvar();
        irPaginaPesquisa();
    };

    $scope.salvar = function (valid) {
        if (valid) {
            if ($scope.cartao.id) {
                cartaoService.salvar($scope.cartao, $scope.completeSalvar);
            } else {
                cartaoService.novo($scope.cartao, $scope.completeSalvar);
            }
        }
    };

});