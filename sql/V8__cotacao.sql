CREATE TABLE despesas_db.COTACAO (
	ID BIGINT NOT NULL,
	ORIGEM varchar(255) not null,
	DESTINO varchar(255) not null,
	TAXA NUMERIC(19,2) not null,
	DATA TIMESTAMP not null,
	PRIMARY KEY (ID)
);

CREATE SEQUENCE despesas_db.cotacao_id_seq START 1;