ALTER TABLE despesas_db.fatura ALTER COLUMN data_vencimento TYPE date USING data_vencimento::date;
ALTER TABLE despesas_db.fatura ALTER COLUMN data_fechamento TYPE date USING data_fechamento::date;

ALTER TABLE despesas_db.orcamento ALTER COLUMN data_inicial TYPE date USING data_inicial::date;
ALTER TABLE despesas_db.orcamento ALTER COLUMN data_final TYPE date USING data_final::date;

ALTER TABLE despesas_db.cotacao ALTER COLUMN "data" TYPE date USING "data"::date;
