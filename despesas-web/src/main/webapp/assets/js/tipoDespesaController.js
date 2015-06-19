app.controller('tipoDespesaController', function ($scope, tipoDespesaService, $location, usSpinnerService) {

    $scope.tipoDespesaSelecionado = null;

    $scope.getTitulo = function () {
        return 'Tipo de Despesa';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.tipoDespesaSelecionado != null) {
            return $scope.tipoDespesaSelecionado.descricao;
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Tipo de Despesa deletado com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-despesa-spin';
    };

    $scope.listar = function () {
        tipoDespesaService.listar($scope.loadData);
    };

    $scope.novo = function () {
        $location.path('/tipodespesa');
    };

    $scope.editar = function (id) {
        $location.path('/tipodespesa/' + id);
    };

    $scope.select = function (tipoDespesa) {
        $scope.tipoDespesaSelecionado = tipoDespesa;
    };

    $scope.getItemSelecionado = function () {
        return $scope.tipoDespesaSelecionado;
    };

    $scope.doDelete = function () {
        tipoDespesaService.deletar($scope.tipoDespesaSelecionado.id, $scope.deletar);
    };

});

app.controller('edicaoTipoDespesaController', function ($scope, tipoDespesaService, $location, $routeParams, growl) {

    var id = $routeParams.id;

    if (id != null) {
        tipoDespesaService.buscarPorId(id, function (tipodespesa) {
            $scope.tipodespesa = tipodespesa;
        });
    } else {
        $scope.tipodespesa = tipoDespesaService.getNovoTipoDespesa();
    }

    $scope.cancelar = function () {
        $location.path('/tipodespesas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Tipo de Despesa salvo com sucesso!');
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