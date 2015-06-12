app.directive('pesquisaView',function(usSpinnerService) {

	return {
	    restrict: 'E',
	    scope: false,
	    replace: true,
	    transclude: true,
	    templateUrl: 'partial/componentes/pesquisaView.html',

	    link: function($scope,iElement,iAttrs) {

		    $scope.numberPages = [
		            5,
		            10,
		            25,
		            50
		    ];
		    $scope.pageSize = $scope.numberPages[0];
		    $scope.currentPage = 0;
		    $scope.pages = 0;

		    $scope.changePage = function(page) {
			    $scope.currentPage = page;
			    $scope.loadData($scope.originalData);
		    };

		    $scope.changePageSize = function() {
			    $scope.currentPage = 0;
			    $scope.loadData($scope.originalData);
		    };

		    $scope.nextPage = function() {
			    $scope.currentPage++;
			    $scope.loadData($scope.originalData);
		    };

		    $scope.previousPage = function() {
			    $scope.currentPage--;
			    $scope.loadData($scope.originalData);
		    };

		    $scope.firstPage = function() {
			    $scope.currentPage = 0;
			    $scope.loadData($scope.originalData);
		    };

		    $scope.lastPage = function() {
			    $scope.currentPage = $scope.pages - 1;
			    $scope.loadData($scope.originalData);
		    };

		    $scope.isLastPage = function() {
			    if ($scope.pages == 0) {
				    return true;
			    }

			    return (($scope.currentPage + 1) == $scope.pages);
		    };

		    $scope.isFirstPage = function() {
			    if ($scope.pages == 0) {
				    return true;
			    }

			    return $scope.currentPage == 0;
		    };

		    $scope.deletar = function(data) {

			    var id = $scope.getItemSelecionado().id;

			    for (var x = 0 ; x < $scope.originalData.length ; x++) {
				    var tp = $scope.originalData[x];
				    if (tp.id == id) {
					    $scope.originalData.splice(x,1);
					    break;
				    }
			    }

			    $('#modalExcluir').modal('hide');
			    $('#modalOk').modal('show');
			    $scope.loadData($scope.originalData);
		    };

		    $scope.loadData = function(lista) {

			    $scope.originalData = lista;

			    $scope.pageSize = parseInt($scope.pageSize);
			    $scope.first = $scope.pageSize * $scope.currentPage;
			    $scope.sliceData = $scope.originalData.slice($scope.first,$scope.first + $scope.pageSize);
			    $scope.pages = Math.ceil($scope.originalData.length / $scope.pageSize);

			    usSpinnerService.stop($scope.getNomeSpin());
		    };

		    $scope.listar();
	    }
	};
});
