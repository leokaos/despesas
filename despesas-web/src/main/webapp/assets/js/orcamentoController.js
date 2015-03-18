app.controller('orcamentoController', function ($scope, orcamentoService, $location, $routeParams, usSpinnerService, MESES) {

    $scope.MESES = MESES;
    $scope.orcamentoSelecionado = null;

    $scope.getTitulo = function () {
        return 'Orçamentos';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.orcamentoSelecionado != null) {
            return $scope.orcamentoSelecionado.toString();
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Orcamento deletado com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-orcamento-spin';
    };

    $scope.listar = function () {

        orcamentoService.listar(function (data) {

            for (x = 0; x < data.length; x++) {
                data[x] = new OrcamentoVO(data[x]);
            }

            $scope.loadData(data);
        });
    };

    $scope.novo = function () {
        orcamentoService.setOrcamento(orcamentoService.getNovoOrcamento());

        $scope.goEdicao();
    };

    $scope.editar = function (id) {

        orcamentoService.buscarPorId(id, function (orcamento) {
            orcamentoService.setOrcamento(orcamento);

            $scope.goEdicao();
        });
    };

    $scope.select = function (orcamento) {
        $scope.orcamentoSelecionado = orcamento;
    };

    $scope.goEdicao = function () {
        $location.path('/orcamento');
    };

    $scope.getItemSelecionado = function () {
        return $scope.orcamentoSelecionado;
    };

    $scope.doDelete = function () {
        orcamentoService.deletar($scope.orcamentoSelecionado.id, $scope.deletar);
    };

});

app.controller('edicaoOrcamentoController', function ($scope, orcamentoService, tipoDespesaService, $location, $routeParams, growl, MESES) {

    $scope.MESES = MESES;
    $scope.orcamentoVO = new OrcamentoVO(orcamentoService.getOrcamento());
    $scope.tiposDespesa = [];

    $scope.tipoDespesaSelecionado = {
        descricao: 'Selecione'
    };

    if ($scope.orcamentoVO.tipoDespesa !== null) {
        $scope.tipoDespesaSelecionado = $scope.orcamentoVO.tipoDespesa;
    }

    $scope.selecionarTipoDespesa = function (tipoDespesa) {
        $scope.tipoDespesaSelecionado = tipoDespesa;
        $scope.orcamentoVO.tipoDespesa = $scope.tipoDespesaSelecionado;
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
        growl.info('Orçamento salva com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {

            if ($scope.orcamentoVO.id) {
                orcamentoService.salvar($scope.orcamentoVO.toOrcamento(), $scope.salvo);
            } else {
                orcamentoService.novo($scope.orcamentoVO.toOrcamento(), $scope.salvo);
            }
        }
    };
});