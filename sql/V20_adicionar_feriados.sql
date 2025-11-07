CREATE TABLE despesas_db.feriado (
	id bigint NOT NULL, 
	date_feriado date NOT NULL,
	tipo varchar(255) NULL,
	primary key(id)
);

CREATE SEQUENCE despesas_db.feriado_id_seq START 1;