-- Criar sequence
CREATE SEQUENCE despesas_db.filtro_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;

CREATE TABLE despesas_db.filtro (
    id bigint NOT NULL,
    nome VARCHAR(100) NOT NULL,
    classe VARCHAR(100) NOT NULL,
    expressao VARCHAR(500) NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT uk_filtro_nome_classe UNIQUE (nome, classe)
);

