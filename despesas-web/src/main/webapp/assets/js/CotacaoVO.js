// CotacaoVO
function CotacaoVO(obj) {

	angular.extend(this, obj);
	
	if (this.data != null){
		this.data = new Date(this.data);
	}

};

CotacaoVO.prototype.toCotacao = function() {
	return {
	    data: this.data,
	    origem: this.origem,
	    destino: this.destino,
	    taxa:this.taxa
	};
};

CotacaoVO.prototype.toString = function() {
	return 'Cotação de ' + this.origem + ' para ' + this.destino + ' em ' + this.data.toLocaleDateString("pt-BR");
};
