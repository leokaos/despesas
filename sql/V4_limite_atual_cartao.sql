ALTER TABLE despesas_db.CARTAO ADD COLUMN LIMITE_ATUAL NUMERIC(19,2);
UPDATE despesas_db.CARTAO SET LIMITE_ATUAL = LIMITE;

ALTER TABLE despesas_db.FATURA ADD COLUMN PAGA BOOLEAN DEFAULT FALSE;