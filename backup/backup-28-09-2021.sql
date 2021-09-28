--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: despesas_db; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA despesas_db;


ALTER SCHEMA despesas_db OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cartao; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.cartao (
    bandeiracartaocredito character varying(255) NOT NULL,
    diadefechamento integer NOT NULL,
    diadevencimento integer NOT NULL,
    limite numeric(19,2) NOT NULL,
    id bigint NOT NULL,
    limite_atual numeric(19,2)
);


ALTER TABLE despesas_db.cartao OWNER TO despesas;

--
-- Name: conta; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.conta (
    saldo numeric(19,2) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE despesas_db.conta OWNER TO despesas;

--
-- Name: cotacao; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.cotacao (
    id bigint NOT NULL,
    origem character varying(255) NOT NULL,
    destino character varying(255) NOT NULL,
    taxa numeric(19,2) NOT NULL,
    data timestamp without time zone NOT NULL
);


ALTER TABLE despesas_db.cotacao OWNER TO despesas;

--
-- Name: cotacao_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.cotacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.cotacao_id_seq OWNER TO despesas;

--
-- Name: debitavel; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.debitavel (
    id bigint NOT NULL,
    cor character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    moeda character varying(255) NOT NULL,
    ativo boolean DEFAULT true
);


ALTER TABLE despesas_db.debitavel OWNER TO despesas;

--
-- Name: debitavel_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.debitavel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.debitavel_id_seq OWNER TO despesas;

--
-- Name: despesa; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.despesa (
    paga boolean NOT NULL,
    id bigint NOT NULL,
    tipo_despesa_id bigint NOT NULL,
    fatura_id bigint
);


ALTER TABLE despesas_db.despesa OWNER TO despesas;

--
-- Name: divida; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.divida (
    valor_total numeric(19,2) NOT NULL,
    periodiciodade character varying(255) NOT NULL,
    data_inicio timestamp without time zone NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE despesas_db.divida OWNER TO despesas;

--
-- Name: fatura; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.fatura (
    id bigint NOT NULL,
    cartao_id bigint NOT NULL,
    data_vencimento timestamp without time zone NOT NULL,
    data_fechamento timestamp without time zone NOT NULL,
    paga boolean DEFAULT false
);


ALTER TABLE despesas_db.fatura OWNER TO despesas;

--
-- Name: fatura_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.fatura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.fatura_id_seq OWNER TO despesas;

--
-- Name: investimento; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.investimento (
    montante numeric(19,2) NOT NULL,
    id bigint NOT NULL,
    periodicidade character varying(255) NOT NULL,
    rendimento numeric(19,2) NOT NULL
);


ALTER TABLE despesas_db.investimento OWNER TO despesas;

--
-- Name: meta; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.meta (
    id bigint NOT NULL,
    mes integer NOT NULL,
    ano integer NOT NULL,
    valor numeric(10,2) NOT NULL
);


ALTER TABLE despesas_db.meta OWNER TO despesas;

--
-- Name: meta_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.meta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.meta_id_seq OWNER TO despesas;

--
-- Name: movimentacao; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.movimentacao (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    pagamento date,
    valor numeric(19,2) NOT NULL,
    vencimento date NOT NULL,
    debitavel_id bigint,
    moeda character varying(255) NOT NULL
);


ALTER TABLE despesas_db.movimentacao OWNER TO despesas;

--
-- Name: movimentacao_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.movimentacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.movimentacao_id_seq OWNER TO despesas;

--
-- Name: orcamento; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.orcamento (
    id bigint NOT NULL,
    tipo_despesa_id bigint NOT NULL,
    valor numeric(10,2) NOT NULL,
    data_inicial timestamp without time zone NOT NULL,
    data_final timestamp without time zone NOT NULL
);


ALTER TABLE despesas_db.orcamento OWNER TO despesas;

--
-- Name: orcamento_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.orcamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.orcamento_id_seq OWNER TO despesas;

--
-- Name: parametros; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.parametros (
    nome character varying(255) NOT NULL,
    valor character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL
);


ALTER TABLE despesas_db.parametros OWNER TO despesas;

--
-- Name: receita; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.receita (
    depositado boolean NOT NULL,
    id bigint NOT NULL,
    tipo_receita_id bigint NOT NULL,
    investimento_id bigint
);


ALTER TABLE despesas_db.receita OWNER TO despesas;

--
-- Name: servico_transferencia; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.servico_transferencia (
    id bigint NOT NULL,
    taxas numeric(19,2),
    spred numeric(19,2) NOT NULL,
    nome character varying(255) NOT NULL,
    custo_variavel boolean DEFAULT false
);


ALTER TABLE despesas_db.servico_transferencia OWNER TO despesas;

--
-- Name: servico_transferencia_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.servico_transferencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.servico_transferencia_id_seq OWNER TO despesas;

--
-- Name: tipo_movimentacao; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.tipo_movimentacao (
    tipo character varying(31) NOT NULL,
    id bigint NOT NULL,
    cor character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE despesas_db.tipo_movimentacao OWNER TO despesas;

--
-- Name: tipo_movimentacao_id_seq; Type: SEQUENCE; Schema: despesas_db; Owner: despesas
--

CREATE SEQUENCE despesas_db.tipo_movimentacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE despesas_db.tipo_movimentacao_id_seq OWNER TO despesas;

--
-- Name: transferencia; Type: TABLE; Schema: despesas_db; Owner: despesas
--

CREATE TABLE despesas_db.transferencia (
    id bigint NOT NULL,
    creditavel_id bigint NOT NULL,
    valor_real numeric(19,2) NOT NULL
);


ALTER TABLE despesas_db.transferencia OWNER TO despesas;

--
-- Data for Name: cartao; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.cartao (bandeiracartaocredito, diadefechamento, diadevencimento, limite, id, limite_atual) FROM stdin;
VISA	27	11	17300.00	6	\N
\.


--
-- Data for Name: conta; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.conta (saldo, id) FROM stdin;
260054.63	5
4798.46	3
24.81	4
\.


--
-- Data for Name: cotacao; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.cotacao (id, origem, destino, taxa, data) FROM stdin;
1	EURO	REAL	5.58	2020-03-19 08:17:48.903
2	EURO	REAL	5.74	2020-04-01 00:00:00
3	EURO	REAL	5.76	2020-04-22 00:00:00
4	EURO	REAL	5.87	2020-04-22 00:00:00
5	EURO	REAL	6.10	2020-04-27 00:00:00
\.


--
-- Data for Name: debitavel; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.debitavel (id, cor, descricao, tipo, moeda, ativo) FROM stdin;
3	#ab1fc2	Millenium	CONTA	EURO	t
4	#709982	N26	CONTA	EURO	t
5	#ffb800	Itáu	CONTA	REAL	t
6	#0047ff	Porto Seguro	CARTAO	REAL	t
7	#e36017	Financiamento Imobiliario Itau	DIVIDA	REAL	f
\.


--
-- Data for Name: despesa; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.despesa (paga, id, tipo_despesa_id, fatura_id) FROM stdin;
t	93	302	\N
t	94	302	\N
t	95	301	\N
t	96	1	\N
t	97	301	\N
f	100	302	\N
f	101	1	\N
f	102	108	\N
f	103	302	\N
f	104	302	\N
f	105	301	\N
f	106	201	\N
f	107	1	\N
f	108	1	\N
f	109	108	\N
f	110	301	\N
f	111	1	\N
t	121	302	\N
t	124	108	\N
t	127	302	\N
t	132	401	9
t	133	108	9
t	134	108	9
t	135	108	9
t	136	108	9
t	137	108	9
t	138	201	9
t	139	301	\N
t	147	301	\N
t	149	201	\N
t	150	201	\N
t	267	104	\N
t	159	401	12
t	168	108	12
t	169	201	12
t	170	201	12
t	171	201	12
t	172	201	12
t	174	302	\N
t	178	302	\N
t	179	102	\N
t	182	302	\N
t	183	301	\N
t	185	302	\N
t	187	302	\N
t	188	401	\N
t	189	401	\N
t	190	401	12
t	194	102	\N
t	197	301	\N
t	208	401	\N
t	209	401	\N
t	221	302	\N
t	222	401	\N
t	223	302	\N
t	224	302	\N
t	225	302	\N
t	226	302	\N
t	227	1	\N
t	228	102	\N
t	229	302	\N
t	230	302	\N
t	231	401	13
t	232	401	13
t	236	302	\N
t	237	102	\N
t	238	302	\N
t	239	302	\N
t	240	302	\N
t	241	102	\N
t	242	102	\N
t	243	108	\N
t	248	201	13
t	260	302	\N
t	261	102	\N
t	262	302	\N
t	264	108	\N
t	265	302	\N
t	266	401	\N
t	285	108	14
t	286	108	14
t	288	301	\N
t	289	301	\N
t	290	201	\N
t	296	301	\N
t	299	1	\N
t	300	401	\N
t	301	401	\N
t	302	301	\N
t	306	108	\N
t	316	201	14
t	317	201	14
t	320	301	\N
t	321	301	\N
t	322	301	\N
t	323	108	\N
t	324	401	\N
t	329	108	14
t	340	301	\N
t	341	108	\N
t	342	302	\N
t	62	108	\N
t	63	108	\N
t	64	301	\N
t	65	1	\N
t	66	301	\N
t	67	301	\N
t	68	201	\N
t	69	401	\N
t	70	301	\N
t	71	1	\N
t	72	301	\N
t	73	1	\N
t	74	1	\N
t	76	401	\N
t	77	102	\N
t	78	102	\N
t	79	401	\N
t	80	104	\N
t	81	301	\N
t	82	1	\N
t	83	102	\N
t	84	302	\N
t	85	302	\N
t	86	302	\N
t	87	401	\N
t	88	301	\N
t	89	401	\N
t	90	1	\N
t	26	301	\N
t	27	401	\N
t	344	102	\N
t	345	1	\N
t	346	301	\N
t	348	108	17
t	351	108	\N
t	353	302	\N
t	354	302	\N
t	355	301	\N
t	356	1	\N
t	357	401	\N
t	358	301	\N
t	369	302	\N
t	370	302	\N
t	371	301	\N
t	372	104	\N
t	375	302	\N
t	376	201	17
t	28	301	\N
t	29	301	\N
t	30	108	\N
t	31	401	\N
t	32	401	\N
t	33	401	\N
t	34	301	\N
t	35	108	\N
t	36	301	\N
t	37	302	\N
t	38	201	\N
t	39	108	\N
t	40	108	\N
t	41	108	\N
t	42	302	\N
t	43	302	\N
t	45	301	\N
t	46	108	\N
t	47	401	\N
t	48	301	\N
t	49	108	\N
t	50	301	\N
t	51	301	\N
t	52	108	\N
t	53	108	\N
t	54	301	\N
t	56	302	\N
t	57	302	\N
t	58	401	\N
t	59	302	\N
t	60	108	\N
t	91	401	\N
t	99	401	\N
f	113	401	\N
f	114	302	\N
f	115	1	\N
f	116	108	\N
f	117	302	\N
f	118	302	\N
f	119	102	\N
f	120	108	\N
t	123	301	\N
t	126	301	\N
t	128	301	\N
t	129	301	\N
t	145	108	\N
t	148	108	\N
t	327	201	14
t	328	108	14
t	330	302	\N
t	331	302	\N
t	332	302	\N
t	167	201	12
t	333	401	\N
t	334	302	\N
t	173	401	13
t	175	102	\N
t	177	301	\N
t	180	302	\N
t	184	302	\N
t	186	301	\N
t	191	102	\N
t	192	401	\N
t	193	302	\N
t	195	108	\N
t	199	301	\N
t	200	301	\N
t	201	1	\N
t	202	1	\N
t	203	108	\N
t	204	401	\N
t	205	401	\N
t	206	301	\N
t	211	102	\N
t	212	302	\N
t	213	102	\N
t	214	302	\N
t	215	401	\N
t	216	302	\N
t	217	401	\N
t	218	102	\N
t	219	401	\N
t	220	102	\N
t	234	301	\N
t	235	301	\N
t	244	201	13
t	245	201	13
t	335	401	\N
t	247	201	13
t	256	301	\N
t	257	301	\N
t	258	108	\N
t	259	301	\N
t	270	108	\N
t	272	302	\N
t	273	302	\N
t	274	108	\N
t	275	302	\N
t	276	102	\N
t	277	102	\N
t	278	401	\N
t	279	108	\N
t	284	201	14
t	287	201	14
t	291	302	\N
t	292	302	\N
t	294	102	\N
t	295	302	\N
t	293	401	\N
t	297	302	\N
t	298	102	\N
t	303	302	\N
t	304	302	\N
t	308	108	\N
t	309	302	\N
t	310	302	\N
t	311	302	\N
t	312	302	\N
t	313	302	\N
t	314	102	\N
t	315	302	\N
t	318	108	14
t	319	201	14
t	326	108	\N
t	336	302	\N
t	337	401	\N
t	347	401	\N
t	349	108	\N
t	368	302	\N
t	374	302	\N
t	377	201	17
t	378	201	17
t	379	401	\N
t	380	401	\N
t	381	1	\N
t	382	302	\N
t	383	302	\N
t	384	301	\N
t	385	301	\N
t	386	302	\N
t	387	102	\N
t	388	102	\N
t	391	108	\N
t	392	401	\N
t	393	302	\N
t	394	108	\N
t	395	401	\N
t	396	301	\N
t	397	401	\N
t	398	401	\N
t	399	102	\N
t	400	102	\N
t	401	1	\N
t	402	102	\N
t	403	108	\N
t	404	302	\N
t	406	301	\N
t	408	301	\N
t	409	302	\N
t	411	1	\N
t	412	301	\N
t	413	302	\N
t	414	108	\N
t	415	108	\N
t	416	108	19
t	417	201	19
t	418	201	19
t	419	401	19
t	420	301	\N
t	421	401	\N
t	422	302	\N
t	423	302	\N
t	424	401	\N
t	426	302	\N
t	427	102	\N
t	428	102	\N
t	431	301	\N
t	432	301	\N
t	433	201	19
t	434	401	\N
t	435	401	\N
t	436	401	\N
t	438	302	\N
t	439	302	\N
t	440	302	\N
t	441	401	\N
t	442	401	\N
t	443	201	\N
t	444	102	\N
t	445	301	\N
t	446	1	\N
t	448	401	\N
t	449	301	\N
t	450	302	\N
t	451	401	\N
t	452	401	\N
t	453	401	20
t	454	301	\N
t	455	302	\N
t	456	108	\N
t	457	102	\N
t	458	302	\N
t	459	102	\N
t	460	302	\N
t	461	108	\N
t	462	401	\N
t	463	201	20
t	465	1	\N
t	466	301	\N
t	467	301	\N
t	468	102	\N
t	469	302	\N
t	470	302	\N
t	471	102	\N
t	472	102	\N
t	473	301	\N
t	474	302	\N
t	475	301	\N
t	476	302	\N
t	477	301	\N
t	478	102	\N
t	479	103	\N
t	480	102	\N
t	481	102	\N
t	482	102	\N
t	483	302	\N
t	484	102	\N
t	485	302	\N
t	486	1	\N
t	487	301	\N
t	488	301	\N
t	489	102	\N
t	490	401	\N
t	491	401	\N
t	492	401	\N
t	493	302	\N
t	494	102	\N
t	497	1	\N
t	498	108	\N
t	499	108	\N
t	500	401	\N
t	501	201	20
t	502	201	20
t	503	108	\N
t	504	301	\N
t	505	301	\N
t	506	108	\N
t	507	302	\N
t	508	401	\N
t	509	108	\N
t	510	108	\N
t	511	108	\N
t	512	401	21
t	513	401	21
t	514	108	21
t	515	201	21
t	516	201	21
t	517	401	\N
t	518	1	\N
t	519	301	\N
t	520	108	\N
t	521	201	21
t	522	301	\N
t	523	301	\N
t	524	401	\N
t	526	301	\N
t	527	302	\N
t	528	302	\N
t	529	302	\N
t	531	401	\N
t	532	302	\N
t	533	108	\N
t	534	1	\N
t	535	301	\N
t	536	301	\N
t	538	401	\N
t	539	108	\N
t	540	108	\N
t	541	301	\N
t	542	102	\N
t	544	301	\N
t	545	302	\N
t	546	1	\N
t	547	301	\N
t	548	302	\N
t	549	108	\N
t	551	301	\N
t	552	1	\N
t	553	401	\N
t	554	301	\N
t	555	1	\N
t	556	401	\N
t	557	301	\N
t	558	201	\N
t	560	201	22
t	561	201	22
t	562	201	22
t	563	201	22
t	564	401	22
t	565	201	22
t	566	201	22
t	567	401	22
t	568	401	22
t	569	401	22
t	570	108	22
t	571	401	\N
t	572	108	\N
t	573	301	\N
t	574	102	\N
t	575	401	\N
t	576	102	\N
t	577	102	\N
t	578	103	\N
t	579	102	\N
t	580	401	\N
t	581	104	\N
t	582	401	\N
t	583	104	\N
t	584	102	\N
t	585	102	\N
t	586	101	\N
t	587	102	\N
t	588	103	\N
t	589	102	\N
t	590	102	\N
t	591	102	\N
t	592	103	\N
t	593	101	\N
t	594	101	\N
t	595	102	\N
t	596	108	\N
t	597	101	\N
t	598	401	\N
t	599	301	\N
t	600	301	\N
t	601	401	\N
t	602	108	\N
t	604	201	23
t	605	107	23
t	606	201	23
t	607	107	23
t	608	107	23
t	609	107	23
t	610	102	23
t	611	102	23
t	612	102	23
t	613	102	23
t	614	102	23
t	615	107	23
t	616	107	23
t	617	108	23
t	618	201	23
t	619	401	23
t	620	107	23
t	621	201	23
t	622	102	23
t	623	102	23
t	624	102	23
t	625	103	23
t	626	301	23
t	627	301	23
t	628	103	23
t	630	401	\N
t	631	102	\N
t	632	102	\N
t	633	108	\N
t	634	401	\N
t	635	108	\N
t	636	401	\N
t	638	301	\N
t	639	103	\N
t	640	102	\N
t	641	101	\N
t	642	401	\N
t	643	301	23
t	644	103	23
t	645	103	23
t	646	107	23
t	647	102	23
t	648	201	23
t	649	107	23
t	650	102	23
t	651	107	23
t	652	107	23
t	653	102	23
t	654	107	23
t	655	301	23
t	656	108	23
t	657	107	24
t	658	401	24
t	659	102	24
t	660	102	24
t	661	107	24
t	662	301	24
t	663	107	24
t	664	107	24
t	665	102	24
t	667	107	24
t	668	107	24
t	669	102	\N
t	670	102	\N
t	671	1	\N
t	672	108	\N
t	673	108	\N
t	674	301	\N
t	675	108	\N
t	676	301	\N
t	677	102	\N
t	678	301	\N
t	679	302	\N
t	680	1	\N
t	681	102	\N
t	682	301	\N
t	683	301	\N
t	684	301	\N
t	687	102	\N
t	688	401	\N
t	689	108	\N
t	690	102	\N
t	691	102	\N
t	692	102	\N
t	693	108	\N
t	694	108	\N
t	695	102	\N
t	696	108	\N
t	697	102	\N
t	698	102	\N
t	699	102	\N
t	701	103	24
t	702	102	24
t	703	201	24
t	704	201	24
t	705	107	24
t	706	107	24
t	707	201	24
t	708	201	24
t	709	1	\N
t	710	301	\N
t	711	302	\N
t	712	302	\N
t	713	108	\N
t	714	108	\N
t	715	108	\N
t	716	301	\N
t	717	401	\N
t	718	302	\N
t	719	108	\N
t	720	102	\N
t	721	102	\N
t	722	102	\N
t	723	102	\N
t	724	108	\N
t	725	201	24
t	727	108	24
t	729	301	\N
t	730	301	\N
t	731	301	\N
t	732	108	\N
t	733	401	\N
t	735	108	\N
t	736	102	\N
t	737	102	\N
t	738	302	\N
t	739	302	\N
t	740	302	\N
t	741	102	\N
t	742	1	\N
t	743	302	\N
t	744	102	\N
t	746	108	\N
t	747	302	\N
t	748	102	\N
t	749	302	\N
t	750	103	25
t	751	201	25
t	752	108	25
t	753	201	25
t	754	201	25
t	755	201	25
t	757	108	\N
t	758	301	\N
t	759	302	\N
t	760	301	\N
t	761	201	\N
t	762	108	\N
t	763	108	\N
t	764	302	\N
t	765	201	25
t	766	108	25
t	773	301	\N
t	774	1	\N
t	775	302	\N
t	777	302	\N
t	778	302	\N
t	779	201	\N
t	780	401	\N
t	781	401	\N
t	782	108	\N
t	783	201	26
t	784	108	26
t	786	201	26
t	789	1	\N
t	790	301	\N
t	791	1	\N
t	792	302	\N
t	793	108	\N
t	794	301	\N
t	795	108	\N
t	796	301	\N
t	797	108	\N
t	798	302	\N
t	799	302	\N
t	800	302	\N
t	801	301	\N
t	803	301	\N
t	804	302	\N
t	805	1	\N
t	806	302	\N
t	807	302	\N
t	808	108	\N
t	809	108	\N
t	815	103	26
t	816	201	26
t	817	201	26
t	818	201	26
t	820	108	\N
t	821	401	\N
t	822	401	\N
t	823	302	\N
t	824	302	\N
t	825	401	\N
t	826	401	\N
t	827	401	\N
t	828	102	\N
t	829	102	\N
t	830	102	\N
t	831	102	\N
t	832	102	\N
t	833	102	\N
t	834	102	\N
t	835	102	\N
t	838	102	\N
t	839	301	\N
t	840	1	\N
t	841	104	\N
t	842	301	\N
t	843	302	\N
t	844	301	\N
t	845	401	\N
t	846	401	\N
t	847	102	\N
t	848	102	\N
t	849	302	\N
t	850	107	\N
t	851	302	\N
t	852	102	\N
t	853	102	\N
t	854	302	\N
t	855	302	\N
t	856	108	\N
t	857	108	\N
t	858	302	\N
t	859	401	\N
t	861	301	\N
t	862	1	\N
t	863	401	\N
t	865	102	\N
t	866	102	\N
t	867	102	\N
t	868	108	\N
t	869	103	27
t	870	201	27
t	871	108	27
t	872	201	27
t	873	201	27
t	874	201	27
t	875	201	27
t	876	301	\N
t	877	108	\N
t	879	302	\N
t	880	302	\N
t	881	102	\N
t	882	107	\N
t	885	1	\N
t	886	301	\N
t	887	102	\N
t	888	108	\N
t	889	102	\N
t	890	301	\N
t	891	102	\N
t	892	108	\N
t	893	108	\N
t	894	401	28
t	895	108	28
t	896	201	28
t	897	201	28
t	898	201	28
t	899	201	28
t	900	201	28
t	901	301	\N
t	902	1	\N
t	904	102	\N
t	905	302	\N
t	907	301	\N
t	908	1	\N
t	909	401	\N
t	910	401	\N
t	911	401	\N
t	912	108	\N
t	913	302	\N
t	914	108	\N
t	915	401	\N
t	918	1	\N
t	919	302	\N
t	920	302	\N
t	921	301	\N
t	922	102	\N
t	923	302	\N
t	924	102	\N
t	925	302	\N
t	926	1	\N
t	927	104	\N
t	928	104	\N
t	929	302	\N
t	930	102	\N
t	931	302	\N
t	932	301	\N
t	933	302	\N
t	934	108	\N
t	935	301	\N
t	936	102	\N
t	937	102	\N
t	938	108	\N
t	939	108	\N
t	940	108	\N
t	941	108	\N
t	942	108	\N
t	943	107	29
t	944	201	29
t	945	108	29
t	946	201	29
t	947	201	29
t	948	201	29
t	949	201	29
t	955	301	\N
t	956	2	\N
t	957	2	\N
t	958	1	\N
t	959	1	\N
t	960	301	\N
t	961	302	\N
t	962	1	\N
t	963	108	\N
t	964	401	\N
t	965	302	\N
t	966	301	\N
t	967	102	\N
t	968	301	\N
t	969	2	\N
t	970	1	\N
t	971	2	\N
t	972	301	\N
t	973	201	\N
t	974	2	\N
t	975	301	\N
t	976	1	\N
t	977	301	\N
t	978	1	\N
t	979	108	\N
t	980	301	\N
t	981	108	\N
t	982	301	\N
t	983	1	\N
t	984	301	\N
t	985	102	\N
t	987	401	\N
t	988	302	\N
t	989	102	\N
t	990	102	\N
t	991	102	\N
t	992	102	\N
t	993	2	\N
t	994	107	\N
t	995	102	\N
t	996	302	\N
t	997	302	\N
t	998	302	\N
t	999	102	\N
t	1000	102	\N
t	1001	302	\N
t	1002	302	\N
t	1003	102	\N
t	1004	108	\N
t	1005	401	\N
t	1006	302	\N
t	1007	102	\N
t	1008	102	\N
t	1009	102	\N
t	1010	401	\N
t	1011	107	\N
t	1012	107	\N
t	1013	401	\N
t	1014	102	\N
t	1015	107	\N
t	1016	107	\N
t	1017	302	\N
t	1018	108	\N
t	1019	107	\N
t	1020	107	\N
t	1021	302	\N
t	1022	401	\N
t	1023	302	\N
t	1024	108	\N
t	1025	108	\N
t	1026	401	\N
t	1027	401	\N
t	1028	401	\N
t	1029	108	\N
t	1030	401	\N
t	1031	401	\N
t	1032	108	\N
t	1033	108	\N
t	1034	401	\N
t	1035	108	\N
t	1036	108	\N
t	1037	107	30
t	1038	108	30
t	1039	201	30
t	1040	201	30
t	1041	201	30
t	1042	201	30
t	1043	201	30
t	1045	102	\N
t	1046	302	\N
t	1047	108	\N
t	1048	301	\N
t	1049	1	\N
t	1050	108	\N
t	1051	107	\N
t	1052	102	\N
t	1053	302	\N
t	1054	102	\N
t	1055	102	\N
t	1056	302	\N
t	1057	102	\N
\.


--
-- Data for Name: divida; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.divida (valor_total, periodiciodade, data_inicio, id) FROM stdin;
121592.98	MENSAL	2017-10-31 20:00:00	7
\.


--
-- Data for Name: fatura; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.fatura (id, cartao_id, data_vencimento, data_fechamento, paga) FROM stdin;
9	6	2020-04-11 00:00:00	2020-03-27 00:00:00	t
12	6	2020-05-11 00:00:00	2020-04-27 00:00:00	t
13	6	2020-06-11 00:00:00	2020-05-27 00:00:00	t
14	6	2020-07-11 00:00:00	2020-06-27 00:00:00	t
17	6	2020-08-11 00:00:00	2020-07-27 00:00:00	t
19	6	2020-09-11 00:00:00	2020-08-27 00:00:00	t
20	6	2020-10-11 00:00:00	2020-09-27 00:00:00	t
21	6	2020-11-11 00:00:00	2020-10-27 00:00:00	t
22	6	2020-12-11 01:00:00	2020-11-27 01:00:00	t
23	6	2021-01-11 00:00:00	2020-12-27 00:00:00	t
24	6	2021-02-11 00:00:00	2021-01-27 00:00:00	t
25	6	2021-03-11 00:00:00	2021-02-27 00:00:00	t
27	6	2021-05-11 00:00:00	2021-04-27 00:00:00	t
26	6	2021-04-11 00:00:00	2021-03-27 00:00:00	t
28	6	2021-06-11 00:00:00	2021-05-27 00:00:00	t
29	6	2021-07-11 00:00:00	2021-06-27 00:00:00	t
30	6	2021-08-11 23:53:32	2021-07-27 23:53:32	t
\.


--
-- Data for Name: investimento; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.investimento (montante, id, periodicidade, rendimento) FROM stdin;
\.


--
-- Data for Name: meta; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.meta (id, mes, ano, valor) FROM stdin;
9	3	2020	2000.00
10	4	2020	2500.00
12	5	2020	2500.00
14	6	2020	2370.00
15	7	2020	2300.00
16	8	2020	2100.00
17	9	2020	2200.00
18	10	2020	2300.00
19	11	2020	2300.00
20	1	2021	2300.00
21	2	2021	2500.00
22	3	2021	2500.00
23	4	2021	2500.00
24	5	2021	2500.00
25	6	2021	2700.00
26	9	2021	2300.00
\.


--
-- Data for Name: movimentacao; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.movimentacao (id, descricao, pagamento, valor, vencimento, debitavel_id, moeda) FROM stdin;
26	COMPRA 3613 EDEKA M PELKOVENST 822 MUENCHEN DE	2020-03-19	11.23	2020-03-18	3	EURO
27	COMPRA 3613 KAMILIA PEREIRA MUENCHEN DE	2020-03-19	200.00	2020-03-17	3	EURO
28	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-03-19	45.52	2020-03-17	3	EURO
29	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-03-19	51.28	2020-03-10	3	EURO
30	LEV ATM 3613 DEU 22201292 Muenchen	2020-03-19	100.00	2020-03-10	3	EURO
31	DD NL08502057 STG MOLLIE PAYM MD17-0000-5033-27	2020-03-19	22.00	2020-03-04	3	EURO
32	DD NL08502057 STG MOLLIE PAYM MD66-0000-2516-37	2020-03-19	2.00	2020-03-04	3	EURO
33	DD NL08502057 STG MOLLIE PAYM MD71-0000-0406-26	2020-03-19	2.00	2020-03-04	3	EURO
34	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-03-19	49.20	2020-03-03	3	EURO
35	LEV ATM 3613 DEU 22201637 Muenchen	2020-03-19	100.00	2020-03-03	3	EURO
36	COMPRA 3613 EDEKA M PELKOVENST 822 MUENCHEN DE	2020-03-19	7.22	2020-03-02	3	EURO
37	Almoco	2020-03-19	5.90	2020-03-18	3	EURO
38	AMZN MKTP DE*2Z7NA2BY5	2020-03-19	75.65	2020-03-03	4	EURO
39	Vodafone GmbH CallYa	2020-03-19	50.00	2020-03-04	4	EURO
40	MVG AUTOMATEN	2020-03-19	88.90	2020-03-09	4	EURO
41	IC CASH 01011446	2020-03-19	90.00	2020-03-11	4	EURO
42	EDEKA M ERIKA MANN 880	2020-03-19	4.98	2020-03-12	4	EURO
43	IZ *SOEREN RABE	2020-03-19	10.00	2020-03-17	4	EURO
45	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-02-25	43.79	2020-02-25	3	EURO
46	LEV ATM 3613 DEU 49001770 DB MUENCHEN D MUENCHE	2020-02-25	105.49	2020-02-25	3	EURO
47	COMPRA 3613 KAMILIA PEREIRA MUENCHEN DE	2020-02-18	200.00	2020-02-18	3	EURO
48	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-02-18	58.17	2020-02-18	3	EURO
49	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE FL 142	2020-02-14	100.00	2020-02-14	3	EURO
50	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-02-13	31.65	2020-02-13	3	EURO
51	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-02-11	56.89	2020-02-11	3	EURO
52	COMPRA 3613 MVG AUTOMATEN MUENCHEN DE	2020-02-11	88.90	2020-02-11	3	EURO
53	LEV ATM 3613 DEU 49001770 DB MUENCHEN D MUENCHE	2020-02-11	105.49	2020-02-11	3	EURO
54	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-02-04	58.69	2020-02-04	3	EURO
56	EDEKA M ERIKA MANN 880	2020-02-04	7.67	2020-02-04	4	EURO
57	EDEKA M ERIKA MANN 880	2020-02-05	3.58	2020-02-05	4	EURO
58	Mollie *WeWash GmbH	2020-02-05	13.00	2020-02-05	4	EURO
59	Ind. Rest. Bollywood	2020-02-06	10.00	2020-02-06	4	EURO
60	body + soul group AG & Co. KG	2020-02-28	94.00	2020-02-28	4	EURO
62	IMPOSTO DO SELO	2020-01-29	0.72	2020-01-29	3	EURO
63	MMD DISPONIBILIZACAO CARTAO DEBITO  7869361	2020-01-29	18.00	2020-01-29	3	EURO
64	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-01-28	53.13	2020-01-28	3	EURO
65	LEV ATM 3613 DEU IC CASH 01011446 MUENCHEN DE	2020-01-23	72.95	2020-01-23	3	EURO
66	COMPRA 3613 EDEKA M PELKOVENST 822 MUENCHEN DE	2020-01-22	16.06	2020-01-22	3	EURO
67	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-01-21	52.03	2020-01-21	3	EURO
68	COMPRA 3613 Saturn Electro-Handels MUnchen DE	2020-01-21	56.98	2020-01-21	3	EURO
69	COMPRA 3613 KAMILIA PEREIRA MUENCHEN DE	2020-01-14	200.00	2020-01-14	3	EURO
70	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-01-14	42.78	2020-01-14	3	EURO
71	LEV ATM 3613 DEU IC CASH 01011446 MUENCHEN DE	2020-01-10	102.95	2020-01-10	3	EURO
72	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-01-09	60.89	2020-01-09	3	EURO
73	COMPRA 3613 MVG AUTOMATEN MUENCHEN DE	2020-01-09	88.90	2020-01-09	3	EURO
74	LEV ATM 3613 DEU REISEBANK FRANKFURT AT FRANKFU	2020-01-07	100.00	2020-01-07	3	EURO
76	Mollie *WeWash GmbH	2020-01-05	7.00	2020-01-05	4	EURO
77	KFC 1039	2020-01-06	6.99	2020-01-06	4	EURO
78	KFC 1039	2020-01-06	1.99	2020-01-06	4	EURO
79	Vodafone GmbH CallYa	2020-01-08	50.00	2020-01-08	4	EURO
80	C & A MUENCHEN-MOOSBAC	2020-01-11	18.00	2020-01-11	4	EURO
81	DM-Drogerie Markt	2020-01-13	12.50	2020-01-13	4	EURO
82	IC CASH 01011446	2020-01-16	60.00	2020-01-16	4	EURO
83	KAIMUG RESTAURANT GMBH	2020-01-21	10.50	2020-01-21	4	EURO
84	EDEKA M ERIKA MANN 880	2020-01-22	4.88	2020-01-22	4	EURO
85	EDEKA M ERIKA MANN 880	2020-01-23	7.77	2020-01-23	4	EURO
86	EDEKA M ERIKA MANN 880	2020-01-24	6.37	2020-01-24	4	EURO
87	Mollie *WeWash GmbH	2020-01-25	20.00	2020-01-25	4	EURO
88	EDEKA BGL BERGWERK 751	2020-01-27	10.60	2020-01-27	4	EURO
89	Vodafone GmbH CallYa	2020-01-28	15.00	2020-01-28	4	EURO
90	IC CASH 01011446	2020-01-28	70.00	2020-01-28	4	EURO
91	body + soul group AG & Co. KG	2020-01-31	94.00	2020-01-31	4	EURO
24	Para Amazon	2020-03-19	200.00	2020-03-05	3	EURO
25	Cobrir Conta	2020-03-19	200.00	2020-03-02	3	EURO
55	Salário	2020-03-19	3278.00	2020-02-27	3	EURO
61	Salário	2020-03-19	3278.00	2020-01-30	3	EURO
75	Cobrir Conta	2020-03-19	500.00	2020-01-07	3	EURO
92	Salário	\N	3185.00	2019-12-30	3	EURO
93	Almoco	2020-03-21	9.75	2020-03-20	3	EURO
94	Almoco	2020-03-21	3.10	2020-03-20	3	EURO
95	Edeka	2020-03-21	16.65	2020-03-20	3	EURO
96	Saque	2020-03-21	100.00	2020-03-20	3	EURO
97	Edeka	2020-03-21	31.60	2020-03-21	3	EURO
44	Salário	2020-03-19	3162.00	2020-03-27	3	EURO
99	We Wash	2020-03-22	21.00	2020-03-22	4	EURO
100	COMPRA 3613 MAX RISCHART S BACKHAU MUENCHEN DE	2019-12-17	18.00	2019-12-17	3	EURO
101	LEV ATM 3613 DEU 22201637 Muenchen	2019-12-17	103.95	2019-12-17	3	EURO
102	COMPRA 3613 MVG AUTOMATEN MUENCHEN DE	2019-12-13	22.10	2019-12-13	3	EURO
103	COMPRA 3613 EDEKA M ERIKA MANN 880 MUENCHEN DE	2019-12-11	5.38	2019-12-11	3	EURO
104	COMPRA 3613 MAX RISCHART S BACKHAU MUENCHEN DE	2019-12-10	18.00	2019-12-10	3	EURO
105	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2019-12-10	37.76	2019-12-10	3	EURO
106	COMPRA 3613 GameStop Deutschland G MUnchen DE	2019-12-10	41.99	2019-12-10	3	EURO
107	LEV ATM 3613 DEU MUENCHEN MUENCHEN DE	2019-12-10	100.00	2019-12-10	3	EURO
108	LEV ATM 3613 DEU IC CASH 01011446 MUENCHEN DE	2019-12-06	72.95	2019-12-06	3	EURO
109	COMPRA 3613 MVG AUTOMATEN MUENCHEN DE	2019-12-06	22.10	2019-12-06	3	EURO
110	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2019-12-03	58.01	2019-12-03	3	EURO
111	LEV ATM 3613 DEU 22201637 Muenchen	2019-12-03	103.95	2019-12-03	3	EURO
112	Cobrir Conta	\N	200.00	2019-12-09	3	EURO
113	Mollie *WeWash GmbH	2019-12-01	21.00	2019-12-01	4	EURO
114	EDEKA M ERIKA MANN 880	2019-12-02	5.78	2019-12-02	4	EURO
115	MUENCHNER BANK EG	2019-12-07	100.00	2019-12-07	4	EURO
116	Vodafone GmbH CallYa	2019-12-10	50.00	2019-12-10	4	EURO
117	Ind. Rest. Bollywood	2019-12-13	13.90	2019-12-13	4	EURO
118	SCHUHBECKS E4 SAT	2019-12-14	11.10	2019-12-14	4	EURO
119	The Spirit of Switzerl	2019-12-14	38.70	2019-12-14	4	EURO
120	body + soul group AG & Co. KG	2019-12-30	94.00	2019-12-30	4	EURO
121	Lieferando	2020-03-25	10.23	2020-03-24	4	EURO
122	Cobrir Conta	\N	100.00	2020-03-25	3	EURO
123	Edeka	2020-03-26	48.96	2020-03-25	4	EURO
124	Body+soul	2020-04-01	94.00	2020-03-31	4	EURO
125	Salário	\N	3162.00	2020-04-30	3	EURO
126	Edeka	2020-04-03	48.30	2020-04-02	3	EURO
127	KFC	2020-04-06	7.29	2020-04-06	3	EURO
128	DM	2020-04-09	1.35	2020-04-08	4	EURO
129	Edeka	2020-04-09	56.60	2020-04-08	3	EURO
132	POUSADA FRANGIPANI 03/05 BROTAS BR	2020-04-10	288.00	2020-03-10	6	REAL
133	ANUIDADE DIFERENCIADA 05/12	2020-04-10	25.00	2020-03-13	6	REAL
134	AmazonPrimeBR SAO PAULO BR	2020-04-10	9.90	2020-03-18	6	REAL
135	NETFLIX.COM SAO PAULO BR	2020-04-10	32.90	2020-03-17	6	REAL
136	Google Music SAO PAULO BR	2020-04-10	16.90	2020-03-16	6	REAL
137	IOF TRANSACOES INTERNACIONAIS	2020-04-10	2.05	2020-03-19	6	REAL
138	STEAMGAMES.COM 425-952-2985 DE	2020-04-10	32.25	2020-03-13	6	REAL
139	Edeka	2020-04-13	11.96	2020-04-11	3	EURO
144	Pagamento fatura 04/2020	2020-04-13	407.00	2020-04-13	5	REAL
145	Condominio	2020-04-15	573.00	2020-04-15	5	REAL
146	Cobrir Conta	\N	100.00	2020-04-13	3	EURO
147	Edeka	2020-04-15	42.73	2020-04-14	3	EURO
148	Metro	2020-04-15	3.30	2020-04-14	3	EURO
149	Amazon	2020-04-15	59.98	2020-04-15	4	EURO
150	Saturn	2020-04-15	32.98	2020-04-15	4	EURO
173	Pousada	2020-04-16	288.00	2020-05-01	6	REAL
174	Almoco	2020-04-16	5.50	2020-04-16	4	EURO
175	Pao	2020-04-17	1.10	2020-04-17	4	EURO
189	DM	2020-04-26	3.50	2020-04-25	4	EURO
159	Pousada	2020-04-15	288.00	2020-04-15	6	REAL
167	Steam Games	2020-04-15	11.19	2020-03-28	6	REAL
168	ANUIDADE DIFERENCIADA 06/12	2020-04-16	25.00	2020-04-01	6	REAL
169	AMAZONPRIMEBR SAO PAULO BR	2020-04-16	9.90	2020-04-03	6	REAL
170	NETFLIX.COM SAO PAULO BR	2020-04-16	32.90	2020-04-11	6	REAL
171	GOOGLE NIANTIC INC SAO PAULO BR	2020-04-16	0.48	2020-04-11	6	REAL
172	GOOGLE MUSIC SAO PAULO BR	2020-04-16	16.90	2020-04-14	6	REAL
184	Almoco	2020-04-23	9.90	2020-04-22	4	EURO
177	Edeka	2020-04-20	29.71	2020-04-18	3	EURO
178	Almoco	2020-04-20	5.50	2020-04-17	4	EURO
179	Café da amanha	2020-04-20	1.10	2020-04-18	4	EURO
180	Almoco	2020-04-20	6.80	2020-04-20	4	EURO
181	Cobrir Conta	\N	200.00	2020-04-20	3	EURO
182	Almoco	2020-04-22	6.80	2020-04-21	4	EURO
183	Edeka	2020-04-23	39.38	2020-04-22	3	EURO
185	Almoco	2020-04-24	6.80	2020-04-23	4	EURO
186	Edeka	2020-04-26	26.16	2020-04-25	3	EURO
187	Almoco	2020-04-26	7.50	2020-04-24	4	EURO
188	Muller	2020-04-26	1.59	2020-04-24	4	EURO
190	IOF	2020-04-26	0.71	2020-04-23	6	REAL
191	Cafe da manha	2020-04-27	1.10	2020-04-27	4	EURO
192	DM	2020-04-27	1.00	2020-04-27	4	EURO
193	Almoco	2020-04-27	6.80	2020-04-27	4	EURO
194	Cafe da manha	2020-04-28	1.10	2020-04-28	4	EURO
195	Apartamento 45	2020-04-28	1293.81	2020-04-28	5	REAL
196	Bonus	2020-05-12	4881.50	2020-04-29	3	EURO
197	Edeka	2020-05-12	34.98	2020-04-30	3	EURO
198	Remessa Internacional	2020-05-12	7047.90	2020-05-12	3	REAL
199	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-05-12	27.96	2020-05-04	3	EURO
200	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2020-05-12	44.22	2020-05-07	3	EURO
201	Saque	2020-05-12	100.00	2020-05-11	3	EURO
202	Saque	2020-05-12	100.00	2020-05-11	3	EURO
203	DM	2020-05-12	3.50	2020-05-11	3	EURO
204	Metro	2020-05-12	3.30	2020-05-11	3	EURO
205	Metro	2020-05-12	3.30	2020-05-11	3	EURO
206	Edeka	2020-05-12	8.38	2020-05-11	3	EURO
207	Cobrir Conta	\N	200.00	2020-05-04	3	EURO
208	Eletropaulo	2020-05-12	25.34	2020-04-29	5	REAL
209	05 mai\t TAR PACOTE ITAU ABR/20	2020-05-12	66.10	2020-05-05	5	REAL
210	Pagamento fatura 05/2020	2020-05-11	385.08	2020-05-12	5	REAL
211	Cafe da Manha	2020-05-12	1.10	2020-04-28	4	EURO
212	Almoco	2020-05-12	7.45	2020-04-28	4	EURO
213	Cafe da Manha	2020-05-12	1.10	2020-04-29	4	EURO
214	Almoco	2020-05-12	9.20	2020-04-29	4	EURO
215	DM	2020-05-12	1.00	2020-04-29	4	EURO
216	Almoco	2020-05-12	6.80	2020-04-30	4	EURO
217	Academia	2020-05-12	94.00	2020-04-30	4	EURO
218	Pizza	2020-05-12	10.23	2020-05-01	4	EURO
219	Vodafone	2020-05-12	25.00	2020-05-02	4	EURO
220	Cafe da manha	2020-05-12	1.10	2020-05-12	4	EURO
221	BAECKEREI ZIEGLER	2020-05-12	6.80	2020-05-05	4	EURO
222	Mollie *WeWash GmbH	2020-05-12	14.00	2020-05-05	4	EURO
223	BAECKEREI ZIEGLER	2020-05-12	6.80	2020-05-06	4	EURO
224	BAECKEREI ZIEGLER	2020-05-12	3.10	2020-05-06	4	EURO
225	BAECKEREI ZIEGLER	2020-05-12	6.80	2020-05-07	4	EURO
226	BAECKEREI ZIEGLER	2020-05-12	5.50	2020-05-08	4	EURO
227	MUENCHNER BANK EG	2020-05-12	100.00	2020-05-09	4	EURO
228	Baeckerei Ziegler	2020-05-12	1.10	2020-05-11	4	EURO
229	Baeckerei Ziegler	2020-05-12	6.80	2020-05-11	4	EURO
230	Baeckerei Ziegler	2020-05-12	6.80	2020-05-12	4	EURO
231	Anuidade	2020-05-12	25.00	2020-05-01	6	REAL
232	Amazon Prime	2020-05-12	9.90	2020-05-03	6	REAL
234	Edeka	2020-05-19	39.35	2020-05-14	3	EURO
235	Edeka	2020-05-19	11.71	2020-05-16	3	EURO
236	Almoco	2020-05-19	6.80	2020-05-18	4	EURO
237	Cafe da Manha	2020-05-19	1.10	2020-05-18	4	EURO
238	Almoco	2020-05-19	6.80	2020-05-15	4	EURO
239	Almoco	2020-05-19	6.80	2020-05-14	4	EURO
240	Almoco	2020-05-19	8.60	2020-05-13	4	EURO
241	Cafe da Manha	2020-05-19	1.10	2020-05-13	4	EURO
242	Pizza	2020-05-19	10.23	2020-05-12	4	EURO
243	Condominio	2020-05-19	573.00	2020-05-15	5	REAL
244	Netflix	2020-05-19	32.90	2020-05-11	6	REAL
245	Google Music	2020-05-19	16.90	2020-05-14	6	REAL
247	Niantic	2020-05-19	1.90	2020-05-15	6	REAL
248	Niantic 2	2020-05-19	1.90	2020-05-15	6	REAL
233	Salario	2020-05-29	3428.00	2020-05-29	3	EURO
249	Cobrir Conta	\N	200.00	2020-05-26	3	EURO
256	Edeka	2020-05-29	43.45	2020-05-21	3	EURO
257	Edeka	2020-05-29	13.44	2020-05-25	3	EURO
258	Metro	2020-05-29	6.60	2020-05-28	3	EURO
259	Edeka	2020-05-29	59.00	2020-05-28	3	EURO
260	Almoco	2020-05-29	9.90	2020-05-27	4	EURO
261	Cafe Da Manha	2020-05-29	1.10	2020-05-28	4	EURO
262	Almoco	2020-05-29	8.50	2020-05-28	4	EURO
263	Pagamento Casa	2020-05-29	100000.00	2020-05-27	5	REAL
264	Prestacao Casa	2020-05-29	1291.12	2020-05-27	5	REAL
265	Edeka	2020-06-04	4.60	2020-06-03	3	EURO
266	Metro	2020-06-04	6.60	2020-06-03	3	EURO
267	Havaiana	2020-06-04	10.39	2020-06-03	3	EURO
268	Cobrir Conta	\N	200.00	2020-06-03	3	EURO
270	Academia	2020-06-04	94.00	2020-05-26	4	EURO
272	Almoco	2020-06-04	6.80	2020-05-29	4	EURO
273	Almoco	2020-06-04	8.70	2020-05-30	4	EURO
274	Celular	2020-06-04	50.00	2020-06-02	4	EURO
275	Almoco	2020-06-04	9.90	2020-06-03	4	EURO
276	Cafe Da Manha	2020-06-04	6.60	2020-06-03	4	EURO
277	Cafe Da Manha	2020-06-04	6.60	2020-06-04	4	EURO
278	Eletropaulo	2020-06-04	25.42	2020-05-29	5	REAL
279	Pacote Itau	2020-06-04	66.10	2020-06-02	5	REAL
287	Google Niantic	2020-06-04	1.90	2020-06-02	6	REAL
288	Edeka	2020-06-08	44.46	2020-06-05	3	EURO
284	Steam Games	2020-06-04	64.19	2020-05-28	6	REAL
285	Isabela Flores	2020-06-04	249.90	2020-05-29	6	REAL
286	Anuidade	2020-06-04	25.00	2020-05-31	6	REAL
289	Edeka	2020-06-08	11.82	2020-06-06	3	EURO
290	Saturn	2020-06-08	7.99	2020-06-06	3	EURO
291	Almoco	2020-06-08	6.80	2020-06-04	4	EURO
292	Almoco	2020-06-08	6.80	2020-06-05	4	EURO
293	We Wash	2020-06-08	7.00	2020-06-05	4	EURO
294	Cafe da Manha	2020-06-08	1.10	2020-06-08	4	EURO
295	Almoco	2020-06-08	6.80	2020-06-08	4	EURO
296	Edeka	2020-06-10	41.94	2020-06-09	3	EURO
297	Almoco	2020-06-10	6.80	2020-06-09	4	EURO
298	Cafe Da Manha	2020-06-10	6.60	2020-06-09	4	EURO
299	Saque	2020-06-15	100.00	2020-06-12	3	EURO
300	Metro	2020-06-15	6.60	2020-06-12	3	EURO
301	Kamila	2020-06-15	200.00	2020-06-12	3	EURO
302	Edeka	2020-06-15	13.83	2020-06-13	3	EURO
303	KFC	2020-06-15	7.29	2020-06-12	4	EURO
304	Almoco	2020-06-15	6.80	2020-06-10	4	EURO
306	Condomio	2020-06-25	573.00	2020-06-15	5	REAL
307	Pagamento fatura 06/2020	2020-06-15	376.50	2020-06-25	5	REAL
308	Pagamento Solange	2020-06-25	220.00	2020-06-17	5	REAL
309	Almoco	2020-06-25	9.90	2020-06-15	4	EURO
310	Almoco	2020-06-25	6.80	2020-06-16	4	EURO
311	Almoco	2020-06-25	7.90	2020-06-17	4	EURO
312	Almoco	2020-06-25	6.80	2020-06-18	4	EURO
313	Almoco	2020-06-25	6.80	2020-06-19	4	EURO
314	Cafe Da Manha	2020-06-25	8.70	2020-06-20	4	EURO
315	Almoco	2020-06-25	7.90	2020-06-24	4	EURO
316	Amazon Prime	2020-06-25	9.90	2020-06-03	6	REAL
317	Netflix	2020-06-25	32.90	2020-06-11	6	REAL
318	Multa	2020-06-25	7.53	2020-06-12	6	REAL
319	Google Music	2020-06-25	16.90	2020-06-14	6	REAL
321	Edeka	2020-06-25	19.79	2020-06-23	3	EURO
322	Edeka	2020-06-25	39.12	2020-06-24	3	EURO
323	Metro	2020-06-25	6.60	2020-06-23	3	EURO
320	Edeka	2020-06-25	36.96	2020-06-17	3	EURO
324	Eletropaulo	2020-07-01	25.20	2020-06-29	5	REAL
325	Apartamento #47	\N	49.12	2020-06-29	5	REAL
326	Apartamento #47	2020-07-01	224.17	2020-06-29	5	REAL
327	IOF Despesas	2020-07-01	4.09	2020-06-24	6	REAL
328	Juros Mora	2020-07-01	0.50	2020-06-24	6	REAL
329	Encargos	2020-07-01	8.09	2020-06-24	6	REAL
330	Almoco	2020-07-01	6.80	2020-06-25	4	EURO
331	Almoco	2020-07-01	6.80	2020-06-26	4	EURO
332	Almoco	2020-07-01	8.70	2020-06-27	4	EURO
333	Uber	2020-07-01	9.31	2020-06-29	4	EURO
334	Edeka	2020-07-01	4.88	2020-06-29	4	EURO
335	Uber	2020-07-01	11.67	2020-06-29	4	EURO
336	Almoco	2020-07-01	10.00	2020-06-30	4	EURO
337	Academia	2020-07-01	94.00	2020-06-30	4	EURO
338	Cobrir Conta	\N	100.00	2020-06-29	3	EURO
340	Edeka	2020-07-01	14.99	2020-06-30	3	EURO
341	Transporte	2020-07-01	55.20	2020-06-30	3	EURO
342	Edeka	2020-07-01	4.49	2020-07-01	3	EURO
269	Salario	2020-07-01	3362.50	2020-06-29	3	EURO
344	Cafe da manha	2020-07-06	6.55	2020-07-02	3	EURO
345	Saque	2020-07-06	105.49	2020-07-03	3	EURO
346	Edeka	2020-07-06	40.29	2020-07-04	3	EURO
347	We Wash	2020-07-06	14.00	2020-07-01	4	EURO
348	Anuidade	2020-07-06	25.00	2020-07-01	6	REAL
349	Pacote Itau	2020-07-06	66.10	2020-07-02	5	REAL
350	Pagamento fatura 07/2020	2020-07-07	420.90	2020-07-07	5	REAL
351	Condominio	2020-07-07	573.00	2020-07-07	5	REAL
352	Pagamento Final Do APTO	\N	21543.86	2020-07-07	5	REAL
353	Edeka	2020-07-13	7.20	2020-07-08	3	EURO
354	Edeka	2020-07-13	4.49	2020-07-10	3	EURO
355	Edeka	2020-07-13	7.80	2020-07-10	3	EURO
356	Saque	2020-07-13	100.00	2020-07-11	3	EURO
357	Depilacao	2020-07-13	200.00	2020-07-11	3	EURO
358	Edeka	2020-07-13	49.47	2020-07-11	3	EURO
367	Reembolso IRS	2020-07-13	644.50	2020-07-13	3	EURO
368	Almoco	2020-07-13	10.00	2020-07-10	4	EURO
369	Edeka	2020-07-21	8.70	2020-07-16	3	EURO
370	Edeka	2020-07-21	8.40	2020-07-17	3	EURO
371	Edeka	2020-07-21	40.50	2020-07-18	3	EURO
372	C&A	2020-07-21	79.82	2020-07-18	3	EURO
373	Cobrir	\N	200.00	2020-07-20	3	EURO
374	Edeka	2020-07-21	4.49	2020-07-17	3	EURO
375	Edeka	2020-07-21	4.49	2020-07-20	4	EURO
376	Amazon	2020-07-21	9.90	2020-07-03	6	REAL
377	Netflix	2020-07-21	32.90	2020-07-11	6	REAL
378	Google Music	2020-07-21	16.90	2020-07-14	6	REAL
379	We Wash	2020-07-27	20.47	2020-07-25	4	EURO
380	Vodaphone	2020-07-27	50.00	2020-07-25	4	EURO
381	Saque	2020-07-27	100.00	2020-07-22	3	EURO
382	Edeka	2020-07-27	5.86	2020-07-24	3	EURO
383	Edeka	2020-07-27	4.49	2020-07-24	3	EURO
384	Edeka	2020-07-27	41.24	2020-07-24	3	EURO
343	Salario	\N	4966.00	2020-07-30	3	EURO
385	Edeka	2020-07-31	6.31	2020-07-29	3	EURO
386	Almoco	2020-07-31	11.60	2020-07-30	4	EURO
387	Cafe Da Manha	2020-07-31	6.55	2020-07-30	4	EURO
388	Janta	2020-07-31	10.23	2020-07-30	4	EURO
390	Remessa Internacional	2020-08-04	7047.90	2020-08-04	3	REAL
391	Pagamento extra fatura	2020-08-04	420.90	2020-07-13	5	REAL
392	Eletropaulo	2020-08-04	25.28	2020-07-29	5	REAL
393	Almoco	2020-08-04	6.60	2020-08-03	3	EURO
394	Transporte	2020-08-04	55.20	2020-08-03	3	EURO
395	Mascaras	2020-08-04	29.23	2020-08-01	3	EURO
396	Edeka	2020-08-04	32.92	2020-08-01	3	EURO
397	Metro	2020-08-04	9.90	2020-08-01	3	EURO
398	Metro Volta	2020-08-04	9.90	2020-08-01	3	EURO
399	Sundae	2020-08-04	1.99	2020-07-31	3	EURO
400	KFC	2020-08-04	7.29	2020-07-31	3	EURO
401	Saque	2020-08-04	100.00	2020-08-01	3	EURO
402	Cafe da manha	2020-08-04	8.70	2020-08-01	4	EURO
403	Academia	2020-08-04	94.00	2020-07-31	4	EURO
404	Almoco	2020-08-04	8.50	2020-07-31	4	EURO
406	Edeka	2020-08-10	19.48	2020-08-08	3	EURO
408	Edeka	2020-08-10	20.16	2020-08-08	3	EURO
409	Almoco	2020-08-10	4.49	2020-08-10	3	EURO
410	Cobrir Conta	\N	200.00	2020-08-11	3	EURO
411	Saque	2020-08-13	100.00	2020-08-11	3	EURO
412	Edeka	2020-08-13	10.17	2020-08-11	3	EURO
413	Almoco	2020-08-13	7.90	2020-08-12	4	EURO
414	Condominio	2020-08-13	573.00	2020-08-11	5	REAL
415	Manutencao Conta	2020-08-13	66.10	2020-08-04	5	REAL
416	Anuidade	2020-08-13	25.00	2020-07-29	6	REAL
417	AmazonPrimeBR SAO PAULO BR	2020-08-13	9.90	2020-08-03	6	REAL
418	NETFLIX.COM SAO PAULO BR	2020-08-13	32.90	2020-08-11	6	REAL
419	we wash	2020-08-13	66.91	2020-08-02	6	REAL
420	Edeka	2020-08-17	52.70	2020-08-14	3	EURO
421	Depilacao	2020-08-17	200.00	2020-08-15	3	EURO
422	Almoco	2020-08-17	6.80	2020-08-14	4	EURO
423	Almoco	2020-08-18	2.93	2020-08-18	4	EURO
424	We Wash	2020-08-18	8.77	2020-08-17	4	EURO
426	Edeka	2020-08-21	5.31	2020-08-19	4	EURO
427	Jantar	2020-08-21	13.13	2020-08-19	4	EURO
428	Cafe da Manha	2020-08-21	6.55	2020-08-21	4	EURO
431	Edeka	2020-08-21	38.86	2020-08-21	3	EURO
432	Cafe da Manha	2020-08-21	4.47	2020-08-20	3	EURO
433	Google Music	2020-08-21	16.90	2020-08-07	6	REAL
434	we wash	2020-08-24	1.95	2020-08-23	4	EURO
435	we wash	2020-08-24	1.95	2020-08-23	4	EURO
436	we wash	2020-08-24	2.92	2020-08-23	4	EURO
437	Cobrir Conta	\N	100.00	2020-08-25	3	EURO
438	Almoco	2020-08-26	8.30	2020-08-25	3	EURO
439	Almoco	2020-08-26	7.74	2020-08-26	3	EURO
440	Almoco	2020-08-26	10.00	2020-08-25	4	EURO
441	Vodaphone	2020-08-26	80.00	2020-08-25	4	EURO
442	Uber	2020-08-26	5.00	2020-08-25	4	EURO
405	Salario	\N	3278.00	2020-08-28	3	EURO
443	Jogo	2020-08-31	24.37	2020-08-29	3	EURO
444	KFC	2020-08-31	9.28	2020-08-29	3	EURO
445	Edeka	2020-08-31	43.27	2020-08-29	3	EURO
446	Saque	2020-08-31	100.00	2020-08-28	3	EURO
447	Salario	\N	3278.00	2020-09-30	3	EURO
448	Academia	2020-09-01	94.00	2020-08-31	4	EURO
449	Edeka	2020-09-04	34.18	2020-09-03	3	EURO
450	Edeka	2020-09-04	9.60	2020-09-02	3	EURO
451	WeWash	2020-09-04	6.82	2020-09-01	4	EURO
452	Pacote banco	2020-09-04	66.10	2020-09-02	5	REAL
453	Anuidade	2020-09-04	25.00	2020-09-01	6	REAL
454	Edeka	2020-09-10	13.77	2020-09-09	3	EURO
455	Edeka	2020-09-10	8.42	2020-09-09	3	EURO
456	Transporte	2020-09-10	55.20	2020-09-09	3	EURO
457	Cafe Da Manha	2020-09-10	6.55	2020-09-08	4	EURO
458	Almoco	2020-09-10	10.00	2020-09-08	4	EURO
459	Pizza	2020-09-10	6.40	2020-09-08	4	EURO
460	Edeka	2020-09-10	7.12	2020-09-09	4	EURO
461	Condominio	2020-09-10	573.00	2020-09-10	5	REAL
462	Eletropaulo	2020-09-10	26.31	2020-09-02	5	REAL
463	Amazon Prime	2020-09-10	9.90	2020-09-03	6	REAL
464	Cobrir Conta	\N	200.00	2020-09-15	3	EURO
465	Saque	2020-09-17	100.00	2020-09-15	3	EURO
466	Edeka	2020-09-17	38.57	2020-09-15	3	EURO
467	Dm	2020-09-17	10.14	2020-09-15	3	EURO
468	Bar	2020-09-17	24.00	2020-09-16	3	EURO
469	Edeka	2020-09-17	2.93	2020-09-16	3	EURO
470	Almoco	2020-09-17	6.80	2020-09-10	4	EURO
471	cafe da manha	2020-09-17	6.55	2020-09-17	4	EURO
472	Cafe da manha	2020-09-17	6.55	2020-09-11	4	EURO
473	Edeka	2020-09-17	33.89	2020-09-17	3	EURO
474	Almoco	2020-09-17	6.80	2020-09-17	4	EURO
475	Aldi	2020-09-24	6.54	2020-09-22	3	EURO
476	Edeka	2020-09-24	2.93	2020-09-23	3	EURO
477	Edeka	2020-09-24	29.68	2020-09-23	3	EURO
478	Cervejada	2020-09-24	13.00	2020-09-17	4	EURO
479	Uber	2020-09-24	11.41	2020-09-17	4	EURO
480	Cafe Da Manha	2020-09-24	5.50	2020-09-18	4	EURO
481	Mc Donalds	2020-09-24	4.38	2020-09-20	4	EURO
482	Cafe Da Manha	2020-09-24	6.55	2020-09-21	4	EURO
483	Almoco	2020-09-24	7.90	2020-09-23	4	EURO
484	Cafe Da Manha	2020-09-24	6.55	2020-09-23	4	EURO
485	Almoco	2020-09-24	10.00	2020-09-22	4	EURO
486	Saque	2020-10-01	100.00	2020-09-30	3	EURO
487	Edeka	2020-10-01	24.13	2020-09-30	3	EURO
488	Edeka	2020-10-01	25.82	2020-09-29	3	EURO
489	KFC	2020-10-01	7.29	2020-09-24	3	EURO
490	WeWash	2020-10-01	3.90	2020-10-01	4	EURO
491	N26 Desconto	2020-10-01	3.00	2020-09-30	4	EURO
492	WeWash	2020-10-01	21.45	2020-09-28	4	EURO
493	Almoco	2020-10-01	6.80	2020-09-24	4	EURO
494	Cafe Da Manha	2020-10-01	6.80	2020-09-26	4	EURO
495	Salario	\N	3278.00	2020-10-30	3	EURO
496	Cobrir Conta	\N	200.00	2020-10-02	3	EURO
497	Saque	2020-10-06	100.00	2020-10-05	3	EURO
498	Solange	2020-10-06	660.00	2020-10-05	5	REAL
499	Manutencao	2020-10-06	66.10	2020-10-02	5	REAL
500	Eletropaulo	2020-10-06	26.45	2020-09-29	5	REAL
501	Netflix	2020-10-06	32.90	2020-09-11	6	REAL
502	Google Music	2020-10-06	16.90	2020-09-14	6	REAL
503	Transporte	2020-10-12	55.20	2020-10-10	3	EURO
504	Edeka	2020-10-12	34.80	2020-10-10	3	EURO
505	Edeka	2020-10-12	48.41	2020-10-08	3	EURO
506	VodaPhone	2020-10-12	25.00	2020-10-07	4	EURO
507	Almoco	2020-10-15	3.95	2020-10-14	3	EURO
508	Limpeza	2020-10-15	400.00	2020-10-14	5	REAL
509	Presente Vo	2020-10-15	450.00	2020-10-14	5	REAL
510	Documento Casa	2020-10-15	650.00	2020-10-14	5	REAL
511	Condominio	2020-10-15	573.00	2020-10-14	5	REAL
512	DECOLAR GUARULHOS BR	2020-10-15	134.85	2020-09-29	6	REAL
514	ANUIDADE DIFERENCIADA 12/12	2020-10-15	25.00	2020-09-30	6	REAL
515	AmazonPrimeBR SAO PAULO BR	2020-10-15	9.90	2020-10-03	6	REAL
516	NETFLIX.COM SAO PAULO BR	2020-10-15	32.90	2020-10-11	6	REAL
517	Depilacao	2020-10-23	200.00	2020-10-19	3	EURO
518	Saque	2020-10-23	100.00	2020-10-19	3	EURO
519	Edeka	2020-10-23	32.42	2020-10-19	3	EURO
520	Academia	2020-10-23	107.00	2020-10-15	4	EURO
521	Google Music	2020-10-23	16.90	2020-10-14	6	REAL
522	Edeka	2020-10-26	20.13	2020-10-24	3	EURO
523	Edeka	2020-10-26	23.17	2020-10-22	3	EURO
524	WeWash	2020-10-26	20.47	2020-10-24	4	EURO
525	Cobrir Conta	\N	200.00	2020-10-28	3	EURO
526	Edeka	2020-10-29	30.00	2020-10-28	3	EURO
527	Almoco	2020-10-29	6.80	2020-10-27	4	EURO
528	Almoco	2020-10-29	6.80	2020-10-28	4	EURO
529	Almoco	2020-10-29	6.80	2020-10-29	4	EURO
531	Body and Soul	2020-11-02	94.00	2020-10-30	4	EURO
532	KFC	2020-11-02	7.99	2020-10-30	4	EURO
533	Eletropaulo	2020-11-02	26.32	2020-10-29	5	REAL
513	BRITISH AIRW3778194563 SAO PAULO BR	2020-10-15	4307.08	2020-09-29	6	REAL
534	Saque	2020-11-02	100.00	2020-10-31	3	EURO
535	Edeka	2020-11-02	25.74	2020-10-31	3	EURO
536	Edeka	2020-11-06	21.31	2020-11-06	3	EURO
538	Vodaphone	2020-11-06	80.00	2020-11-05	4	EURO
539	Tarifa Doc	2020-11-06	11.10	2020-11-04	5	REAL
540	Pacote Itau	2020-11-06	66.10	2020-11-04	5	REAL
541	Edeka	2020-11-09	22.65	2020-11-07	3	EURO
542	Pizza	2020-11-12	10.23	2020-11-11	4	EURO
543	Pagamento fatura 11/2020	2020-11-12	4526.63	2020-11-13	5	REAL
544	Edeka	2020-11-13	36.45	2020-11-12	3	EURO
545	Almoco	2020-11-13	6.80	2020-11-12	3	EURO
546	Saque	2020-11-16	100.00	2020-11-13	3	EURO
547	Edeka	2020-11-16	23.34	2020-11-16	3	EURO
548	Almoco	2020-11-16	6.40	2020-11-13	4	EURO
549	Condominio	2020-11-16	573.00	2020-11-16	5	REAL
530	Salário	\N	4966.00	2020-11-30	3	EURO
550	cobrir conta	\N	200.00	2020-11-23	3	EURO
551	Edeka	2020-11-29	4.31	2020-11-27	3	EURO
552	Saque	2020-11-29	100.00	2020-11-27	3	EURO
553	Metro	2020-11-29	6.60	2020-11-26	3	EURO
554	Edeka	2020-11-29	2.87	2020-11-26	3	EURO
555	saque	2020-11-29	100.00	2020-11-26	3	EURO
556	Metro	2020-11-29	6.60	2020-11-20	3	EURO
557	Edeka	2020-11-29	28.76	2020-11-23	3	EURO
558	Diablo	2020-11-29	7.29	2020-11-17	4	EURO
560	steam	2020-11-29	3.31	2020-10-31	6	REAL
561	steam	2020-11-29	4.13	2020-11-01	6	REAL
562	amazom prime	2020-11-29	9.90	2020-11-03	6	REAL
563	netflix	2020-11-29	32.90	2020-11-11	6	REAL
564	Multa por Atraso	2020-11-29	90.53	2020-11-11	6	REAL
565	Niantic	2020-11-29	1.90	2020-11-17	6	REAL
566	Apple plus	2020-11-29	9.90	2020-11-20	6	REAL
567	Decolar	2020-11-29	361.88	2020-11-25	6	REAL
568	iof	2020-11-29	0.47	2020-11-26	6	REAL
569	juros de mora	2020-11-29	1.50	2020-11-26	6	REAL
570	Encargos	2020-11-29	32.37	2020-11-18	6	REAL
571	We Wash	2020-12-16	11.70	2020-12-01	4	EURO
572	academina	2020-12-16	94.00	2020-11-30	4	EURO
573	RSHOP-CARREFOUR S	2020-12-16	113.74	2020-12-02	5	REAL
574	RSHOP-PAG*FATIMAM	2020-12-16	16.00	2020-12-02	5	REAL
575	TAR PACOTE ITAU   NOV/20	2020-12-16	66.10	2020-12-02	5	REAL
576	RSHOP-PAG*FATIMAM	2020-12-16	12.00	2020-12-04	5	REAL
577	RSHOP-PAG*ItalvaP	2020-12-16	6.63	2020-12-07	5	REAL
578	INT TED 237195600184071	2020-12-16	520.00	2020-12-08	5	REAL
579	RSHOP-PAG*ItalvaP	2020-12-16	7.00	2020-12-08	5	REAL
580	RSHOP-DROG SAO PA	2020-12-16	47.87	2020-12-10	5	REAL
581	RSHOP-LOJAS RENNE	2020-12-16	79.80	2020-12-10	5	REAL
582	RSHOP-REIKI TERAP	2020-12-16	60.00	2020-12-10	5	REAL
583	RSHOP-SP MOOCA PL	2020-12-16	49.90	2020-12-10	5	REAL
584	RSHOP-BEAT BURGER	2020-12-16	53.70	2020-12-11	5	REAL
585	RSHOP-JARDINEIRA	2020-12-16	25.10	2020-12-11	5	REAL
586	RSHOP-POSTO MANTO	2020-12-16	100.00	2020-12-11	5	REAL
587	RSHOP-HOTEL RESTA	2020-12-16	86.00	2020-12-14	5	REAL
588	RSHOP-MERCPAGO	2020-12-16	95.00	2020-12-13	5	REAL
589	RSHOP-PAG*Darlete	2020-12-16	27.00	2020-12-13	5	REAL
590	RSHOP-PAG*FABRICI	2020-12-16	27.00	2020-12-15	5	REAL
591	RSHOP-PAMONHAS DE	2020-12-16	8.50	2020-12-14	5	REAL
592	RSHOP-POSTO BEIRA	2020-12-16	300.00	2020-12-14	5	REAL
593	RSHOP-POSTO PETRO	2020-12-16	115.90	2020-12-14	5	REAL
594	RSHOP-REDE 500 CO	2020-12-16	197.40	2020-12-14	5	REAL
595	RSHOP-UAI QUEIJAR	2020-12-16	41.80	2020-12-14	5	REAL
596	INT PAG TIT 109005210021	2020-12-16	573.00	2020-12-15	5	REAL
597	RSHOP-POSTO 5	2020-12-16	76.20	2020-12-15	5	REAL
598	DA  ELETROPAULO 56301179	2020-12-16	26.16	2020-11-30	5	REAL
599	RSHOP-CARREFOUR S	2020-12-16	1.00	2020-11-30	5	REAL
600	RSHOP-CARREFOUR S	2020-12-16	28.88	2020-11-30	5	REAL
601	RSHOP-PAG*SLViage	2020-12-16	192.50	2020-11-30	5	REAL
602	RSHOP-SODIMAC ANC	2020-12-16	73.80	2020-11-30	5	REAL
603	Pagamento fatura 12/2020	2020-12-11	548.79	2020-12-16	5	REAL
604	STEAMGAMES.COM 4259522 Hamburg DE	2020-12-17	8.71	2020-12-01	6	REAL
605	UBER * *TRIP Sao Paulo BR	2020-12-17	9.26	2020-12-01	6	REAL
606	AmazonPrimeBR SAO PAULO BR	2020-12-17	9.90	2020-12-03	6	REAL
607	UBER * *TRIP Sao Paulo BR	2020-12-17	11.76	2020-12-01	6	REAL
608	UBER *TRIP Sao Paulo BR	2020-12-17	17.17	2020-12-15	6	REAL
609	UBER* TRIP SAO PAULO BR	2020-12-17	19.84	2020-12-10	6	REAL
610	ifood *IFOOD OSASCO BR	2020-12-17	19.90	2020-12-08	6	REAL
611	ifood *IFOOD OSASCO BR	2020-12-17	20.00	2020-12-06	6	REAL
612	ifood *IFOOD OSASCO BR	2020-12-17	21.79	2020-12-06	6	REAL
613	ifood *IFOOD OSASCO BR	2020-12-17	21.79	2020-12-07	6	REAL
614	ifood *IFOOD OSASCO BR	2020-12-17	22.00	2020-12-05	6	REAL
615	UBER *TRIP Sao Paulo BR	2020-12-17	24.51	2020-12-11	6	REAL
616	UBER* TRIP SAO PAULO BR	2020-12-17	25.17	2020-12-10	6	REAL
617	ANUIDADE DIFERENCIADA 02/12	2020-12-17	26.00	2020-12-01	6	REAL
618	The Walt Disney Compan SAO PAULO BR	2020-12-17	27.90	2020-12-06	6	REAL
619	SERVICOS CLA*119617506 RIO DE JANEIR BR	2020-12-17	30.00	2020-11-29	6	REAL
620	UBER *TRIP Sao Paulo BR	2020-12-17	30.50	2020-12-10	6	REAL
621	NETFLIX.COM SAO PAULO BR	2020-12-17	32.90	2020-12-11	6	REAL
622	ifood *IFOOD OSASCO BR	2020-12-17	39.00	2020-12-15	6	REAL
623	IFD*BR JUNDIAI BR	2020-12-17	43.14	2020-11-29	6	REAL
624	ifood *IFOOD OSASCO BR	2020-12-17	43.90	2020-12-09	6	REAL
625	LOCALIZA RAC ACCAE1 01/10 SAO CAETANO BR	2020-12-17	82.62	2020-12-15	6	REAL
626	CARREFOUR.COM CAJAMAR BR	2020-12-17	147.98	2020-12-08	6	REAL
627	CARREFOUR.COM CAJAMAR BR	2020-12-17	312.10	2020-11-29	6	REAL
628	KLM BSP TLS SAO PAULO BR	2020-12-17	6239.27	2020-11-25	6	REAL
629	Salario	\N	3280.00	2020-12-30	3	EURO
630	Academia	2020-12-31	94.00	2020-12-30	4	EURO
631	Cafe da manha'	2020-12-31	18.60	2020-12-31	5	REAL
632	Cafe da manha'	2020-12-31	15.13	2020-12-30	5	REAL
633	LUz	2020-12-31	32.20	2020-12-29	5	REAL
634	Exame	2020-12-31	200.00	2020-12-29	5	REAL
635	internet	2020-12-31	34.83	2020-12-28	5	REAL
636	Exame 2	2020-12-31	298.00	2020-12-28	5	REAL
637	Acerto Viajem	2020-12-31	125.25	2020-12-21	5	REAL
638	Mercado	2020-12-31	8.49	2020-12-21	5	REAL
639	outback	2020-12-31	71.81	2020-12-21	5	REAL
640	Pastel	2020-12-31	14.00	2020-12-19	5	REAL
641	Gasolina	2020-12-31	171.00	2020-12-18	5	REAL
642	Cabelereiro	2020-12-31	55.00	2020-12-18	5	REAL
643	IFD*BR JUNDIAI BR	2020-12-31	85.62	2020-12-17	6	REAL
644	CONECTCAR CARRO LOCALI BARUERI BR	2020-12-31	55.09	2020-12-18	6	REAL
645	CONECTCAR CARRO LOCALI BARUERI BR	2020-12-31	62.19	2020-12-18	6	REAL
646	UBER *TRIP Sao Paulo BR	2020-12-31	13.96	2020-12-19	6	REAL
647	ifood *IFOOD OSASCO BR	2020-12-31	28.00	2020-12-19	6	REAL
648	APPLE,COM/BILL SAO PAULO BR	2020-12-31	9.90	2020-12-20	6	REAL
649	UBER *TRIP Sao Paulo BR	2020-12-31	18.82	2020-12-21	6	REAL
650	ifood *IFOOD OSASCO BR	2020-12-31	19.99	2020-12-21	6	REAL
651	UBER *TRIP Sao Paulo BR	2020-12-31	24.47	2020-12-21	6	REAL
652	UBER *TRIP Sao Paulo BR	2020-12-31	17.62	2020-12-21	6	REAL
653	ifood *IFOOD OSASCO BR	2020-12-31	32.59	2020-12-21	6	REAL
654	UberBR UBER * PENDING SAO PAULO BR	2020-12-31	23.20	2020-12-22	6	REAL
655	IFD*BR JUNDIAI BR	2020-12-31	86.04	2020-12-23	6	REAL
656	IOF TRANSACOES INTERNACIONAIS	2020-12-31	0.55	2020-12-27	6	REAL
657	UBER *TRIP Sao Paulo BR	2020-12-31	16.73	2020-12-29	6	REAL
658	Rappi Brasil Intermedi Sao Paulo BR	2020-12-31	21.74	2020-12-29	6	REAL
659	ifood *IFOOD OSASCO BR	2020-12-31	25.90	2020-12-29	6	REAL
660	ifood *IFOOD OSASCO BR	2020-12-31	37.59	2020-12-29	6	REAL
661	UBER *TRIP Sao Paulo BR	2020-12-31	10.79	2020-12-29	6	REAL
662	IFD*BR JUNDIAI BR	2020-12-31	61.05	2020-12-29	6	REAL
663	UBER* TRIP SAO PAULO BR	2020-12-31	18.54	2020-12-29	6	REAL
664	UBER *TRIP Sao Paulo BR	2020-12-31	21.92	2020-12-29	6	REAL
665	ifood *IFOOD OSASCO BR	2020-12-31	20.00	2020-12-29	6	REAL
667	Uber	2021-01-01	10.83	2020-12-31	6	REAL
668	Uber	2021-01-01	10.69	2021-01-01	6	REAL
669	Café da Manhã	2021-01-03	29.15	2021-01-02	5	REAL
670	Café da Manhã	2021-01-03	9.26	2021-01-03	5	REAL
671	Saque	2021-01-19	104.00	2021-01-08	3	EURO
672	Manutenção	2021-01-19	5.20	2021-01-08	3	EURO
673	Imposto	2021-01-19	0.21	2021-01-08	3	EURO
674	Edeka	2021-01-19	44.66	2021-01-08	3	EURO
675	Metro	2021-01-19	6.80	2021-01-12	3	EURO
676	Edeka	2021-01-19	9.37	2021-01-12	3	EURO
677	MacDonalds	2021-01-19	8.39	2021-01-12	3	EURO
678	Edeka	2021-01-19	27.45	2021-01-13	3	EURO
679	KFC	2021-01-19	7.79	2021-01-15	3	EURO
680	Saque	2021-01-19	100.00	2021-01-19	3	EURO
681	KFC	2021-01-19	7.79	2021-01-19	3	EURO
682	DM	2021-01-19	17.15	2021-01-19	3	EURO
683	Edeka	2021-01-19	37.61	2021-01-19	3	EURO
666	Salario	\N	3321.00	2021-01-29	3	EURO
684	Edeka	2021-01-19	17.71	2021-01-19	3	EURO
685	Remessa Internacional	2021-01-19	14095.80	2021-01-19	3	REAL
686	Pagamento fatura 01/2021	2021-01-11	7765.15	2021-01-19	5	REAL
687	Comida	2021-01-19	29.50	2021-01-04	5	REAL
688	Teste	2021-01-19	315.00	2021-01-04	5	REAL
689	Pacote Itau	2021-01-19	66.10	2021-01-05	5	REAL
690	Starbucks	2021-01-19	22.70	2021-01-05	5	REAL
691	Comida Aeroporto	2021-01-19	8.00	2021-01-05	5	REAL
692	On the rock	2021-01-19	54.24	2021-01-05	5	REAL
693	Condominio	2021-01-19	573.00	2021-01-08	5	REAL
694	Vivo	2021-01-19	134.99	2021-01-15	5	REAL
695	Café da Manhã	2021-01-19	1.10	2021-01-15	4	EURO
696	Vodafone	2021-01-19	80.00	2021-01-07	4	EURO
697	Comida 1	2021-01-19	2.95	2021-01-06	4	EURO
698	Comida 2	2021-01-19	4.10	2021-01-06	4	EURO
699	Comida 3	2021-01-19	6.00	2021-01-06	4	EURO
700	cobrir conta	\N	200.00	2021-01-20	3	EURO
701	Localiza 02/10	2021-01-21	82.55	2021-01-15	6	REAL
702	Ifood	2021-01-21	51.80	2021-01-03	6	REAL
703	Amazon	2021-01-21	9.90	2021-01-03	6	REAL
704	Steam	2021-01-21	13.99	2021-01-03	6	REAL
705	Uber	2021-01-21	66.06	2021-01-04	6	REAL
706	Uber	2021-01-21	66.79	2021-01-05	6	REAL
707	Disney+	2021-01-21	27.90	2021-01-06	6	REAL
708	Netflix	2021-01-21	32.90	2021-01-11	6	REAL
709	saque	2021-02-01	100.00	2021-01-30	3	EURO
710	Edeka	2021-02-01	39.90	2021-01-29	3	EURO
711	Edeka	2021-02-01	6.90	2021-01-29	3	EURO
712	Edeka	2021-02-01	6.90	2021-01-27	3	EURO
713	Metro	2021-02-01	57.00	2021-01-27	3	EURO
714	Imposto do Selo	2021-02-01	0.78	2021-01-27	3	EURO
715	Cartao	2021-02-01	19.50	2021-01-27	3	EURO
716	Edeka	2021-02-01	27.32	2021-01-25	3	EURO
717	We Wash	2021-02-01	18.00	2021-02-01	4	EURO
718	KFC	2021-02-01	7.79	2021-01-31	4	EURO
719	body and soul	2021-02-01	94.00	2021-01-29	4	EURO
720	Thaifoods	2021-02-01	7.00	2021-01-29	4	EURO
721	Landbae	2021-02-01	5.05	2021-01-29	4	EURO
722	lieferando	2021-02-01	13.00	2021-01-28	4	EURO
723	lieferando	2021-02-01	10.73	2021-01-28	4	EURO
724	Eletropaulo	2021-02-01	27.30	2021-01-29	5	REAL
725	Apple tv	2021-02-01	9.90	2021-01-20	6	REAL
727	IOF	2021-02-01	0.89	2021-01-21	6	REAL
728	Salário	\N	3321.00	2021-02-26	3	EURO
729	Edeka 1	2021-02-13	40.85	2021-02-12	3	EURO
730	Edeka 2	2021-02-13	4.95	2021-02-12	3	EURO
731	Edeka 3	2021-02-13	39.56	2021-02-09	3	EURO
732	Condominio	2021-02-13	573.00	2021-02-12	5	REAL
733	Solange	2021-02-13	880.00	2021-02-11	5	REAL
734	Pagamento fatura 02/2021	2021-02-11	618.46	2021-02-13	5	REAL
735	Pacote Itau	2021-02-13	71.90	2021-02-02	5	REAL
736	KFC 1	2021-02-13	9.49	2021-02-13	4	EURO
737	KFC 2	2021-02-13	7.79	2021-02-11	4	EURO
738	Almoco	2021-02-13	7.80	2021-02-11	4	EURO
739	Almoco 1	2021-02-13	9.75	2021-02-09	4	EURO
740	Almoco 2	2021-02-13	9.95	2021-02-08	4	EURO
741	Cafe da Manha	2021-02-13	6.80	2021-02-02	4	EURO
742	Saque	2021-02-18	100.00	2021-02-18	3	EURO
743	Almoço	2021-02-18	7.90	2021-02-16	3	EURO
744	KFC	2021-02-18	3.00	2021-02-16	3	EURO
745	Cobrir	\N	200.00	2021-02-15	3	EURO
746	Vivo	2021-02-18	135.82	2021-02-17	5	REAL
747	Almoço	2021-02-18	7.80	2021-02-18	4	EURO
748	KFC	2021-02-18	9.49	2021-02-17	4	EURO
749	Almoco	2021-02-18	9.75	2021-02-16	4	EURO
750	Localiza	2021-02-18	82.55	2021-02-18	6	REAL
751	Dead Space	2021-02-18	59.00	2021-02-01	6	REAL
752	Anuidade	2021-02-18	26.00	2021-02-04	6	REAL
753	Amazon Prime	2021-02-18	9.90	2021-02-04	6	REAL
754	Disney+	2021-02-18	27.90	2021-02-06	6	REAL
755	Netflix	2021-02-18	32.90	2021-02-11	6	REAL
756	Cobrir Conta	\N	200.00	2021-02-26	3	EURO
757	Metro	2021-02-27	57.00	2021-02-26	3	EURO
758	Edeka	2021-02-27	32.36	2021-02-27	3	EURO
759	Almoco	2021-02-27	10.30	2021-02-26	3	EURO
760	Edeka	2021-02-27	40.89	2021-02-20	3	EURO
761	Amazon	2021-02-27	49.49	2021-02-26	4	EURO
762	academia	2021-02-27	94.00	2021-02-26	4	EURO
763	we wash	2021-02-27	21.00	2021-02-21	4	EURO
764	Almoco	2021-02-27	10.00	2021-02-19	4	EURO
765	Apple Plus	2021-02-27	9.90	2021-02-15	6	REAL
766	IOF	2021-02-27	3.76	2021-02-16	6	REAL
773	Edeka	2021-03-07	46.66	2021-03-06	3	EURO
774	Saque	2021-03-07	100.00	2021-03-01	3	EURO
775	KFC	2021-03-07	10.99	2021-03-02	3	EURO
776	Amazon Restituicao	2021-03-07	5.00	2021-03-03	4	EURO
777	KFC	2021-03-07	10.99	2021-03-06	4	EURO
778	KFC 2	2021-03-07	10.99	2021-03-05	4	EURO
779	Saturn	2021-03-07	79.99	2021-03-02	4	EURO
780	We Wash	2021-03-07	7.00	2021-03-02	4	EURO
781	Eletropaulo	2021-03-07	73.66	2021-03-04	5	REAL
782	Pacote Itau	2021-03-07	71.90	2021-03-02	5	REAL
783	Spotify	2021-03-07	16.90	2021-02-28	6	REAL
784	Anuidade	2021-03-07	26.00	2021-03-01	6	REAL
786	Amazon	2021-03-07	9.90	2021-03-03	6	REAL
787	Salario	\N	3321.00	2021-03-30	3	EURO
788	Remessa Internacional	2021-04-07	7000.00	2021-04-07	3	REAL
789	Saque	2021-04-07	100.00	2021-04-07	3	EURO
790	Edeka	2021-04-07	32.18	2021-04-06	3	EURO
791	Saque	2021-04-07	100.00	2021-04-06	3	EURO
792	Almoço	2021-04-07	8.90	2021-04-01	3	EURO
793	Taxa transferencia	2021-04-07	47.90	2021-04-07	3	EURO
794	Desodorante	2021-04-07	1.55	2021-03-31	3	EURO
795	Celular	2021-04-07	50.00	2021-03-31	3	EURO
796	Edeka	2021-04-07	37.72	2021-03-30	3	EURO
797	Metro	2021-04-07	57.00	2021-03-26	3	EURO
798	Almoço	2021-04-07	5.70	2021-03-26	3	EURO
799	KFC	2021-04-07	10.99	2021-03-24	3	EURO
800	Almoço 1	2021-04-07	5.95	2021-03-24	3	EURO
801	Edeka 1	2021-04-07	45.76	2021-03-23	3	EURO
802	Cobrir Conta	\N	200.00	2021-03-22	3	EURO
803	Edeka	2021-04-07	42.95	2021-03-16	3	EURO
804	Almoço	2021-04-07	8.60	2021-03-12	3	EURO
805	Saque	2021-04-07	100.00	2021-03-12	3	EURO
806	Almoço	2021-04-07	6.45	2021-03-11	3	EURO
807	Almoço 1	2021-04-07	10.35	2021-03-09	3	EURO
808	Pacote Itau	2021-04-07	71.90	2021-04-05	5	REAL
809	Condominio	2021-04-07	573.00	2021-04-01	5	REAL
810	Aluguel	2021-04-07	2000.00	2021-03-26	5	REAL
811	Pagamento fatura 03/2021	2021-03-09	251.91	2021-04-07	5	REAL
815	Localiza	2021-04-07	82.55	2021-03-14	6	REAL
816	Disney+	2021-04-07	27.90	2021-03-12	6	REAL
817	Livros	2021-04-07	60.97	2021-03-12	6	REAL
818	Netflix	2021-04-07	32.90	2021-03-12	6	REAL
819	Pagamento fatura 04/2021	2021-04-01	257.12	2021-04-07	5	REAL
820	Condominio	2021-04-07	573.00	2021-03-09	5	REAL
821	Eletropaulo	2021-04-07	85.45	2021-03-29	5	REAL
822	Vivo	2021-04-07	134.99	2021-03-15	5	REAL
823	Almoço	2021-04-07	7.80	2021-04-06	4	EURO
824	KFC	2021-04-07	8.49	2021-04-02	4	EURO
825	We Wash	2021-04-07	4.00	2021-04-02	4	EURO
826	Academia	2021-04-07	94.00	2021-03-31	4	EURO
827	We Wash 1	2021-04-07	20.00	2021-03-28	4	EURO
828	KFC 1	2021-04-07	10.99	2021-03-26	4	EURO
829	KFC 2	2021-04-07	10.99	2021-03-21	4	EURO
830	KFC 3	2021-04-07	10.99	2021-03-18	4	EURO
831	Edeka	2021-04-07	10.54	2021-03-16	4	EURO
832	KFC 4	2021-04-07	10.99	2021-03-15	4	EURO
833	KFC 5	2021-04-07	10.99	2021-03-15	4	EURO
834	KFC 6	2021-04-07	10.99	2021-03-12	4	EURO
835	KFC 7	2021-04-07	10.99	2021-03-11	4	EURO
837	Cobrir Conta	\N	200.00	2021-04-26	3	EURO
842	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2021-04-30	47.10	2021-04-20	3	EURO
838	COMPRA 3613 KFC 1039 M?NCHEN DE	2021-04-30	7.99	2021-04-27	3	EURO
839	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2021-04-30	40.48	2021-04-27	3	EURO
840	LEV ATM 3613 DEU 22201850 Muenchen	2021-04-30	100.00	2021-04-21	3	EURO
841	COMPRA 3613 GALERIA Kaufhof Muenchen DE	2021-04-30	59.13	2021-04-20	3	EURO
843	COMPRA 3613 EDEKA M ERIKA MANN 880 MUENCHEN DE	2021-04-30	9.65	2021-04-15	3	EURO
844	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2021-04-30	54.84	2021-04-13	3	EURO
845	Eletropaulo	2021-04-30	167.26	2021-04-29	5	REAL
846	Vivo	2021-04-30	134.08	2021-04-15	5	REAL
847	KFC 1039	2021-04-30	7.99	2021-04-09	4	EURO
848	KFC 1039	2021-04-30	9.49	2021-04-11	4	EURO
849	EDEKA M ERIKA MANN 880	2021-04-30	7.35	2021-04-14	4	EURO
850	UBER   *TRIP	2021-04-30	11.04	2021-04-14	4	EURO
851	BAECKEREI ZIEGLER	2021-04-30	7.80	2021-04-15	4	EURO
852	KFC 1039	2021-04-30	7.79	2021-04-15	4	EURO
853	BAECKEREI ZIEGLER	2021-04-30	2.80	2021-04-17	4	EURO
854	EDEKA M ERIKA MANN 880	2021-04-30	6.95	2021-04-19	4	EURO
855	EDEKA M ERIKA MANN 880	2021-04-30	6.39	2021-04-20	4	EURO
856	Mollie *WeWash GmbH	2021-04-30	22.00	2021-04-27	4	EURO
857	Academia	2021-05-01	94.00	2021-04-30	4	EURO
858	Almoço	2021-05-01	12.90	2021-05-01	4	EURO
859	We Wash	2021-05-01	2.00	2021-05-01	4	EURO
933	COMPRA 3613 EDEKA M ERIKA MANN 880 MUENCHEN DE	2021-06-30	9.04	2021-06-10	3	EURO
836	Salario	\N	6205.13	2021-04-26	3	EURO
861	Edeka	2021-05-03	45.40	2021-05-03	3	EURO
862	Saque	2021-05-03	100.00	2021-05-03	3	EURO
863	Transporte	2021-05-03	57.00	2021-05-03	3	EURO
865	KFC	2021-05-03	9.29	2021-05-02	4	EURO
866	KFC 1	2021-05-03	1.50	2021-05-01	4	EURO
867	KFC 2	2021-05-03	12.78	2021-05-01	4	EURO
868	Presente mae	2021-05-03	500.00	2021-05-03	5	REAL
869	LOCALIZA RAC ACCAE1 05/10 SAO CAET	2021-05-03	82.55	2021-03-29	6	REAL
870	EBANX*SPOTIFY CURITIBA BR	2021-05-03	16.90	2021-03-28	6	REAL
871	ANUIDADE DIFERENCIADA 06/12	2021-05-03	26.00	2021-03-29	6	REAL
872	AmazonPrimeBR SAO PAULO BR	2021-05-03	9.90	2021-04-03	6	REAL
873	Amazon.com.br Digital SAO PAULO BR	2021-05-03	19.90	2021-04-03	6	REAL
874	The Walt Disney Compan SAO PAULO B	2021-05-03	27.90	2021-04-06	6	REAL
875	NETFLIX.COM SAO PAULO BR	2021-05-03	32.90	2021-04-11	6	REAL
876	Edeka	2021-05-08	24.29	2021-05-08	3	EURO
877	Pacote Itau	2021-05-08	71.90	2021-05-04	5	REAL
878	Aluguel Ap	2021-05-08	2000.00	2021-05-05	5	REAL
879	EDEKA M ERIKA MANN 880	2021-05-08	3.58	2021-05-03	4	EURO
880	EDEKA M ERIKA MANN 880	2021-05-08	5.17	2021-05-04	4	EURO
881	Lieferando,de lieferse	2021-05-08	10.54	2021-05-04	4	EURO
882	UBER   *TRIP	2021-05-08	10.81	2021-05-05	4	EURO
885	Saque	2021-05-16	100.00	2021-05-15	3	EURO
886	Edeka	2021-05-16	38.86	2021-05-14	3	EURO
887	KFC	2021-05-16	9.29	2021-05-12	4	EURO
888	Condominio	2021-05-16	573.00	2021-05-16	5	REAL
889	KFC	2021-05-23	7.79	2021-05-22	3	EURO
890	Edeka	2021-05-23	62.31	2021-05-22	3	EURO
891	KFC	2021-05-23	3.00	2021-05-20	4	EURO
892	Comgas	2021-05-23	10.63	2021-05-17	5	REAL
893	Vivo Fixo	2021-05-23	128.98	2021-05-17	5	REAL
894	Localiza	2021-05-23	82.55	2021-05-12	6	REAL
895	Anuidade	2021-05-23	26.00	2021-05-01	6	REAL
896	Spotify	2021-05-23	16.90	2021-05-02	6	REAL
897	Prime	2021-05-23	9.90	2021-05-03	6	REAL
898	Kindle  unlimeted	2021-05-23	19.90	2021-05-05	6	REAL
899	Disney+	2021-05-23	27.90	2021-05-06	6	REAL
900	netflix	2021-05-23	32.90	2021-05-11	6	REAL
860	Salario	\N	3321.00	2021-05-30	3	EURO
901	Edeka	2021-05-28	52.21	2021-05-28	3	EURO
902	Saque	2021-05-28	100.00	2021-05-26	3	EURO
903	Cobrir Conta	\N	200.00	2021-05-24	3	EURO
904	KFC	2021-05-28	9.29	2021-05-26	4	EURO
905	Almoço	2021-05-28	7.80	2021-05-25	4	EURO
907	Edeka	2021-06-05	37.12	2021-06-04	3	EURO
908	Saque	2021-06-05	100.00	2021-06-04	3	EURO
909	Depilação	2021-06-05	200.00	2021-06-01	3	EURO
910	WeWash	2021-06-05	10.00	2021-06-01	4	EURO
911	Vodaphone	2021-06-05	80.00	2021-06-01	4	EURO
912	Academia	2021-06-05	94.00	2021-05-31	4	EURO
913	Edeka	2021-06-05	5.40	2021-05-31	4	EURO
914	Tarifa	2021-06-05	71.90	2021-06-02	5	REAL
915	Luz	2021-06-05	134.11	2021-05-31	5	REAL
934	COMPRA 3613 MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-06-30	57.00	2021-06-09	3	EURO
906	Salario	\N	3471.00	2021-06-28	3	EURO
916	IR Reembolso	2021-06-30	635.00	2021-06-29	3	EURO
917	Cobrir Conta	\N	200.00	2021-06-22	3	EURO
918	LEV ATM 3613 DEU 22201850 Muenchen	2021-06-30	100.00	2021-06-24	3	EURO
919	COMPRA 3613 EDEKA M ERIKA MANN 880  CONTACTLESS	2021-06-30	6.95	2021-06-23	3	EURO
920	COMPRA 3613 KFC 1039 MUNCHEN DE     CONTACTLESS	2021-06-30	9.49	2021-06-23	3	EURO
921	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2021-06-30	35.73	2021-06-22	3	EURO
922	COMPRA 3613 KFC 1039 MUNCHEN DE     CONTACTLESS	2021-06-30	9.29	2021-06-22	3	EURO
923	COMPRA 3613 EDEKA M ERIKA MANN 880  CONTACTLESS	2021-06-30	8.54	2021-06-22	3	EURO
924	COMPRA 3613 KFC 1039 MUNCHEN DE     CONTACTLESS	2021-06-30	9.29	2021-06-17	3	EURO
925	COMPRA 3613 EDEKA M ERIKA MANN 880  CONTACTLESS	2021-06-30	5.40	2021-06-17	3	EURO
926	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLYEIN	2021-06-30	100.00	2021-06-17	3	EURO
927	COMPRA 3613 PUMA Concept Store Muenchen DE	2021-06-30	55.00	2021-06-17	3	EURO
928	COMPRA 3613 GALERIA Kaufhof Muenchen DE	2021-06-30	39.90	2021-06-17	3	EURO
929	COMPRA 3613 EDEKA M ERIKA MANN 880  CONTACTLESS	2021-06-30	5.90	2021-06-17	3	EURO
930	COMPRA 3613 KFC 1039 MUNCHEN DE	2021-06-30	9.29	2021-06-16	3	EURO
931	COMPRA 3613 EDEKA M ERIKA MANN 880 MUENCHEN DE	2021-06-30	6.09	2021-06-16	3	EURO
932	COMPRA 3613 EDEKA CENTER OEZ MUENCHEN DE	2021-06-30	37.60	2021-06-11	3	EURO
935	Edeka	2021-06-30	41.87	2021-06-29	3	EURO
936	KFC	2021-06-30	9.29	2021-06-28	4	EURO
937	McDonnalds	2021-06-30	10.84	2021-06-29	4	EURO
938	academia	2021-06-30	94.00	2021-06-30	4	EURO
939	Condominio	2021-06-30	573.00	2021-06-14	5	REAL
940	Vivo	2021-06-30	134.99	2021-06-15	5	REAL
941	Comgas	2021-06-30	10.86	2021-06-16	5	REAL
942	Eletropaulo	2021-06-30	42.27	2021-06-29	5	REAL
943	LOCALIZA RAC ACCAE1 07/10 SAO CAET	2021-06-30	82.55	2021-06-15	6	REAL
944	EBANX*SPOTIFY CURITIBA	2021-06-30	16.90	2021-06-15	6	REAL
945	ANUIDADE DIFERENCIADA 08/12	2021-06-30	26.00	2021-06-16	6	REAL
946	Amazon.com.br Digital SAO PAULO	2021-06-30	19.90	2021-06-03	6	REAL
947	AmazonPrimeBR SAO PAULO	2021-06-30	9.90	2021-06-03	6	REAL
948	The Walt Disney Compan SAO PAULO	2021-06-30	27.90	2021-06-06	6	REAL
949	NETFLIX.COM SAO PAULO	2021-06-30	32.90	2021-06-11	6	REAL
950	salário	2021-09-04	3381.00	2021-08-30	3	EURO
951	Sálario	2021-09-04	5082.00	2021-07-29	3	EURO
952	Cobrir Conta	\N	200.00	2021-08-27	3	EURO
953	Cobrir Conta	\N	200.00	2021-08-16	3	EURO
954	Cobrir Conta	\N	200.00	2021-07-15	3	EURO
955	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	58.49	2021-08-31	3	EURO
956	Inter Apotheke MUnchen DE	2021-09-04	43.73	2021-08-27	3	EURO
957	SANI PLUS-APOTHEKE MUEN CONTACTLESS	2021-09-04	3.99	2021-08-27	3	EURO
958	LEV ATM 3613 DEU REISEBANK FRANKFURT AT MUENCHE	2021-09-04	104.90	2021-08-27	3	EURO
959	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLY-EIN	2021-09-04	100.00	2021-08-25	3	EURO
960	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	47.99	2021-08-24	3	EURO
961	MODEFRISEUR BLATTER GM  CONTACTLESS	2021-09-04	37.00	2021-08-18	3	EURO
962	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLY.EKZ	2021-09-04	100.00	2021-08-18	3	EURO
963	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-09-04	57.00	2021-08-17	3	EURO
964	KAMILIA PEREIRA MUENCHEN DE	2021-09-04	200.00	2021-08-17	3	EURO
965	BAECKEREI ZIEGLER MUENC CONTACTLESS	2021-09-04	10.15	2021-08-17	3	EURO
966	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	31.24	2021-08-17	3	EURO
967	AUGUSTINER BRAEUSTUBEN  CONTACTLESS	2021-09-04	17.25	2021-08-13	3	EURO
968	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	47.83	2021-08-10	3	EURO
969	SumUp Dr. Ebner Munchen DE	2021-09-04	76.53	2021-08-05	3	EURO
970	LEV ATM 3613 DEU 22201850 Muenchen	2021-09-04	100.00	2021-08-05	3	EURO
971	SumUp Dr. Ebner Munchen DE	2021-09-04	91.05	2021-08-03	3	EURO
972	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	38.33	2021-08-03	3	EURO
973	Saturn Electro Muenchen DE	2021-09-04	12.49	2021-08-03	3	EURO
974	SANI PLUS-APOTHEKE MUEN CONTACTLESS	2021-09-04	11.99	2021-07-27	3	EURO
975	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	39.91	2021-07-27	3	EURO
976	LEV ATM 3613 DEU 22201850 Muenchen	2021-09-04	100.00	2021-07-27	3	EURO
977	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	37.44	2021-07-20	3	EURO
978	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLY-EIN	2021-09-04	100.00	2021-07-16	3	EURO
979	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-09-04	57.00	2021-07-14	3	EURO
980	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	42.81	2021-07-13	3	EURO
981	DB Automaten MUnchen DE	2021-09-04	3.40	2021-07-09	3	EURO
982	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	37.59	2021-07-06	3	EURO
983	LEV ATM 3613 DEU 22201850 Muenchen	2021-09-04	100.00	2021-07-06	3	EURO
984	Edeka	2021-09-04	31.70	2021-09-04	3	EURO
985	Almoço	2021-09-04	6.55	2021-09-02	3	EURO
986	Salario	\N	3381.00	2021-09-30	3	EURO
987	Mollie *WeWash GmbH	2021-09-04	18.00	2021-07-02	4	EURO
988	BAECKEREI ZIEGLER	2021-09-04	5.95	2021-07-02	4	EURO
989	KFC 1039	2021-09-04	9.29	2021-07-02	4	EURO
990	KFC 1039	2021-09-04	9.29	2021-07-05	4	EURO
991	KFC 1039	2021-09-04	9.29	2021-07-07	4	EURO
992	KFC 1039	2021-09-04	9.29	2021-07-12	4	EURO
993	SANI PLUS-APOTHEKE	2021-09-04	2.00	2021-07-13	4	EURO
994	UBER   *TRIP	2021-09-04	12.18	2021-07-14	4	EURO
995	KFC 1039	2021-09-04	9.29	2021-07-19	4	EURO
996	EDEKA M ERIKA MANN 880	2021-09-04	7.05	2021-07-20	4	EURO
997	EDEKA M ERIKA MANN 880	2021-09-04	7.90	2021-07-21	4	EURO
998	EDEKA M ERIKA MANN 880	2021-09-04	6.95	2021-07-22	4	EURO
999	KFC 1039	2021-09-04	9.29	2021-07-22	4	EURO
1000	KFC 1039	2021-09-04	9.29	2021-07-27	4	EURO
1001	BAECKEREI ZIEGLER	2021-09-04	6.55	2021-07-28	4	EURO
1002	EDEKA M ERIKA MANN 880	2021-09-04	8.80	2021-07-28	4	EURO
1003	KFC 1039	2021-09-04	9.29	2021-07-28	4	EURO
1004	body + soul group AG & Co. KG	2021-09-04	94.00	2021-07-30	4	EURO
1005	Mollie *WeWash GmbH	2021-09-04	17.00	2021-08-01	4	EURO
1006	EDEKA M ERIKA MANN 880	2021-09-04	6.95	2021-08-03	4	EURO
1007	KFC 1039	2021-09-04	9.29	2021-08-04	4	EURO
1008	KFC 1039	2021-09-04	9.29	2021-08-08	4	EURO
1009	KFC 1039	2021-09-04	7.79	2021-08-18	4	EURO
1010	Vodafone GmbH CallYa	2021-09-04	80.00	2021-08-19	4	EURO
1011	UBER *TRIP HELP.UBER.C	2021-09-04	10.12	2021-08-22	4	EURO
1012	UBER *TRIP HELP.UBER.C	2021-09-04	19.65	2021-08-22	4	EURO
1013	Mollie *WeWash GmbH	2021-09-04	20.00	2021-08-24	4	EURO
1014	KFC 1039	2021-09-04	9.49	2021-08-25	4	EURO
1015	UBER   *TRIP	2021-09-04	10.71	2021-08-30	4	EURO
1016	UBER   *TRIP	2021-09-04	17.50	2021-08-30	4	EURO
1017	Lilli P.	2021-09-04	11.00	2021-08-31	4	EURO
1018	body + soul group AG & Co. KG	2021-09-04	94.00	2021-08-31	4	EURO
1019	UBER *TRIP HELP.UBER.C	2021-09-04	12.71	2021-09-01	4	EURO
1020	UBER   *TRIP	2021-09-04	12.30	2021-09-02	4	EURO
1021	BAECKEREI ZIEGLER	2021-09-04	7.80	2021-09-02	4	EURO
1022	Mollie *WeWash GmbH	2021-09-04	5.00	2021-09-02	4	EURO
1023	BAECKEREI ZIEGLER	2021-09-04	8.30	2021-09-03	4	EURO
1024	PACOTE ITAU JUN/21	2021-09-04	71.90	2021-07-02	5	REAL
1025	PAG TIT 109005278903	2021-09-04	573.00	2021-07-12	5	REAL
1026	COMGAS 37423975	2021-09-04	9.89	2021-07-14	5	REAL
1027	VIVO FIXO 9324810660	2021-09-04	141.99	2021-07-15	5	REAL
1028	ELETROPAULO 56301179	2021-09-04	29.33	2021-07-29	5	REAL
1029	PACOTE ITAU JUL/21	2021-09-04	71.90	2021-08-03	5	REAL
1030	COMGAS 37423975	2021-09-04	9.89	2021-08-16	5	REAL
1031	VIVO FIXO 9324810660	2021-09-04	141.99	2021-08-16	5	REAL
1032	PAG TIT 109005294967	2021-09-04	573.00	2021-08-23	5	REAL
1033	PAG TIT 109005287151	2021-09-04	584.46	2021-08-24	5	REAL
1034	ELETROPAULO 56301179	2021-09-04	30.78	2021-08-30	5	REAL
1035	TED 364224	2021-09-04	440.00	2021-08-31	5	REAL
1036	PACOTE ITAU AGO/21	2021-09-04	71.90	2021-09-02	5	REAL
1037	LOCALIZA RAC ACCAE1 08/10 SAO CAET	2021-09-04	82.55	2021-07-20	6	REAL
1038	ANUIDADE DIFERENCIADA 09/12	2021-09-04	26.00	2021-07-13	6	REAL
1039	EBANX*SPOTIFY CURITIBA BR	2021-09-04	19.90	2021-07-13	6	REAL
1040	AmazonPrimeBR SAO PAULO BR	2021-09-04	9.90	2021-07-14	6	REAL
1041	Amazon.com.br Digital SAO PAULO BR	2021-09-04	19.90	2021-06-30	6	REAL
1042	The Walt Disney Compan SAO PAULO B	2021-09-04	27.90	2021-06-30	6	REAL
1043	NETFLIX.COM SAO PAULO BR	2021-09-04	32.90	2021-07-03	6	REAL
1044	Remessa Internacional	2021-09-15	14120.76	2021-09-15	3	REAL
1045	KFC	2021-09-15	9.29	2021-09-15	3	EURO
1046	Edeka	2021-09-15	8.80	2021-09-15	3	EURO
1047	Metro	2021-09-15	57.00	2021-09-14	3	EURO
1048	Edeka 2	2021-09-15	37.76	2021-09-11	3	EURO
1049	Saque	2021-09-15	100.00	2021-09-10	3	EURO
1050	Custo transferencia	2021-09-15	2.00	2021-09-15	3	EURO
1051	Uber	2021-09-15	18.84	2021-09-08	4	EURO
1052	KFC	2021-09-15	9.29	2021-09-07	4	EURO
1053	Edeka	2021-09-15	3.95	2021-09-07	4	EURO
1054	cafe da manha	2021-09-15	1.95	2021-09-07	4	EURO
1055	cafe da manha 2	2021-09-15	6.60	2021-09-07	4	EURO
1056	Edeka	2021-09-15	6.95	2021-09-06	4	EURO
1057	cafe da manha 3	2021-09-15	6.60	2021-09-06	4	EURO
\.


--
-- Data for Name: orcamento; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.orcamento (id, tipo_despesa_id, valor, data_inicial, data_final) FROM stdin;
3	301	200.00	2020-03-01 00:00:00	2020-03-31 23:59:59.999
4	301	250.00	2020-02-01 00:00:00	2020-02-29 23:59:59.999
6	302	300.00	2020-04-01 00:00:00	2020-04-30 23:59:59.999
5	301	250.00	2020-04-01 00:00:00	2020-04-30 23:59:59.999
9	301	250.00	2020-05-01 00:00:00	2020-05-31 23:59:59.999
11	302	200.00	2020-05-01 00:00:00	2020-05-31 23:59:59.999
14	301	250.00	2020-06-01 00:00:00	2020-06-30 23:59:59.999
15	301	250.00	2020-07-01 00:00:00	2020-07-31 23:59:59.999
16	301	250.00	2020-08-01 00:00:00	2020-08-31 23:59:59.999
17	301	230.00	2020-09-01 00:00:00	2020-09-30 23:59:59.999
18	301	250.00	2020-10-01 00:00:00	2020-10-31 23:59:59.999
19	301	250.00	2020-11-01 00:00:00	2020-11-30 23:59:59.999
20	301	200.00	2020-11-01 01:00:00	2020-12-01 00:59:59.999
21	301	200.00	2021-01-01 01:00:00	2021-02-01 00:59:59.999
22	301	200.00	2021-02-01 01:00:00	2021-02-28 23:59:59.999
23	301	250.00	2021-03-01 00:00:00	2021-03-31 23:59:59.999
24	301	200.00	2021-04-01 00:00:00	2021-04-30 23:59:59.999
25	301	250.00	2021-05-01 00:00:00	2021-05-31 23:59:59.999
26	301	200.00	2021-06-01 00:00:00	2021-06-30 23:59:59.999
27	301	200.00	2021-09-01 00:00:00	2021-09-30 23:59:59.999
\.


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.parametros (nome, valor, tipo) FROM stdin;
IOF	0.38	PORCENTAGEM
SPOT	0.003	DECIMAL
EURO.REAL	https://economia.uol.com.br/cotacoes/cambio/euro-uniao-europeia/	TEXTO
DEBITAVEL_PRINCIPAL	3	DECIMAL
IGNORE_WORDS	DE COMPRA BR	TEXTO
\.


--
-- Data for Name: receita; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.receita (depositado, id, tipo_receita_id, investimento_id) FROM stdin;
t	44	109	\N
t	55	109	\N
t	61	109	\N
f	92	109	\N
f	125	109	\N
t	196	111	\N
t	233	109	\N
t	269	109	\N
t	367	111	\N
t	343	109	\N
t	405	109	\N
t	447	109	\N
t	495	109	\N
t	530	109	\N
t	629	109	\N
t	637	111	\N
t	666	109	\N
t	728	109	\N
t	776	111	\N
t	787	109	\N
t	810	111	\N
t	836	109	\N
t	878	111	\N
t	860	109	\N
t	906	109	\N
t	916	111	\N
t	950	109	\N
t	951	109	\N
f	986	109	\N
\.


--
-- Data for Name: servico_transferencia; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.servico_transferencia (id, taxas, spred, nome, custo_variavel) FROM stdin;
1	100.00	4.50	Itáu	f
2	\N	2.00	Confidence	t
\.


--
-- Data for Name: tipo_movimentacao; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.tipo_movimentacao (tipo, id, cor, descricao) FROM stdin;
D	101	#99CC00	Gasolina
D	102	#FF8A00	Comida
D	103	#0099CC	Final de Semana
D	104	#8AD5F0	Roupas
D	105	#004E09	Estacionamento
D	106	#C58BE2	Quadrinhos
D	107	#000000	Carro
D	108	#FFBD21	Fixo
R	109	#CC0000	Salário
R	110	#0099CC	Investimentos
R	111	#9933CC	Outros
D	201	#ff0000	Nerdisse
D	301	#00ffe0	Supermercado
D	302	#c658d1	Almoço
D	401	#bdff00	Consumo
D	1	#c9c9c9	Saques
D	2	#f0f261	Medico
\.


--
-- Data for Name: transferencia; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.transferencia (id, creditavel_id, valor_real) FROM stdin;
24	4	200.00
25	4	200.00
75	4	500.00
112	4	200.00
122	4	100.00
144	6	407.00
146	4	100.00
181	4	200.00
198	5	42855.22
207	4	200.00
210	6	385.08
249	4	200.00
268	4	200.00
263	7	100000.00
307	6	376.50
325	7	49.12
338	4	100.00
350	6	420.90
352	7	21543.86
373	4	200.00
390	5	42926.51
410	4	200.00
437	4	100.00
464	4	200.00
496	4	200.00
525	4	200.00
543	6	4526.63
550	4	200.00
603	6	548.79
685	5	87627.29
686	6	7765.15
700	4	200.00
734	6	618.46
745	4	200.00
756	4	200.00
788	5	45422.59
802	4	200.00
811	6	251.91
819	6	257.12
837	4	200.00
903	4	200.00
917	4	200.00
952	4	200.00
953	4	200.00
954	4	200.00
1044	5	85398.49
\.


--
-- Name: cotacao_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.cotacao_id_seq', 5, true);


--
-- Name: debitavel_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.debitavel_id_seq', 7, true);


--
-- Name: fatura_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.fatura_id_seq', 30, true);


--
-- Name: meta_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.meta_id_seq', 26, true);


--
-- Name: movimentacao_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.movimentacao_id_seq', 1057, true);


--
-- Name: orcamento_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.orcamento_id_seq', 27, true);


--
-- Name: servico_transferencia_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.servico_transferencia_id_seq', 2, true);


--
-- Name: tipo_movimentacao_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.tipo_movimentacao_id_seq', 2, true);


--
-- Name: cartao cartao_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.cartao
    ADD CONSTRAINT cartao_pkey PRIMARY KEY (id);


--
-- Name: conta conta_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.conta
    ADD CONSTRAINT conta_pkey PRIMARY KEY (id);


--
-- Name: cotacao cotacao_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.cotacao
    ADD CONSTRAINT cotacao_pkey PRIMARY KEY (id);


--
-- Name: debitavel debitavel_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.debitavel
    ADD CONSTRAINT debitavel_pkey PRIMARY KEY (id);


--
-- Name: despesa despesa_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.despesa
    ADD CONSTRAINT despesa_pkey PRIMARY KEY (id);


--
-- Name: divida divida_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.divida
    ADD CONSTRAINT divida_pkey PRIMARY KEY (id);


--
-- Name: fatura fatura_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.fatura
    ADD CONSTRAINT fatura_pkey PRIMARY KEY (id);


--
-- Name: investimento investimento_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.investimento
    ADD CONSTRAINT investimento_pkey PRIMARY KEY (id);


--
-- Name: meta meta_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.meta
    ADD CONSTRAINT meta_pkey PRIMARY KEY (id);


--
-- Name: movimentacao movimentacao_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.movimentacao
    ADD CONSTRAINT movimentacao_pkey PRIMARY KEY (id);


--
-- Name: orcamento orcamento_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.orcamento
    ADD CONSTRAINT orcamento_pkey PRIMARY KEY (id);


--
-- Name: parametros parametros_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.parametros
    ADD CONSTRAINT parametros_pkey PRIMARY KEY (nome);


--
-- Name: receita receita_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.receita
    ADD CONSTRAINT receita_pkey PRIMARY KEY (id);


--
-- Name: servico_transferencia servico_transferencia_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.servico_transferencia
    ADD CONSTRAINT servico_transferencia_pkey PRIMARY KEY (id);


--
-- Name: tipo_movimentacao tipo_movimentacao_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.tipo_movimentacao
    ADD CONSTRAINT tipo_movimentacao_pkey PRIMARY KEY (id);


--
-- Name: transferencia transferencia_pkey; Type: CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.transferencia
    ADD CONSTRAINT transferencia_pkey PRIMARY KEY (id);


--
-- Name: cartao cartao_debitavel_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.cartao
    ADD CONSTRAINT cartao_debitavel_fk FOREIGN KEY (id) REFERENCES despesas_db.debitavel(id);


--
-- Name: conta conta_debitavel_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.conta
    ADD CONSTRAINT conta_debitavel_fk FOREIGN KEY (id) REFERENCES despesas_db.debitavel(id);


--
-- Name: despesa despesa_fatura; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.despesa
    ADD CONSTRAINT despesa_fatura FOREIGN KEY (fatura_id) REFERENCES despesas_db.fatura(id);


--
-- Name: despesa despesa_movimentacao_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.despesa
    ADD CONSTRAINT despesa_movimentacao_fk FOREIGN KEY (id) REFERENCES despesas_db.movimentacao(id);


--
-- Name: despesa despesa_tipo_movimentacao_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.despesa
    ADD CONSTRAINT despesa_tipo_movimentacao_fk FOREIGN KEY (tipo_despesa_id) REFERENCES despesas_db.tipo_movimentacao(id);


--
-- Name: divida divida_debitavel_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.divida
    ADD CONSTRAINT divida_debitavel_fk FOREIGN KEY (id) REFERENCES despesas_db.debitavel(id);


--
-- Name: fatura fatura_cartao; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.fatura
    ADD CONSTRAINT fatura_cartao FOREIGN KEY (cartao_id) REFERENCES despesas_db.cartao(id);


--
-- Name: investimento investimento_debitavel_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.investimento
    ADD CONSTRAINT investimento_debitavel_fk FOREIGN KEY (id) REFERENCES despesas_db.debitavel(id);


--
-- Name: receita investimento_receita_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.receita
    ADD CONSTRAINT investimento_receita_fk FOREIGN KEY (investimento_id) REFERENCES despesas_db.investimento(id);


--
-- Name: movimentacao movimentacao_debitavel_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.movimentacao
    ADD CONSTRAINT movimentacao_debitavel_fk FOREIGN KEY (debitavel_id) REFERENCES despesas_db.debitavel(id);


--
-- Name: orcamento orcamento_tipo_despesa; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.orcamento
    ADD CONSTRAINT orcamento_tipo_despesa FOREIGN KEY (tipo_despesa_id) REFERENCES despesas_db.tipo_movimentacao(id);


--
-- Name: receita receita_movimentacao_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.receita
    ADD CONSTRAINT receita_movimentacao_fk FOREIGN KEY (id) REFERENCES despesas_db.movimentacao(id);


--
-- Name: receita receita_tipo_movimentacao_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.receita
    ADD CONSTRAINT receita_tipo_movimentacao_fk FOREIGN KEY (tipo_receita_id) REFERENCES despesas_db.tipo_movimentacao(id);


--
-- Name: transferencia transferencia_debitavel_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.transferencia
    ADD CONSTRAINT transferencia_debitavel_fk FOREIGN KEY (creditavel_id) REFERENCES despesas_db.debitavel(id);


--
-- Name: transferencia transferencia_movimentacao_fk; Type: FK CONSTRAINT; Schema: despesas_db; Owner: despesas
--

ALTER TABLE ONLY despesas_db.transferencia
    ADD CONSTRAINT transferencia_movimentacao_fk FOREIGN KEY (id) REFERENCES despesas_db.movimentacao(id);


--
-- Name: SCHEMA despesas_db; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA despesas_db TO despesas WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

