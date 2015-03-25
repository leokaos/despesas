app.controller('receitaController', function ($scope, receitaService, $location, $routeParams, usSpinnerService) {

    var dataInicial = new Date();
    dataInicial.setDate(1);

    var dataFinal = new Date();
    dataFinal.setMonth(dataFinal.getMonth() + 1);
    dataFinal.setDate(0);

    $scope.filtro = {
        'dataInicial': dataInicial,
        'dataFinal': dataFinal
    };

    $scope.receitaSelecionada = null;

    $scope.getTitulo = function () {
        return 'Receitas';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.receitaSelecionada != null) {
            return $scope.receitaSelecionada.descricao;
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Receita deletada com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-receita-spin';
    };

    $scope.listar = function () {

        receitaService.buscarPorFiltro($scope.filtro, function (lista) {

            //Calculo do total
            $scope.totalTable = 0.0;

            angular.forEach(lista, function (value, key) {
                $scope.totalTable += value.valor;
            });

            $scope.loadData(lista);

        });
    };

    $scope.novo = function () {
        receitaService.setReceita(receitaService.getNovoReceita());

        $scope.goEdicao();
    };

    $scope.editar = function (id) {

        receitaService.buscarPorId(id, function (receita) {
            receitaService.setReceita(receita);

            $scope.goEdicao();
        });
    };

    $scope.select = function (receita) {
        $scope.receitaSelecionada = receita;
    };

    $scope.goEdicao = function () {
        $location.path('/receita');
    };

    $scope.getItemSelecionado = function () {
        return $scope.receitaSelecionada;
    };

    $scope.doDelete = function () {
        receitaService.deletar($scope.receitaSelecionada.id, $scope.deletar);
    };

    $scope.hasFiltro = function () {
        return true;
    };

    $scope.getFiltro = function () {
        return 'partial/receita/filtro.html';
    };

});

app.controller('edicaoReceitaController', function ($scope, receitaService, tipoReceitaService, contaService, $location, $routeParams, growl) {

    $scope.tiposReceita = [];
    $scope.contas = [];

    $scope.tipoReceitaSelecionado = {
        descricao: 'Selecione'
    };

    $scope.contaSelecionada = {
        descricao: 'Selecione'
    };

    $scope.receita = receitaService.getReceita();

    if ($scope.receita.debitavel != null) {
        $scope.contaSelecionada = $scope.receita.debitavel;
    }

    if ($scope.receita.tipoReceita != null) {
        $scope.tipoReceitaSelecionado = $scope.receita.tipoReceita;
    }

    $scope.openData = function () {
        $scope.dataPickerOpened = true;
    };

    $scope.hasConta = function () {
        return $scope.contaSelecionada.id != null;
    };

    $scope.selecionarTipoReceita = function (tipoReceita) {
        $scope.tipoReceitaSelecionado = tipoReceita;
        $scope.receita.tipoReceita = $scope.tipoReceitaSelecionado;
    };

    $scope.selecionarConta = function (conta) {
        $scope.contaSelecionada = conta;
        $scope.receita.debitavel = $scope.contaSelecionada;
    };

    tipoReceitaService.listar(function (tiposReceita) {
        $scope.tiposReceita = tiposReceita;
    });

    contaService.listar(function (contas) {
        $scope.contas = contas;
    });

    $scope.cancelar = function () {
        $location.path('/receitas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('Receita salva com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {
            if ($scope.receita.id) {
                receitaService.salvar($scope.receita, $scope.salvo);
            } else {
                receitaService.novo($scope.receita, $scope.salvo);
            }
        }
    };
});