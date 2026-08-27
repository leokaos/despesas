CREATE TABLE IF NOT EXISTS despesas_db.ativo (
    id BIGINT NOT NULL,
    CONSTRAINT ativo_pkey PRIMARY KEY (id),
    CONSTRAINT ativo_debitavel_fk FOREIGN KEY (id) REFERENCES despesas_db.debitavel(id)
);