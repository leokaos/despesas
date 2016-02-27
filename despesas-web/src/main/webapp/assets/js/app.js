var app = angular.module('despesas', [ 'ngRoute', 'ngAnimate', 'ngResource', 'colorpicker.module', 'ui.utils.masks', 'angular-growl', 'ui.bootstrap',
		'mgcrea.ngStrap', 'angularSpinner', 'slick' ]);
app.constant('MESES', [ {
	nome : 'Janeiro',
	value : 1
}, {
	nome : 'Fevereiro',
	value : 2
}, {
	nome : 'Mar\u00e7o',
	value : 3
}, {
	nome : 'Abril',
	value : 4
}, {
	nome : 'Maio',
	value : 5
}, {
	nome : 'Junho',
	value : 6
}, {
	nome : 'Julho',
	value : 7
}, {
	nome : 'Agosto',
	value : 8
}, {
	nome : 'Setembro',
	value : 9
}, {
	nome : 'Outubro',
	value : 10
}, {
	nome : 'Novembro',
	value : 11
}, {
	nome : 'Dezembro',
	value : 12
} ]);

app.config(function($routeProvider, $locationProvider) {

	// TIPOS DE DESPESA
	$routeProvider.when('/tipodespesas', {
		templateUrl : 'partial/tipodespesa/tipodespesas.html',
		controller : 'tipoDespesaController'
	});

	$routeProvider.when('/tipodespesa', {
		templateUrl : 'partial/tipodespesa/tipodespesa.html',
		controller : 'edicaoTipoDespesaController'
	});

	$routeProvider.when('/tipodespesa/:id', {
		templateUrl : 'partial/tipodespesa/tipodespesa.html',
		controller : 'edicaoTipoDespesaController'
	});

	// TIPO DE RECEITA
	$routeProvider.when('/tiporeceitas', {
		templateUrl : 'partial/tiporeceita/tiporeceitas.html',
		controller : 'tipoReceitaController'
	});

	$routeProvider.when('/tiporeceita', {
		templateUrl : 'partial/tiporeceita/tiporeceita.html',
		controller : 'edicaoTipoReceitaController'
	});

	$routeProvider.when('/tiporeceita/:id', {
		templateUrl : 'partial/tiporeceita/tiporeceita.html',
		controller : 'edicaoTipoReceitaController'
	});

	// CONTAS
	$routeProvider.when('/contas', {
		templateUrl : 'partial/conta/contas.html',
		controller : 'contaController'
	});

	$routeProvider.when('/conta', {
		templateUrl : 'partial/conta/conta.html',
		controller : 'edicaoContaController'
	});

	$routeProvider.when('/conta/:id', {
		templateUrl : 'partial/conta/conta.html',
		controller : 'edicaoContaController'
	});

	// DESPESAS
	$routeProvider.when('/despesas', {
		templateUrl : 'partial/despesa/despesas.html',
		controller : 'despesaController'
	});

	$routeProvider.when('/despesa', {
		templateUrl : 'partial/despesa/despesa.html',
		controller : 'edicaoDespesaController'
	});

	$routeProvider.when('/despesa/:id', {
		templateUrl : 'partial/despesa/despesa.html',
		controller : 'edicaoDespesaController'
	});

	$routeProvider.when('/painelDespesas', {
		templateUrl : 'partial/painel_despesas.html',
		controller : 'painelDespesaController'
	});

	// CARTAO
	$routeProvider.when('/cartoes', {
		templateUrl : 'partial/cartao/cartoes.html',
		controller : 'cartaoController'
	});

	$routeProvider.when('/cartao', {
		templateUrl : 'partial/cartao/cartao.html',
		controller : 'edicaoCartaoController'
	});

	$routeProvider.when('/cartao/:id', {
		templateUrl : 'partial/cartao/cartao.html',
		controller : 'edicaoCartaoController'
	});

	// ORCAMENTOS
	$routeProvider.when('/orcamentos', {
		templateUrl : 'partial/orcamento/orcamentos.html',
		controller : 'orcamentoController'
	});

	$routeProvider.when('/orcamento', {
		templateUrl : 'partial/orcamento/orcamento.html',
		controller : 'edicaoOrcamentoController'
	});

	$routeProvider.when('/orcamento/:id', {
		templateUrl : 'partial/orcamento/orcamento.html',
		controller : 'edicaoOrcamentoController'
	});

	// RECEITAS
	$routeProvider.when('/receitas', {
		templateUrl : 'partial/receita/receitas.html',
		controller : 'receitaController'
	});

	$routeProvider.when('/receita', {
		templateUrl : 'partial/receita/receita.html',
		controller : 'edicaoReceitaController'
	});

	$routeProvider.when('/painelReceitas', {
		templateUrl : 'partial/painel_receitas.html',
		controller : 'painelReceitaController'
	});

	// PAGAMENTOS
	$routeProvider.when('/pagamentos', {
		templateUrl : 'partial/pagamentos.html',
		controller : 'pagamentosController'
	});

	// FATURA
	$routeProvider.when('/fatura/:id', {
		templateUrl : 'partial/cartao/faturas.html',
		controller : 'faturaController'
	});

	// TRANSFERENCIAS
	$routeProvider.when('/transferencias', {
		templateUrl : 'partial/transferencia/transferencias.html',
		controller : 'transferenciaController'
	});

	$routeProvider.when('/transferencia', {
		templateUrl : 'partial/transferencia/transferencia.html',
		controller : 'edicaoTransferenciaController'
	});

	$routeProvider.when('/transferencia/:id', {
		templateUrl : 'partial/transferencia/transferencia.html',
		controller : 'edicaoTransferenciaController'
	});
	
	//GRAFICOS
	$routeProvider.when('/graficotipodespesa',{
		templateUrl: 'partial/grafico/graficotipodespesa.html',
		controller: 'graficoController'
	});

	// DASHBOARD
	$routeProvider.otherwise({
		templateUrl : 'partial/dashboard.html',
		controller : 'dashboardController'
	});

});

