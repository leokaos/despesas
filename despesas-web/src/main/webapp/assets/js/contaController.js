app.controller('contaController', function ($scope, contaService, $location, $routeParams, usSpinnerService, MOEDAS) {

    $scope.contaSelecionado = null;
    $scope.MOEDAS = MOEDAS;

    $scope.getTitulo = function () {
        return 'Conta de Despesa';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.contaSelecionado != null) {
            return $scope.contaSelecionado.descricao;
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Conta deletada com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-conta-spin';
    };

    $scope.listar = function () {
        contaService.listar($scope.loadData);
    };

    $scope.novo = function () {
        $location.path('/conta');
    };

    $scope.editar = function (id) {
        $location.path('/conta/' + id);
    };

    $scope.select = function (conta) {
        $scope.contaSelecionado = conta;
    };

    $scope.getItemSelecionado = function () {
        return $scope.contaSelecionado;
    };

    $scope.doDelete = function () {
        contaService.deletar($scope.contaSelecionado.id, $scope.deletar);
    };

});

app.controller('edicaoContaController', function ($scope, contaService, $location, $routeParams, growl) {

    var id = $routeParams.id;

    if (id != null) {
        contaService.buscarPorId(id, function (conta) {
            $scope.conta = conta;
        });
    } else {
        $scope.conta = contaService.getNovoConta();
    }

    $scope.cancelar = function () {
        $location.path('/contas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Conta salva com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {
            if ($scope.conta.id) {
                contaService.salvar($scope.conta, $scope.salvo);
            } else {
                contaService.novo($scope.conta, $scope.salvo);
            }
        }
    };
});