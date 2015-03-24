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
        return 'receitas';
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

            angular.forEach($scope.originalData, function (value, key) {
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

app.controller('edicaoReceitaController', function ($scope, receitaService, tiporeceitaService, orcamentoService, debitavelService, $location, $routeParams, growl) {

    $scope.tiposreceita = [];
    $scope.debitaveis = [];
    $scope.tiposParcelamento = ['Semanal', 'Mensal', 'Semestral', 'Anual'];
    $scope.parcelar = false;
    $scope.orcamento = null;

    $scope.tiporeceitaSelecionado = {
        descricao: 'Selecione'
    };

    $scope.debitavelSelecionado = {
        descricao: 'Selecione'
    };

    $scope.receita = receitaService.getreceita();

    if ($scope.receita.debitavel != null) {
        $scope.debitavelSelecionado = $scope.receita.debitavel;
    }

    if ($scope.receita.tiporeceita != null) {
        $scope.tiporeceitaSelecionado = $scope.receita.tiporeceita;
    }

    $scope.openData = function () {
        $scope.dataPickerOpened = true;
    };

    $scope.selecionarTiporeceita = function (tiporeceita) {
        $scope.tiporeceitaSelecionado = tiporeceita;
        $scope.receita.tiporeceita = $scope.tiporeceitaSelecionado;

        orcamentoService.filtrarPorData($scope.receita.vencimento, $scope.receita.tiporeceita.descricao, function (data) {
            $scope.orcamento = new OrcamentoVO(data);
        });

    };

    $scope.selecionarDebitavel = function (debitavel) {
        $scope.debitavelSelecionado = debitavel;
        $scope.receita.debitavel = $scope.debitavelSelecionado;
    };

    tiporeceitaService.listar(function (tiposreceita) {
        $scope.tiposreceita = tiposreceita;
    });

    debitavelService.listar(function (debitaveis) {
        $scope.debitaveis = debitaveis;
    });

    $scope.hasOrcamento = function () {
        return $scope.orcamento != null;
    };

    $scope.cancelar = function () {
        $location.path('/receitas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('receita salva com sucesso!');
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