ALTER TABLE despesas_db.despesa ADD notificacao_id bigint NULL;
ALTER TABLE despesas_db.despesa ADD CONSTRAINT despesa_notificacao_fk FOREIGN KEY (notificacao_id) REFERENCES despesas_db.notificacao(id);
