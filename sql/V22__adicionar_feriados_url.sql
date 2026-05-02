INSERT INTO despesas_db.parametros (nome,valor,tipo) VALUES ('FERIADO_URL','https://date.nager.at/api/v3/PublicHolidays/','TEXTO');

ALTER TABLE despesas_db.feriado ADD nome varchar(255) DEFAULT 'FERIAS' NOT NULL;

ALTER TABLE despesas_db.feriado ADD CONSTRAINT feriado_date_feriado_unique UNIQUE (date_feriado);