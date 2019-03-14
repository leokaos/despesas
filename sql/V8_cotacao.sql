CREATE TABLE despesas_db.COTACAO (
	ID BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
	ORIGEM varchar(255) not null,
	DESTINO varchar(255) not null,
	TAXA NUMERIC(19,2) not null,
	DATA TIMESTAMP not null,
	PRIMARY KEY (ID)
);

insert into despesas_db.COTACAO(origem, destino,taxa, data)
values ('EURO','REAL',4.32,'2019-03-14 12:00:00');

insert into despesas_db.COTACAO(origem, destino,taxa, data)
values ('EURO','REAL',4.32,'2019-03-14 13:00:00');

insert into despesas_db.COTACAO(origem, destino,taxa, data)
values ('EURO','REAL',4.32,'2019-03-14 14:00:00');
