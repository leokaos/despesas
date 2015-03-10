<<<<<<< HEAD
var app = angular.module('despesas', ['ngRoute', 'ngAnimate', 'ngResource',
                                      'colorpicker.module', 'ui.utils.masks',
                                      'angular-growl', 'ui.bootstrap', 'mgcrea.ngStrap', 'angularSpinner']);
=======
//PERIODO
function Periodo(mes, ano) {
    this.mes = --mes;
    this.ano = ano;
};

Periodo.prototype.getDataInicial = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes);
    dataInicial.setDate(1);

    return dataInicial;
};

Periodo.prototype.getDataFinal = function () {
    var dataInicial = new Date();

    dataInicial.setFullYear(this.ano);
    dataInicial.setMonth(this.mes + 1);
    dataInicial.setDate(0);

    return dataInicial;
};


var app = angular.module('despesas', ['ngRoute', 'ngAnimate', 'ngResource', 'colorpicker.module', 'ui.utils.masks']);
>>>>>>> origin/master

app.config(function ($routeProvider, $locationProvider) {

    $routeProvider.when('/tipodespesas', {
        templateUrl: 'partial/tipodespesa/tipodespesas.html',
        controller: 'tipoDespesasController'
    });

    $routeProvider.when('/tipodespesa', {
        templateUrl: 'partial/tipodespesa/tipodespesa.html',
        controller: 'edicaoTipoDespesasController'
    });

    $routeProvider.when('/tiporeceitas', {
        templateUrl: 'partial/tiporeceita/tiporeceitas.html',
        controller: 'tipoReceitaController'
    });

    $routeProvider.when('/tiporeceita', {
        templateUrl: 'partial/tiporeceita/tiporeceita.html',
        controller: 'edicaoTipoReceitaController'
    });

    $routeProvider.when('/contas', {
        templateUrl: 'partial/conta/contas.html',
        controller: 'contaController'
    });

    $routeProvider.when('/conta', {
        templateUrl: 'partial/conta/conta.html',
        controller: 'edicaoContaController'
    });

    $routeProvider.when('/despesas', {
        templateUrl: 'partial/despesa/despesas.html',
        controller: 'despesasController'
    });

    $routeProvider.when('/despesa', {
        templateUrl: 'partial/despesa/despesa.html',
        controller: 'edicaoDespesaController'
    });

    $routeProvider.when('/cartoes', {
        templateUrl: 'partial/cartao/cartoes.html',
        controller: 'cartaoController'
    });

    $routeProvider.when('/cartao', {
        templateUrl: 'partial/cartao/cartao.html',
        controller: 'edicaoCartaoController'
    });

    $routeProvider.when('/pagamentos', {
        templateUrl: 'partial/pagamentos.html',
        controller: 'pagamentosController'
    });

    $routeProvider.otherwise({
        templateUrl: 'partial/dashboard.html',
        controller: 'dashboardController'
    });

});

app.config(function (growlProvider) {
    growlProvider.globalTimeToLive(-1);
});

app.filter('range', function () {

    return function (input, total) {
        total = parseInt(total);
        for (var i = 0; i < total; i++) {
            input.push(i);
        }
        return input;
    };
});

app.directive('ngModal', function () {
    return {
        restrict: 'E',
        replace: true,
        transclude: true,
        templateUrl: 'partial/modal.html',

        compile: function (element, attrs, transclude) {

            var type = 'OK';

            if ('SAVE' == attrs.type) {
                type = 'SAVE';
            }

            if ('SAVE' == type) {
                element.find("div[despesas-modal-footer-ok='']").attr('ng-if', 'false');

                if (angular.isDefined(attrs.funcSalvar)) {
                    element.find("button[despesas-modal-salvar='']").attr('ng-click', attrs.funcSalvar);
                }

                if (angular.isDefined(attrs.labelSalvar)) {
                    element.find("button[despesas-modal-salvar='']").html(attrs.labelSalvar);
                }

                if (angular.isDefined(attrs.funcCancelar)) {
                    element.find("button[despesas-modal-cancelar='']").attr('ng-click', attrs.funcCancelar);
                }

            } else {

                element.find("div[despesas-modal-footer-save='']").attr('ng-if', 'false');

                if (angular.isDefined(attrs.funcOk)) {
                    element.find("button[despesas-modal-ok='']").attr('ng-click', attrs.funcOk);
                }
            }

            element.attr('id', attrs.id);

            if (angular.isDefined(attrs.modalTitle)) {
                element.find("h4[despesas-modal-title='']").html(attrs.modalTitle);
            }
        }
    };

});

app.directive('startupError', function ($compile) {

    return {
        restrict: 'E',
        replace: true,
        transclude: true,
        scope: false,
        priority: 1000,
        template: "<div ng-transclude></div>",

        link: function (scope, iElement, iAttrs) {

            var classes = 'col-sm-10';

            if (angular.isDefined(iAttrs.class)) {
                classes += ' ' + iAttrs.class;
            }

            iElement.attr('class', classes)

            var campo = iElement.find("input[startup-error-field]");

            /*$(campo).attr('bs-tooltip', '');
            $(campo).attr('data-placement', 'top');
            $(campo).attr('data-trigger', 'focus');
            $(campo).attr('data-title', iAttrs.tooltipMessage);
            */

            iElement.append("<span startup-error-message></span>");

            var mensagem = iElement.find("span[startup-error-message]");

            $(mensagem).html(iAttrs.errorMessage);
            $(mensagem).attr('class', 'alert alert-danger');
            $(mensagem).attr('style', 'margin: 10px 0px 0px 0px; padding: 3px; display: inline-block;');
            $(mensagem).attr('ng-show', iAttrs.formName + '.' + campo.attr('name') + '.$invalid && ' + iAttrs.formName + '.' + campo.attr('name') + '.$dirty');
            $(mensagem).attr('ng-class', 'error');

            $compile(iElement.contents())(scope);
        }

    };

});


app.directive('uiCalendar', function () {

    return {
        restrict: 'A',
        scope: {
            eventSources: '=ngModel',
            functionSelect: '=functionSelect'
        },
        link: function (scope, iElement, iAttrs) {

            var diasSemana = ["domingo", "segunda-feira", "ter\u00e7a-feira", "quarta-feira", "quinta-feira", "sexta-feira", "s\u00e1bado"];
            var meses = ["Janeiro", "Fevereiro", "Mar\u00e7o", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];
            var diasSemanaCurtos = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "S\u00e1b"];
            var textoDosBotoes = {
                today: 'Hoje',
                month: 'Mês',
                week: 'Semana',
                day: 'Dia'
            };

            var select = function (event, jsEvent, view) {
                var eventoSelecionado = null;

                if (event != null && event.despesa != null) {
                    scope.functionSelect(event.despesa);
                }
            };

            var id = '#' + iElement.attr('id');

            $(id).fullCalendar({
                height: 700,
                aspectRatio: 10,
                events: scope.eventSources,
                monthNames: meses,
                dayNames: diasSemana,
                dayNamesShort: diasSemanaCurtos,
                buttonText: textoDosBotoes,
                eventClick: select
            });

            $(id).fullCalendar('refetchEvents');
        }
    };
});
