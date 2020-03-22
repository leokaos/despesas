CREATE TABLE despesas_db.SERVICO_TRANSFERENCIA (
	ID BIGINT NOT NULL,
	TAXAS NUMERIC(19,2) not null,
	SPRED NUMERIC(19,2) not null,
	NOME varchar(255) not null,
	PRIMARY KEY (ID)
);

CREATE SEQUENCE despesas_db.servico_transferencia_id_seq START 1;