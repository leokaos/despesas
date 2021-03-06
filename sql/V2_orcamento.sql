CREATE TABLE despesas_db.ORCAMENTO (

        ID BIGINT NOT NULL,
        TIPO_DESPESA_ID BIGINT NOT NULL,
        VALOR NUMERIC(10,2) NOT NULL,
        DATA_INICIAL TIMESTAMP NOT NULL,
        DATA_FINAL TIMESTAMP NOT NULL,
        PRIMARY KEY(ID)
);

ALTER TABLE despesas_db.ORCAMENTO ADD CONSTRAINT ORCAMENTO_TIPO_DESPESA FOREIGN KEY (TIPO_DESPESA_ID) REFERENCES despesas_db.TIPO_MOVIMENTACAO(ID)
 ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE TABLE despesas_db.FATURA (
        ID BIGINT NOT NULL,
        CARTAO_ID BIGINT NOT NULL,
        DATA_VENCIMENTO TIMESTAMP NOT NULL,
        DATA_FECHAMENTO TIMESTAMP NOT NULL,
        PRIMARY KEY(ID)
);

ALTER TABLE despesas_db.FATURA ADD CONSTRAINT FATURA_CARTAO FOREIGN KEY (CARTAO_ID) REFERENCES despesas_db.CARTAO(ID)
 ON DELETE NO ACTION ON UPDATE NO ACTION;
 
ALTER TABLE despesas_db.DESPESA ADD COLUMN FATURA_ID BIGINT;

ALTER TABLE despesas_db.DESPESA ADD CONSTRAINT DESPESA_FATURA FOREIGN KEY (FATURA_ID) REFERENCES despesas_db.FATURA(ID)
 ON DELETE NO ACTION ON UPDATE NO ACTION;
 
 CREATE SEQUENCE despesas_db.orcamento_id_seq START 1;