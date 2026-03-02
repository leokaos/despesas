alter table despesas_db.servico_transferencia add column custo_variavel boolean default false;

alter table despesas_db.servico_transferencia alter column taxas drop not null;