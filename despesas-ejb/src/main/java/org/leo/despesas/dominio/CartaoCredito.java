package org.leo.despesas.dominio;

import java.math.BigDecimal;
import java.util.Date;

public class CartaoCredito {

    private String descricao;
    private BigDecimal limite;
    private Date fechamento;
    private Date pagamento;
    private BandeiraCartaoCredito bandeiraCartaoCredito;

    public CartaoCredito() {
	super();
    }

    public String getDescricao() {
	return descricao;
    }

    public void setDescricao(String descricao) {
	this.descricao = descricao;
    }

    public BigDecimal getLimite() {
	return limite;
    }

    public void setLimite(BigDecimal limite) {
	this.limite = limite;
    }

    public Date getFechamento() {
	return fechamento;
    }

    public void setFechamento(Date fechamento) {
	this.fechamento = fechamento;
    }

    public Date getPagamento() {
	return pagamento;
    }

    public void setPagamento(Date pagamento) {
	this.pagamento = pagamento;
    }

    public BandeiraCartaoCredito getBandeiraCartaoCredito() {
	return bandeiraCartaoCredito;
    }

    public void setBandeiraCartaoCredito(BandeiraCartaoCredito bandeiraCartaoCredito) {
	this.bandeiraCartaoCredito = bandeiraCartaoCredito;
    }

}
