var app = angular.module('despesas', ['ngRoute', 'ngAnimate', 'ngResource', 'ui.utils.masks', 'colorpicker.module', 'mgcrea.ngStrap', 'ui.bootstrap']);

app.config(function ($routeProvider, $locationProvider) {

    $routeProvider.when('/tipodespesas', {
        templateUrl: 'partial/tipodespesa/tipodespesas.html',
        controller: 'tipoDespesasController'
    });

    $routeProvider.when('/tipodespesa', {
        templateUrl: 'partial/tipodespesa/tipodespesa.html',
        controller: 'edicaoTipoDespesasController'
    });

    $routeProvider.when('/contas', {
        templateUrl: 'partial/conta/contas.html',
        controller: 'contaController'
    });

    $routeProvider.when('/conta', {
        templateUrl: 'partial/conta/conta.html',
        controller: 'edicaoContaController'
    });

    $routeProvider.when('/despesa', {
        templateUrl: 'partial/despesa/despesa.html',
        controller: 'edicaoDespesaController'
    });

    $routeProvider.otherwise({
        templateUrl: 'partial/dashboard.html',
        controller: 'dashboardController'
    });

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

            $(campo).attr('bs-tooltip', '');
            $(campo).attr('data-placement', 'top');
            $(campo).attr('data-trigger', 'focus');
            $(campo).attr('data-title', iAttrs.tooltipMessage);

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