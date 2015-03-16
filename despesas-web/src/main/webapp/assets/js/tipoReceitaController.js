app.controller('tipoReceitaController', function ($scope, tipoReceitaService, $location, $routeParams, usSpinnerService) {

    $scope.tipoReceitaSelecionado = null;

    $scope.getTitulo = function () {
        return 'Tipo de Receita';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.tipoReceitaSelecionado != null) {
            return $scope.tipoReceitaSelecionado.descricao;
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Tipo de receita deletado com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-receita-spin';
    };

    $scope.listar = function () {
        tipoReceitaService.listar($scope.loadData);
    };

    $scope.novo = function () {
        tipoReceitaService.setTipoReceita(tipoReceitaService.getNovoTipoReceita());

        $scope.goEdicao();
    };

    $scope.editar = function (id) {

        tipoReceitaService.buscarPorId(id, function (tipoReceita) {
            tipoReceitaService.setTipoReceita(tipoReceita);

            $scope.goEdicao();
        });
    };

    $scope.select = function (tipoReceita) {
        $scope.tipoReceitaSelecionado = tipoReceita;
    };

    $scope.goEdicao = function () {
        $location.path('/tiporeceita');
    };

    $scope.getItemSelecionado = function () {
        return $scope.tipoReceitaSelecionado;
    };

    $scope.doDelete = function () {
        tipoReceitaService.deletar($scope.tipoReceitaSelecionado.id, $scope.deletar);
    };

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