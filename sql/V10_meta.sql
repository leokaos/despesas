CREATE TABLE despesas_db.META (
	ID BIGINT NOT NULL,
	data_inicial TIMESTAMP not null,
	data_final TIMESTAMP not null,
	VALOR NUMERIC(10,2) NOT NULL,
	PRIMARY KEY (ID)
);

CREATE SEQUENCE despesas_db.meta_id_seq START 1;

