app.service('debitavelService', function ($http) {

    var pathBase = 'http://localhost:8080/despesas/services/debitavel';

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

});