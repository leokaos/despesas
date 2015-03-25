CREATE TABLE "DESPESAS_DB"."RECEITA" (
	"DEPOSITADO" BOOLEAN NOT NULL, 
	"ID" BIGINT NOT NULL, 
	"TIPO_RECEITA_ID" BIGINT NOT NULL
);

ALTER TABLE "DESPESAS_DB"."RECEITA" ADD CONSTRAINT "RECEITA_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."RECEITA" ADD CONSTRAINT "RECEITA_MOVIMENTACAO_FK" 
	FOREIGN KEY ("ID") REFERENCES "DESPESAS_DB"."MOVIMENTACAO" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE "DESPESAS_DB"."RECEITA" ADD CONSTRAINT "RECEITA_TIPO_MOVIMENTACAO_FK" 
	FOREIGN KEY ("TIPO_RECEITA_ID") REFERENCES "DESPESAS_DB"."TIPO_MOVIMENTACAO" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;