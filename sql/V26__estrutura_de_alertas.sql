CREATE TABLE despesas_db.alerta (
    id BIGINT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    dias_antes_de_aviso INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE despesas_db.alerta_despesa_recorrente (
    id BIGINT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    tipo_periodicidade VARCHAR(50) NOT NULL,
    dia_alvo INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES despesas_db.alerta(id)
);

CREATE TABLE despesas_db.alerta_limite_pagamento_divida (
    id BIGINT NOT NULL,
    divida_id BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES despesas_db.alerta(id)
);

CREATE TABLE despesas_db.alerta_pagamento_fatura_cartao (
    id BIGINT NOT NULL,
    cartao_credito_id BIGINT,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES despesas_db.alerta(id)
);

CREATE SEQUENCE despesas_db.alerta_id_seq;