app.config(function(growlProvider) {
	growlProvider.globalTimeToLive(-1);
});

app.filter('range', function() {

	return function(input, total) {
		total = parseInt(total);
		for (var i = 0; i < total; i++) {
			input.push(i);
		}
		return input;
	};
});

app.filter('sum', function() {

	return function(input, params) {

		var totalSum = 0;

		if (input != null) {
			for (var x = 0; x < input.length; x++) {
				var value = input[x][params];
				if (value != null) {
					totalSum += parseFloat(input[x][params]);
				}
			}
		}

		return totalSum;
	};
});

app.directive('ngModal', function() {
	return {
		restrict : 'E',
		replace : true,
		transclude : true,
		templateUrl : 'partial/componentes/modal.html',

		compile : function(element, attrs, transclude) {

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

app.directive('uiCalendar', function(MESES) {

	return {
		restrict : 'A',
		scope : {
			eventSources : '=ngModel',
			functionSelect : '=functionSelect'
		},
		link : function(scope, iElement, iAttrs) {

			diasSemana = [ 'domingo', 'segunda-feira', 'ter\u00e7a-feira', 'quarta-feira', 'quinta-feira', 'sexta-feira', 's\u00e1bado' ];

			diasSemanaCurtos = [ 'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'S\u00e1b' ];

			var textoDosBotoes = {
				today : 'Hoje',
				month : 'Mês',
				week : 'Semana',
				day : 'Dia'
			};

			var select = function(event, jsEvent, view) {
				var eventoSelecionado = null;

				if (event != null && event.despesa != null) {
					scope.functionSelect(event.despesa);
				}
			};

			var id = '#' + iElement.attr('id');

			$(id).fullCalendar(
					{
						height : 800,
						aspectRatio : 10,
						events : scope.eventSources,
						monthNames : [ 'Janeiro', 'Fevereiro', 'Mar\u00e7o', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro',
								'Novembro', 'Dezembro' ],
						dayNames : diasSemana,
						dayNamesShort : diasSemanaCurtos,
						buttonText : textoDosBotoes,
						eventClick : select
					});

			$(id).fullCalendar('refetchEvents');
		}
	};
});

app.directive('colorable', function() {

	return {
		restrict : 'E',
		scope : {
			listaColorable : '=itens',
			value : '=ngModel'
		},
		replace : true,
		transclude : true,
		templateUrl : 'partial/componentes/drop.html',

		link : function(scope, iElement, iAttrs) {

			scope.select = function(item) {
				scope.colorableSelected = item;
				scope.value = item;
			};
		}
	};
});

app.directive('bullet', function($compile) {
	return {
		restrict : 'E',
		scope : {
			item : '=ngModel'
		},
		transclude : true,
		template : '<div><div ng-transclude></div></div>',

		link : function(scope, iElement, iAttrs) {

			var bullet = $('<div></div>').css({
				'border-radius' : '100px',
				'width' : '28px',
				'margin' : '0px 10px',
				'height' : '28px',
				'float' : 'left'
			});

			bullet.attr('ng-style', '{"background-color": item.cor}');

			$(iElement).prepend(bullet);

			$compile(bullet)(scope);
		}
	};
});
