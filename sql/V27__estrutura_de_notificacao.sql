CREATE TABLE despesas_db.notificacao (
    id BIGINT NOT NULL,
    executado BOOLEAN NOT NULL DEFAULT FALSE,
    origem_alerta_id BIGINT,
    target_date DATE,
    mes INTEGER,
    ano INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (origem_alerta_id) REFERENCES despesas_db.alerta(id)
);

CREATE SEQUENCE despesas_db.notificacao_id_seq;