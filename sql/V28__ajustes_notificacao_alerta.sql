
ALTER TABLE despesas_db.notificacao ALTER COLUMN origem_alerta_id SET NOT NULL;
ALTER TABLE despesas_db.notificacao ALTER COLUMN target_date SET NOT NULL;
ALTER TABLE despesas_db.notificacao DROP COLUMN mes;
ALTER TABLE despesas_db.notificacao DROP COLUMN ano;


ALTER TABLE despesas_db.alerta_limite_pagamento_divida ADD CONSTRAINT alerta_limite_pagamento_divida_id_fkey_divida FOREIGN KEY (divida_id) REFERENCES divida(id);
ALTER TABLE despesas_db.alerta_pagamento_fatura_cartao ADD CONSTRAINT alerta_pagamento_fatura_cartao_id_fkey_cartao FOREIGN KEY (cartao_credito_id) REFERENCES cartao(id);