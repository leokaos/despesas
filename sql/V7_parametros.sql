CREATE TABLE despesas_db.PARAMETROS (
	NOME varchar(255) not null,
	VALOR varchar(255) not null,
	TIPO varchar(255) not null,
	PRIMARY KEY (NOME)
);

insert into despesas_db.PARAMETROS(nome, valor,tipo) values ('IOF', '0.38', 'PORCENTAGEM');
insert into despesas_db.PARAMETROS(nome, valor,tipo) values ('SPOT', '0.003', 'DECIMAL');
insert into despesas_db.PARAMETROS(nome, valor,tipo) values ('EURO.REAL', 'https://economia.uol.com.br/cotacoes/cambio/euro-uniao-europeia/', 'TEXTO');