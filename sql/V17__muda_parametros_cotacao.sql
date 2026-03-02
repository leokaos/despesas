
DELETE FROM despesas_db.parametros WHERE nome='EURO.REAL';

INSERT INTO despesas_db.parametros (nome,valor,tipo) VALUES ('COTACAO_URL','https://economia.awesomeapi.com.br/json/last/','TEXTO');
