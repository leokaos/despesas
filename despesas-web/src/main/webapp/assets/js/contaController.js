app.controller('contaController', function ($scope, contaService, $location, $routeParams, usSpinnerService) {

    $scope.contaSelecionado = null;

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
        contaService.setConta(contaService.getNovoConta());

        $scope.goEdicao();
    };

    $scope.editar = function (id) {

        contaService.buscarPorId(id, function (conta) {
            contaService.setConta(conta);

            $scope.goEdicao();
        });
    };

    $scope.select = function (conta) {
        $scope.contaSelecionado = conta;
    };

    $scope.goEdicao = function () {
        $location.path('/conta');
    };

    $scope.getItemSelecionado = function () {
        return $scope.contaSelecionado;
    };

    $scope.doDelete = function () {
        contaService.deletar($scope.contaSelecionado.id, $scope.deletar);
    };

});

app.controller('edicaoContaController', function ($scope, contaService, $location, $routeParams, growl) {

    $scope.conta = contaService.getConta();

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