app.controller('despesaController', function ($scope, despesaService, $location, $routeParams, usSpinnerService) {

    var dataInicial = new Date();
    dataInicial.setDate(1);

    var dataFinal = new Date();
    dataFinal.setMonth(dataFinal.getMonth() + 1);
    dataFinal.setDate(0);

    $scope.filtro = {
        'dataInicial': dataInicial,
        'dataFinal': dataFinal
    };

    $scope.despesaSelecionada = null;

    $scope.getTitulo = function () {
        return 'Despesas';
    };

    $scope.getDescricaoSelecionado = function () {

        if ($scope.despesaSelecionada != null) {
            return $scope.despesaSelecionada.descricao;
        } else {
            return '';
        }
    };

    $scope.getMensagemDelete = function () {
        return 'Despesa deletada com sucesso!';
    };

    $scope.getNomeSpin = function () {
        return 'tipo-despesa-spin';
    };

    $scope.listar = function () {

        despesaService.buscarPorFiltro($scope.filtro, function (lista) {

            //Calculo do total
            $scope.totalTable = 0.0;

            angular.forEach($scope.originalData, function (value, key) {
                $scope.totalTable += value.valor;
            });

            $scope.loadData(lista);

        });
    };

    $scope.novo = function () {
        despesaService.setDespesa(despesaService.getNovoDespesa());

        $scope.goEdicao();
    };

    $scope.editar = function (id) {

        despesaService.buscarPorId(id, function (despesa) {
            despesaService.setDespesa(despesa);

            $scope.goEdicao();
        });
    };

    $scope.select = function (despesa) {
        $scope.despesaSelecionado = despesa;
    };

    $scope.goEdicao = function () {
        $location.path('/despesa');
    };

    $scope.getItemSelecionado = function () {
        return $scope.despesaSelecionado;
    };

    $scope.doDelete = function () {
        despesaService.deletar($scope.despesaSelecionado.id, $scope.deletar);
    };

});

app.controller('edicaodespesaController', function ($scope, despesaService, $location, $routeParams, growl) {

    $scope.tiposDespesa = [];
    $scope.debitaveis = [];
    $scope.tiposParcelamento = ['Semanal', 'Mensal', 'Semestral', 'Anual'];
    $scope.parcelar = false;
    $scope.orcamento = null;

    $scope.tipoDespesaSelecionado = {
        descricao: 'Selecione'
    };

    $scope.debitavelSelecionado = {
        descricao: 'Selecione'
    };

    $scope.despesa = despesaService.getDespesa();

    if ($scope.despesa.debitavel != null) {
        $scope.debitavelSelecionado = $scope.despesa.debitavel;
    }

    if ($scope.despesa.tipoDespesa != null) {
        $scope.tipoDespesaSelecionado = $scope.despesa.tipoDespesa;
    }

    $scope.openData = function () {
        $scope.dataPickerOpened = true;
    };

    $scope.selecionarTipoDespesa = function (tipoDespesa) {
        $scope.tipoDespesaSelecionado = tipoDespesa;
        $scope.despesa.tipoDespesa = $scope.tipoDespesaSelecionado;
    };

    $scope.selecionarDebitavel = function (debitavel) {
        $scope.debitavelSelecionado = debitavel;
        $scope.despesa.debitavel = $scope.debitavelSelecionado;
    };

    tipoDespesaService.listar(function (tiposDespesa) {
        $scope.tiposDespesa = tiposDespesa;
    });

    debitavelService.listar(function (debitaveis) {
        $scope.debitaveis = debitaveis;
    });

    $scope.hasOrcamento = function () {
        return $scope.orcamento != null;
    };

    $scope.cancelar = function () {
        $location.path('/despesas');
    };

    $scope.limparCarregar = function (data) {
        $('#modalSalvar').modal('hide');
        $scope.cancelar();
    };

    $scope.salvo = function (data) {
        $scope.limparCarregar(data);
        growl.info('despesa salva com sucesso!');
    };

    $scope.salvar = function (valid) {

        if (valid) {
            if ($scope.despesa.id) {
                despesaService.salvar($scope.despesa, $scope.salvo);
            } else {
                despesaService.novo($scope.despesa, $scope.salvo);
            }
        }
    };
});