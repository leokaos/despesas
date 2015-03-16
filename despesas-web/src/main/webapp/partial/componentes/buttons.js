app.directive('buttonDelete', function () {

    return {
        restrict: 'E',
        scope: false,
        replace: true,
        transclude: true,
        template: '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modalExcluir" ng-click="select(item);"><i class="fa fa-trash-o"></i></button>'
    }
});

app.directive('buttonEditar', function () {

    return {
        restrict: 'E',
        scope: false,
        replace: true,
        transclude: true,
        template: '<button type="button" class="btn btn-default" ng-click="editar(item.id)"><i class="fa fa-edit"></i></button>'
    }
});