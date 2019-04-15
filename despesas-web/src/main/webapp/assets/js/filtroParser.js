app.service('filtroParser', function() {

	this.getFiltro = function(filtro){
		
		var otherFiltro = angular.copy(filtro);
		
		for (key in otherFiltro) {

			if (angular.isDate(otherFiltro[key])){
				otherFiltro[key] = otherFiltro[key].toGMTString();
			}
		}
		
		return otherFiltro;		
	};

});