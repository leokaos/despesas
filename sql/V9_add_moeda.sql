--DEBITAVEL
alter table despesas_db.debitavel add column moeda varchar(255);

update despesas_db.debitavel set moeda = 'REAL';

alter table despesas_db.debitavel alter moeda not null;

--MOVIMENTACAO

alter table despesas_db.movimentacao add column moeda varchar(255);

update despesas_db.movimentacao set moeda = 'REAL';

alter table despesas_db.movimentacao alter moeda not null;