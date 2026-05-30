
ALTER TABLE despesas_db.debitavel ADD CONSTRAINT chk_debitavel_moeda CHECK (moeda IN ('REAL', 'EURO'));

ALTER TABLE despesas_db.movimentacao ADD CONSTRAINT chk_movimentacao_moeda CHECK (moeda IN ('REAL', 'EURO'));
