CREATE SCHEMA "DESPESAS_DB";

CREATE TABLE "DESPESAS_DB"."TIPO_MOVIMENTACAO" (
	"TIPO" VARCHAR(31) NOT NULL, 
	"ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1), 
	"COR" VARCHAR(255), 
	"DESCRICAO" VARCHAR(255)
);

CREATE TABLE "DESPESAS_DB"."CARTAO" (
	"BANDEIRACARTAOCREDITO" VARCHAR(255), 
	"DIADEFECHAMENTO" INTEGER, 
	"DIADEVENCIMENTO" INTEGER, 
	"LIMITE" NUMERIC(19,2), 
	"ID" BIGINT NOT NULL
);

CREATE TABLE "DESPESAS_DB"."CONTA" (
	"SALDO" NUMERIC(19,2), 
	"ID" BIGINT NOT NULL
);

CREATE TABLE "DESPESAS_DB"."DEBITAVEL" (
	"ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1), 
	"COR" VARCHAR(255), 
	"DESCRICAO" VARCHAR(255)
);

CREATE TABLE "DESPESAS_DB"."MOVIMENTACAO" (
	"ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1), 
	"DESCRICAO" VARCHAR(255), 
	"PAGAMENTO" TIMESTAMP, 
	"VALOR" NUMERIC(19,2), 
	"VENCIMENTO" TIMESTAMP, 
	"DEBITAVEL_ID" BIGINT
);

CREATE TABLE "DESPESAS_DB"."DESPESA" (
	"PAGA" BOOLEAN, 
	"ID" BIGINT NOT NULL, 
	"TIPO_DESPESA_ID" BIGINT
);

ALTER TABLE "DESPESAS_DB"."CONTA" ADD CONSTRAINT "CONTA_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."TIPO_MOVIMENTACAO" ADD CONSTRAINT "TIPO_MOVIMENTACAO_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."MOVIMENTACAO" ADD CONSTRAINT "MOVIMENTACAO_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."CARTAO" ADD CONSTRAINT "CARTAO_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."DESPESA" ADD CONSTRAINT "DESPESA_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."DEBITAVEL" ADD CONSTRAINT "DEBITAVEL_PK" PRIMARY KEY ("ID");

ALTER TABLE "DESPESAS_DB"."CONTA" ADD CONSTRAINT "CONTA_DEBITAVEL_FK" 
	FOREIGN KEY ("ID") REFERENCES "DESPESAS_DB"."DEBITAVEL" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "DESPESAS_DB"."MOVIMENTACAO" ADD CONSTRAINT "MOVIMENTACAO_DEBITAVEL_FK" 
	FOREIGN KEY ("DEBITAVEL_ID") REFERENCES "DESPESAS_DB"."DEBITAVEL" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "DESPESAS_DB"."CARTAO" ADD CONSTRAINT "CARTAO_DEBITAVEL_FK" 
	FOREIGN KEY ("ID") REFERENCES "DESPESAS_DB"."DEBITAVEL" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "DESPESAS_DB"."DESPESA" ADD CONSTRAINT "DESPESA_MOVIMENTACAO_FK" 
	FOREIGN KEY ("ID") REFERENCES "DESPESAS_DB"."MOVIMENTACAO" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "DESPESAS_DB"."DESPESA" ADD CONSTRAINT "DESPESA_TIPO_MOVIMENTACAO_FK" 
	FOREIGN KEY ("TIPO_DESPESA_ID") REFERENCES "DESPESAS_DB"."TIPO_MOVIMENTACAO" ("ID") ON DELETE NO ACTION ON UPDATE NO ACTION;

