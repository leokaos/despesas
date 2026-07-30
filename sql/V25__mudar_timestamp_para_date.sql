ALTER TABLE despesas_db.divida ALTER COLUMN data_inicio TYPE date USING data_inicio::date;

ALTER TABLE despesas_db.divida ADD data_limite date NULL;