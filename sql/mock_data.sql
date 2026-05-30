-- ============================================
-- 1. TIPO_MOVIMENTACAO (3 despesa + 3 receita)
-- ============================================
INSERT INTO despesas_db.tipo_movimentacao (id, cor, descricao, tipo) VALUES
(nextval('despesas_db.tipo_movimentacao_id_seq'), '#FF0000', 'Tipo Despesa 1', 'D'),
(nextval('despesas_db.tipo_movimentacao_id_seq'), '#00FF00', 'Tipo Despesa 2', 'D'),
(nextval('despesas_db.tipo_movimentacao_id_seq'), '#0000FF', 'Tipo Despesa 3', 'D'),
(nextval('despesas_db.tipo_movimentacao_id_seq'), '#FFFF00', 'Tipo Receita 1', 'R'),
(nextval('despesas_db.tipo_movimentacao_id_seq'), '#FF00FF', 'Tipo Receita 2', 'R'),
(nextval('despesas_db.tipo_movimentacao_id_seq'), '#00FFFF', 'Tipo Receita 3', 'R');


-- ============================================
-- 2. DEBITAVEL (base para conta, cartao, etc.)
-- ============================================
-- Conta 1 (Real)
INSERT INTO despesas_db.debitavel (id, cor, descricao, tipo, moeda, ativo)
VALUES (nextval('despesas_db.debitavel_id_seq'), '#888888', 'Conta 1', 'CONTA', 'REAL', true);

-- Conta 2 (Euro)
INSERT INTO despesas_db.debitavel (id, cor, descricao, tipo, moeda, ativo)
VALUES (nextval('despesas_db.debitavel_id_seq'), '#999999', 'Conta 2', 'CONTA', 'EURO', true);

-- Cartão de Crédito (Real)
INSERT INTO despesas_db.debitavel (id, cor, descricao, tipo, moeda, ativo)
VALUES (nextval('despesas_db.debitavel_id_seq'), '#AAAAAA', 'Cartao 1', 'CARTAO', 'REAL', true);


-- ============================================
-- 3. CONTA (referencia ao debitavel)
-- ============================================
-- Pega os IDs dos debitaveis criados acima (ordem: Conta1, Conta2, Cartao1)
-- Se precisar dos IDs exatos, consulte: SELECT id, descricao FROM despesas_db.debitavel;

INSERT INTO despesas_db.conta (id, saldo)
SELECT id, 1000.00 FROM despesas_db.debitavel WHERE descricao = 'Conta 1' AND tipo = 'CONTA';

INSERT INTO despesas_db.conta (id, saldo)
SELECT id, 500.00 FROM despesas_db.debitavel WHERE descricao = 'Conta 2' AND tipo = 'CONTA';


-- ============================================
-- 4. CARTAO (referencia ao debitavel)
-- ============================================
INSERT INTO despesas_db.cartao (id, bandeiracartaocredito, diadefechamento, diadevencimento, limite, limite_atual)
SELECT id, 'VISA', 10, 5, 5000.00, 5000.00 
FROM despesas_db.debitavel WHERE descricao = 'Cartao 1' AND tipo = 'CARTAO';


-- ============================================
-- 5. ORCAMENTO (usando os tipos de despesa criados)
-- ============================================
-- Primeiro, pega os IDs dos tipos de despesa
WITH tipos_despesa AS (
    SELECT id FROM despesas_db.tipo_movimentacao WHERE tipo = 'D' ORDER BY id LIMIT 3
),
datas AS (
    SELECT 
        DATE_TRUNC('month', CURRENT_DATE) as inicio_mes,
        DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month' - INTERVAL '1 day' as fim_mes
)
INSERT INTO despesas_db.orcamento (id, tipo_despesa_id, valor, data_inicial, data_final)
SELECT 
    nextval('despesas_db.orcamento_id_seq'),
    td.id,
    1000.00,
    d.inicio_mes,
    d.fim_mes
FROM tipos_despesa td
CROSS JOIN datas d;

-- ============================================
-- 6. META
-- ============================================
INSERT INTO despesas_db.meta (id, mes, ano, valor)
SELECT 
    nextval('despesas_db.meta_id_seq'),
    EXTRACT(MONTH FROM CURRENT_DATE)::int,
    EXTRACT(YEAR FROM CURRENT_DATE)::int,
    5000.00;  -- valor da meta de poupança

-- ============================================
-- DESPESAS (10 registros)
-- ============================================

-- Primeiro, vamos garantir que temos IDs disponíveis
-- Despesas 1 a 10
INSERT INTO despesas_db.movimentacao (id, descricao, pagamento, valor, vencimento, debitavel_id, moeda)
SELECT 
    nextval('despesas_db.movimentacao_id_seq'),
    'Despesa ' || seq,
    CURRENT_DATE - (seq || ' days')::interval,
    (random() * 500 + 50)::numeric(19,2),  -- valor entre 50 e 550
    CURRENT_DATE + (seq || ' days')::interval,
    (SELECT id FROM despesas_db.debitavel WHERE descricao = 'Conta 1' LIMIT 1),
    'REAL'
FROM generate_series(1, 10) AS seq;

-- Agora insere as despesas (referenciando as movimentacoes e tipos de despesa)
WITH mov_despesa AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) as rn
    FROM despesas_db.movimentacao 
    WHERE descricao LIKE 'Despesa %'
    ORDER BY id
),
tipo_despesa AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) as rn
    FROM despesas_db.tipo_movimentacao 
    WHERE tipo = 'D'
    ORDER BY id
)
INSERT INTO despesas_db.despesa (id, paga, tipo_despesa_id, fatura_id)
SELECT 
    m.id,
    false,  -- todas as despesas começam não pagas
    td.id,
    NULL    -- sem fatura (despesa à vista)
FROM mov_despesa m
JOIN tipo_despesa td ON ((m.rn - 1) % 3) + 1 = td.rn;  -- distribui entre os 3 tipos de despesa


-- ============================================
-- RECEITAS (2 registros)
-- ============================================

-- Movimentacoes das receitas
INSERT INTO despesas_db.movimentacao (id, descricao, pagamento, valor, vencimento, debitavel_id, moeda)
SELECT 
    nextval('despesas_db.movimentacao_id_seq'),
    'Receita ' || seq,
    CURRENT_DATE - (seq || ' days')::interval,
    (random() * 1000 + 500)::numeric(19,2),  -- valor entre 500 e 1500
    CURRENT_DATE + (seq || ' days')::interval,
    (SELECT id FROM despesas_db.debitavel WHERE descricao = 'Conta 1' LIMIT 1),
    'REAL'
FROM generate_series(1, 2) AS seq;

-- Insere as receitas
WITH mov_receita AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) as rn
    FROM despesas_db.movimentacao 
    WHERE descricao LIKE 'Receita %'
    ORDER BY id
),
tipo_receita AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id) as rn
    FROM despesas_db.tipo_movimentacao 
    WHERE tipo = 'R'
    ORDER BY id
)
INSERT INTO despesas_db.receita (id, depositado, tipo_receita_id, investimento_id, compromissada)
SELECT 
    m.id,
    false,  -- ainda não depositado
    tr.id,
    NULL,   -- sem investimento vinculado
    false   -- não é compromissada
FROM mov_receita m
JOIN tipo_receita tr ON m.rn = tr.rn;