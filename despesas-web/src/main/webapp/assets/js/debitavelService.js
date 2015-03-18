app.service('debitavelService', function ($http) {

    var pathBase = '/despesas/services/debitavel';

    this.listar = function (fn) {
        $http.get(pathBase).success(function (data) {
            fn(data);
        });
    };

});