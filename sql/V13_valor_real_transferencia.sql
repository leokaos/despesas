	
ALTER TABLE despesas_db.TRANSFERENCIA ADD COLUMN VALOR_REAL NUMERIC(19,2) NULL;

UPDATE despesas_db.TRANSFERENCIA T set VALOR_REAL = (SELECT M.VALOR FROM despesas_db.MOVIMENTACAO M WHERE M.id = T.id);

ALTER TABLE despesas_db.TRANSFERENCIA ALTER COLUMN VALOR_REAL SET NOT NULL;

