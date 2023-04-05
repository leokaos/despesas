--
-- PostgreSQL database dump
--

-- Dumped from database version 11.13
-- Dumped by pg_dump version 11.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
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
VISA	28	11	17300.00	6	\N
\.


--
-- Data for Name: conta; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.conta (saldo, id) FROM stdin;
130.51	4
203021.42	5
28756.21	3
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
t	1058	302	\N
t	1059	401	\N
t	1060	301	\N
t	1061	1	\N
t	1062	302	\N
t	1063	102	\N
t	1064	302	\N
t	1065	302	\N
t	1066	1	\N
t	1068	301	\N
t	1069	302	\N
t	1070	302	\N
t	1071	102	\N
t	1072	107	\N
t	1073	302	\N
t	1074	302	\N
t	1075	401	\N
t	1076	401	\N
t	1077	302	\N
t	1081	102	\N
t	1082	1	\N
t	1083	302	\N
t	1084	108	\N
t	1085	301	\N
t	1086	102	\N
t	1087	302	\N
t	1088	301	\N
t	1089	302	\N
t	1090	108	\N
t	1091	1	\N
t	1092	302	\N
t	1093	302	\N
t	1094	108	\N
t	1095	102	\N
t	1096	302	\N
t	1097	302	\N
t	1098	2	\N
t	1099	301	\N
t	1100	302	\N
t	1101	302	\N
t	1102	302	\N
t	1103	102	\N
t	1104	302	\N
t	1105	301	\N
t	1106	302	\N
t	1107	302	\N
t	1108	108	\N
t	1109	103	\N
t	1110	102	\N
t	1111	201	\N
t	1112	102	\N
t	1113	104	\N
t	1114	102	\N
t	1115	108	\N
t	1116	108	\N
t	1117	401	\N
t	1118	401	\N
t	1119	401	\N
t	1121	108	31
t	1122	201	31
t	1123	201	31
t	1124	201	31
t	1125	201	31
t	1126	201	31
t	1127	108	31
t	1128	201	31
t	1129	201	32
t	1135	201	32
t	1130	108	32
t	1131	201	32
t	1132	201	32
t	1133	201	32
t	1134	201	32
t	1136	201	32
t	1137	201	35
t	1138	108	35
t	1139	201	35
t	1140	201	35
t	1141	201	35
t	1142	201	35
t	1143	201	35
t	1144	201	35
t	1145	108	35
t	1146	107	35
t	1147	301	\N
t	1148	102	\N
t	1149	302	\N
t	1150	302	\N
t	1151	102	\N
t	1152	102	\N
t	1153	302	\N
t	1154	301	\N
t	1155	302	\N
t	1156	401	\N
t	1157	302	\N
t	1158	302	\N
t	1159	302	\N
t	1160	102	\N
t	1161	108	\N
t	1162	108	\N
t	1165	401	\N
t	1166	301	\N
t	1167	401	\N
t	1168	302	\N
t	1169	102	\N
t	1170	1	\N
t	1171	301	\N
t	1172	102	\N
t	1173	1	\N
t	1174	102	\N
t	1175	301	\N
t	1176	1	\N
t	1178	1	\N
t	1179	301	\N
t	1180	1	\N
t	1181	1	\N
t	1182	102	\N
t	1184	102	\N
t	1185	401	\N
t	1186	401	\N
t	1187	102	\N
t	1188	102	\N
t	1189	102	\N
t	1190	401	\N
t	1191	401	\N
t	1192	102	\N
t	1193	401	\N
t	1194	108	\N
t	1195	108	\N
t	1196	103	\N
t	1197	108	\N
t	1198	108	\N
t	1199	301	\N
t	1200	301	\N
t	1201	107	\N
t	1202	301	\N
t	1203	108	\N
t	1204	301	\N
t	1205	401	\N
t	1206	201	\N
t	1207	301	\N
t	1208	102	\N
t	1209	107	\N
t	1210	108	\N
t	1211	102	\N
t	1212	2	\N
t	1213	103	\N
t	1214	301	\N
t	1215	102	\N
t	1216	102	\N
t	1217	108	\N
t	1218	108	\N
t	1219	107	\N
t	1220	107	\N
t	1221	102	\N
t	1222	102	\N
t	1223	102	\N
t	1224	102	\N
t	1225	1	\N
t	1226	301	\N
t	1227	102	\N
t	1228	102	\N
t	1229	201	\N
t	1230	102	\N
t	1231	108	\N
t	1232	201	\N
t	1233	301	\N
t	1234	107	\N
t	1236	103	\N
t	1237	107	\N
t	1238	108	\N
t	1239	108	\N
t	1240	108	\N
t	1241	108	\N
t	1242	108	\N
t	1244	1	\N
t	1245	301	\N
t	1246	108	\N
t	1247	108	36
t	1248	201	36
t	1249	201	36
t	1250	201	36
t	1251	201	36
t	1252	201	36
t	1253	201	36
t	1254	201	36
t	1255	201	36
t	1257	201	36
t	1258	201	36
t	1256	108	36
t	1259	201	38
t	1260	108	38
t	1261	201	38
t	1262	401	38
t	1263	107	38
t	1264	201	38
t	1265	102	38
t	1266	401	38
t	1267	201	38
t	1268	102	38
t	1269	102	38
t	1270	102	38
t	1271	201	38
t	1272	102	38
t	1273	102	38
t	1274	102	38
t	1275	102	38
t	1276	201	38
t	1277	107	38
t	1278	102	38
t	1279	102	38
t	1280	401	38
t	1281	102	38
t	1282	102	38
t	1283	102	38
t	1284	102	38
t	1285	102	38
t	1286	107	38
t	1287	201	38
t	1288	102	38
t	1289	301	38
t	1290	102	38
t	1291	103	38
t	1292	107	38
t	1293	102	38
t	1294	103	38
t	1295	102	38
t	1296	102	38
t	1297	108	38
t	1299	102	\N
t	1300	301	\N
t	1301	102	\N
t	1302	302	\N
t	1303	301	\N
t	1304	108	\N
t	1305	401	\N
t	1306	401	\N
t	1307	401	\N
t	1308	102	\N
t	1309	301	\N
t	1310	104	\N
t	1311	302	\N
t	1312	201	\N
t	1313	302	\N
t	1314	302	\N
t	1315	301	\N
t	1316	302	\N
t	1317	102	\N
t	1318	102	\N
t	1319	1	\N
t	1320	102	\N
t	1321	302	\N
t	1322	302	\N
t	1323	102	\N
t	1324	302	\N
t	1325	201	40
t	1326	102	40
t	1327	102	40
t	1328	102	40
t	1329	102	40
t	1330	102	40
t	1331	102	40
t	1332	401	40
t	1333	102	40
t	1334	107	40
t	1335	201	40
t	1336	107	40
t	1337	102	40
t	1338	102	40
t	1339	107	40
t	1340	201	40
t	1341	107	40
t	1342	107	40
t	1343	107	40
t	1344	102	40
t	1345	201	40
t	1346	201	40
t	1347	201	40
t	1348	401	\N
t	1349	301	\N
t	1351	401	\N
t	1352	302	\N
t	1353	103	\N
t	1354	302	\N
t	1355	102	\N
t	1356	102	\N
t	1357	201	\N
t	1358	302	\N
t	1359	401	\N
t	1361	301	\N
t	1362	302	\N
t	1363	102	\N
t	1364	302	\N
t	1365	302	\N
t	1366	302	\N
t	1367	102	\N
t	1368	108	\N
t	1369	108	\N
t	1371	201	41
t	1372	201	41
t	1373	201	41
t	1374	201	41
t	1375	201	41
t	1377	102	\N
t	1378	302	\N
t	1379	302	\N
t	1380	102	\N
t	1381	302	\N
t	1382	302	\N
t	1383	302	\N
t	1384	301	\N
t	1385	104	\N
t	1386	302	\N
t	1387	108	\N
t	1388	104	\N
t	1389	201	\N
t	1391	302	\N
t	1392	108	\N
t	1393	108	\N
t	1394	201	41
t	1395	1	\N
t	1396	302	\N
t	1397	102	\N
t	1398	302	\N
t	1399	102	\N
t	1400	302	\N
t	1401	401	\N
t	1402	102	\N
t	1403	301	\N
t	1404	302	\N
t	1405	302	\N
t	1406	102	\N
t	1410	302	\N
t	1411	102	\N
t	1412	102	\N
t	1413	301	\N
t	1414	108	\N
t	1416	401	\N
t	1418	201	41
t	1420	201	41
t	1421	108	41
t	1427	108	\N
t	1429	108	\N
t	1430	401	\N
t	1439	102	\N
t	1440	302	\N
t	1441	102	\N
t	1442	302	\N
t	1443	1	\N
t	1444	102	\N
t	1445	302	\N
t	1446	301	\N
t	1447	302	\N
t	1448	102	\N
t	1449	102	\N
t	1450	302	\N
t	1451	102	\N
t	1452	302	\N
t	1453	102	\N
t	1454	102	\N
t	1455	102	\N
t	1456	302	\N
t	1457	302	\N
t	1458	108	\N
t	1459	302	\N
t	1460	102	\N
t	1461	301	\N
t	1462	102	\N
t	1463	302	\N
t	1464	302	\N
t	1465	102	\N
t	1466	102	\N
t	1467	102	\N
t	1468	302	\N
t	1469	302	\N
t	1470	102	\N
t	1471	302	\N
t	1472	102	\N
t	1473	102	\N
t	1474	302	\N
t	1475	301	\N
t	1476	302	\N
t	1477	102	\N
t	1478	302	\N
t	1479	302	\N
t	1480	1	\N
t	1481	102	\N
t	1482	302	\N
t	1483	301	\N
t	1484	102	\N
t	1485	302	\N
t	1486	102	\N
t	1487	102	\N
t	1488	102	\N
t	1489	107	\N
t	1490	401	\N
t	1491	108	\N
t	1492	201	\N
t	1494	401	\N
t	1495	401	\N
t	1496	102	\N
t	1497	302	\N
t	1498	102	\N
t	1499	102	\N
t	1500	108	\N
t	1501	102	\N
t	1502	302	\N
t	1503	302	\N
t	1504	102	\N
t	1505	102	\N
t	1506	302	\N
t	1507	302	\N
t	1508	301	\N
t	1509	102	\N
t	1510	301	\N
t	1511	302	\N
t	1512	108	\N
t	1513	301	\N
t	1514	102	\N
t	1515	302	\N
t	1516	102	\N
t	1517	301	\N
t	1518	302	\N
t	1519	302	\N
t	1520	301	\N
t	1521	1	\N
t	1522	102	\N
t	1523	102	\N
t	1525	108	\N
t	1526	108	\N
t	1527	401	\N
t	1528	108	42
t	1529	201	42
t	1530	201	42
t	1531	201	42
t	1532	201	42
t	1533	201	42
t	1534	201	42
t	1536	108	\N
t	1537	102	\N
t	1538	2	\N
t	1539	102	\N
t	1540	301	\N
t	1541	302	\N
t	1542	102	\N
t	1543	302	\N
t	1544	301	\N
t	1545	302	\N
t	1546	102	\N
t	1547	1	\N
t	1548	302	\N
t	1549	102	\N
t	1550	302	\N
t	1551	102	\N
t	1552	102	\N
t	1553	102	\N
t	1554	102	\N
t	1555	302	\N
t	1556	301	\N
t	1557	102	\N
t	1558	302	\N
t	1559	102	\N
t	1560	108	\N
t	1561	102	\N
t	1562	108	\N
t	1563	102	\N
t	1564	302	\N
t	1565	302	\N
t	1566	102	\N
t	1567	102	\N
t	1568	301	\N
t	1569	302	\N
t	1570	102	\N
t	1571	302	\N
t	1572	102	\N
t	1573	301	\N
t	1574	108	\N
t	1575	102	\N
t	1576	302	\N
t	1577	102	\N
t	1578	302	\N
t	1579	102	\N
t	1580	102	\N
t	1581	302	\N
t	1582	102	\N
t	1583	301	\N
t	1584	108	\N
t	1585	108	\N
t	1586	102	\N
t	1587	302	\N
t	1588	102	\N
t	1589	108	\N
t	1590	302	\N
t	1591	201	\N
t	1592	104	\N
t	1593	108	\N
t	1594	302	\N
t	1595	102	\N
t	1596	102	\N
t	1597	102	\N
t	1598	102	\N
t	1599	301	\N
t	1600	102	\N
t	1601	302	\N
t	1602	301	\N
t	1603	108	\N
t	1604	102	\N
t	1605	108	\N
t	1606	102	\N
t	1607	102	\N
t	1608	301	\N
t	1609	302	\N
t	1611	401	\N
t	1612	108	\N
t	1613	201	\N
t	1614	107	\N
t	1615	108	\N
t	1616	108	\N
t	1617	108	\N
t	1619	108	\N
t	1620	108	\N
t	1621	108	\N
t	1622	108	\N
t	1623	108	\N
t	1624	102	\N
t	1625	103	\N
t	1626	102	\N
t	1627	102	\N
t	1628	108	\N
t	1629	108	\N
t	1630	103	\N
t	1631	103	\N
t	1632	103	\N
t	1633	103	\N
t	1634	102	\N
t	1635	103	\N
t	1636	401	\N
t	1637	102	\N
t	1638	108	\N
t	1639	108	\N
t	1640	102	\N
t	1641	102	\N
t	1642	102	\N
t	1643	104	\N
t	1644	108	\N
t	1645	301	\N
t	1646	102	\N
t	1647	301	\N
t	1648	102	\N
t	1649	102	\N
t	1650	108	\N
t	1651	108	\N
t	1652	1	\N
t	1653	108	\N
t	1654	302	\N
t	1655	108	\N
t	1656	302	\N
t	1657	102	\N
t	1658	108	\N
t	1659	108	\N
t	1660	302	\N
t	1661	1	\N
t	1662	302	\N
t	1663	301	\N
t	1664	302	\N
t	1665	302	\N
t	1666	102	\N
t	1667	102	\N
t	1668	102	\N
t	1669	302	\N
t	1670	301	\N
t	1671	302	\N
t	1672	102	\N
t	1673	102	\N
t	1674	102	\N
t	1675	302	\N
t	1676	102	\N
t	1677	301	\N
t	1678	302	\N
t	1679	302	\N
t	1684	107	\N
t	1685	107	\N
t	1686	108	\N
t	1687	107	\N
t	1688	107	\N
t	1689	108	\N
t	1690	401	\N
t	1691	102	\N
t	1692	301	\N
t	1693	1	\N
t	1694	102	\N
t	1695	102	\N
t	1696	201	43
t	1697	108	43
t	1698	201	43
t	1699	201	43
t	1700	201	43
t	1701	201	43
t	1702	201	43
t	1703	201	44
t	1704	108	44
t	1705	201	44
t	1706	201	44
t	1707	201	44
t	1708	201	44
t	1709	201	44
t	1711	102	\N
t	1712	108	\N
t	1713	108	\N
t	1714	102	\N
t	1715	102	\N
t	1718	102	\N
t	1719	108	\N
t	1720	102	\N
t	1721	1	\N
t	1722	102	\N
t	1723	102	\N
t	1724	102	\N
t	1725	102	\N
t	1726	102	\N
t	1727	102	\N
t	1728	102	\N
t	1729	102	\N
t	1730	102	\N
t	1731	1	\N
t	1732	102	\N
t	1733	102	\N
t	1734	108	\N
t	1735	108	\N
t	1736	102	\N
t	1737	102	\N
t	1739	102	\N
t	1740	301	\N
t	1741	108	\N
t	1742	107	\N
t	1743	107	\N
t	1744	107	\N
t	1745	107	\N
t	1746	108	\N
t	1747	108	\N
t	1748	201	45
t	1749	108	45
t	1750	201	45
t	1751	201	45
t	1752	201	45
t	1753	201	45
t	1754	201	45
t	1757	108	\N
t	1758	1	\N
t	1759	102	\N
t	1760	108	\N
t	1761	108	\N
t	1762	102	\N
t	1763	108	\N
t	1764	102	\N
t	1765	102	\N
t	1766	102	\N
t	1767	102	\N
t	1768	108	\N
t	1769	108	\N
t	1770	108	\N
t	1771	102	\N
t	1772	102	\N
t	1773	102	\N
t	1774	102	\N
t	1775	102	\N
t	1776	102	\N
t	1777	102	\N
t	1778	102	\N
t	1779	102	\N
t	1780	1	\N
t	1781	102	\N
t	1782	102	\N
t	1783	102	\N
t	1784	102	\N
t	1785	102	\N
t	1786	102	\N
t	1787	102	\N
t	1788	102	\N
t	1789	108	\N
t	1790	108	\N
t	1791	102	\N
t	1792	102	\N
t	1793	102	\N
t	1794	102	\N
t	1799	107	\N
t	1800	107	\N
t	1801	107	\N
t	1802	102	\N
t	1803	102	\N
t	1804	102	\N
t	1805	102	\N
t	1806	102	\N
t	1807	102	\N
t	1808	102	\N
t	1809	102	\N
t	1810	102	\N
t	1811	201	\N
t	1812	102	\N
t	1813	102	\N
t	1814	102	\N
t	1815	102	\N
t	1816	108	\N
t	1817	401	\N
t	1818	102	\N
t	1819	108	\N
t	1820	107	\N
t	1821	107	\N
t	1822	102	\N
t	1823	102	\N
t	1824	107	\N
t	1825	108	\N
t	1826	102	\N
t	1827	102	\N
t	1828	107	\N
t	1829	102	\N
t	1830	108	\N
t	1831	102	\N
t	1833	102	\N
t	1834	102	\N
t	1835	102	\N
t	1836	102	\N
t	1837	102	\N
t	1838	102	\N
t	1839	102	\N
t	1840	102	\N
t	1841	102	\N
t	1842	102	\N
t	1843	102	\N
t	1844	3	\N
t	1845	102	\N
t	1846	102	\N
t	1847	102	\N
t	1848	102	\N
t	1849	102	\N
t	1850	102	\N
t	1851	102	\N
t	1852	102	\N
t	1853	102	\N
t	1854	102	\N
t	1855	102	\N
t	1856	102	\N
t	1857	108	\N
t	1858	102	\N
t	1859	102	\N
t	1860	108	\N
t	1861	102	\N
t	1862	102	\N
t	1863	108	\N
t	1864	102	\N
t	1865	301	\N
t	1866	102	\N
t	1867	102	\N
t	1868	102	\N
t	1869	102	\N
t	1870	102	\N
t	1871	102	\N
t	1872	102	\N
t	1873	102	\N
t	1874	102	\N
t	1875	102	\N
t	1876	301	\N
t	1877	102	\N
t	1878	102	\N
t	1879	102	\N
t	1880	102	\N
t	1881	102	\N
t	1882	102	\N
t	1883	301	\N
t	1884	102	\N
t	1885	102	\N
t	1886	102	\N
t	1887	3	\N
t	1888	102	\N
t	1889	102	\N
t	1890	1	\N
t	1891	102	\N
t	1892	102	\N
t	1893	301	\N
t	1894	102	\N
t	1895	102	\N
t	1896	108	\N
t	1897	102	\N
t	1898	102	\N
t	1899	108	\N
t	1900	108	\N
t	1901	102	\N
t	1902	108	\N
t	1903	108	\N
t	1907	102	\N
t	1908	102	\N
t	1909	102	\N
t	1910	102	\N
t	1911	102	\N
t	1912	102	\N
t	1913	102	\N
t	1914	102	\N
t	1915	102	\N
t	1916	3	\N
t	1917	301	\N
t	1918	102	\N
t	1919	102	\N
t	1920	3	\N
t	1921	3	\N
t	1922	102	\N
t	1923	102	\N
t	1924	102	\N
t	1925	301	\N
t	1926	301	\N
t	1927	102	\N
t	1928	1	\N
t	1929	102	\N
t	1930	102	\N
t	1931	3	\N
t	1932	102	\N
t	1933	102	\N
t	1934	102	\N
t	1935	102	\N
t	1936	4	\N
t	1937	102	\N
t	1938	3	\N
t	1939	4	\N
t	1940	1	\N
t	1941	3	\N
t	1942	102	\N
t	1943	102	\N
t	1944	102	\N
t	1945	102	\N
t	1946	108	\N
t	1947	108	\N
t	1948	102	\N
t	1949	102	\N
t	1950	3	\N
t	1951	102	\N
t	1952	102	\N
t	1953	3	\N
t	1954	3	\N
t	1955	102	\N
t	1956	102	\N
t	1957	102	\N
t	1958	3	\N
t	1959	108	\N
t	1960	108	\N
t	1961	102	\N
t	1962	3	\N
t	1963	3	\N
t	1964	102	\N
t	1965	102	\N
t	1966	102	\N
t	1967	102	\N
t	1968	102	\N
t	1969	102	\N
t	1970	108	\N
t	1971	108	\N
t	1972	102	\N
t	1973	102	\N
t	1974	1	\N
t	1975	102	\N
t	1976	3	\N
t	1977	102	\N
t	1978	4	\N
t	1979	102	\N
t	1980	102	\N
t	1981	102	\N
t	1982	102	\N
t	1983	102	\N
t	1984	3	\N
t	1985	102	\N
t	1986	102	\N
t	1987	102	\N
t	1990	4	\N
t	1991	102	\N
t	1992	102	\N
t	1993	102	\N
t	1994	201	\N
t	1995	301	\N
t	1996	102	\N
t	1997	104	\N
t	1998	201	\N
t	1999	102	\N
t	2000	102	\N
t	2001	102	\N
t	2002	4	\N
t	2003	102	\N
t	2004	102	\N
t	2005	107	\N
t	2006	4	\N
t	2007	102	\N
t	2008	102	\N
t	2009	102	\N
t	2010	102	\N
t	2011	102	\N
t	2012	102	\N
t	2013	3	\N
t	2014	108	\N
t	2015	102	\N
t	2016	102	\N
t	2017	102	\N
t	2018	3	\N
t	2019	102	\N
t	2020	4	\N
t	2021	4	\N
t	2022	102	\N
t	2023	102	\N
t	2024	102	\N
t	2025	3	\N
t	2026	102	\N
t	2027	102	\N
t	2028	102	\N
t	2029	108	\N
t	2030	108	\N
t	2031	102	\N
t	2032	3	\N
t	2033	4	\N
t	2034	3	\N
t	2035	102	\N
t	2036	102	\N
t	2037	102	\N
t	2038	102	\N
t	2039	102	\N
t	2040	108	\N
t	2041	108	\N
t	2042	301	\N
t	2043	102	\N
t	2045	102	\N
t	2046	301	\N
t	2047	102	\N
t	2048	102	\N
t	2049	102	\N
t	2050	102	\N
t	2051	102	\N
t	2052	102	\N
t	2053	102	\N
t	2054	102	\N
t	2055	102	\N
t	2056	102	\N
t	2057	102	\N
t	2058	102	\N
t	2059	102	\N
t	2060	102	\N
t	2061	102	\N
t	2062	102	\N
t	2063	3	\N
t	2064	102	\N
t	2065	102	\N
t	2066	108	\N
t	2067	108	\N
t	2068	102	\N
t	2069	102	\N
t	2070	4	\N
t	2071	4	\N
t	2072	4	\N
t	2073	102	\N
t	2074	102	\N
t	2075	102	\N
t	2076	201	\N
t	2077	102	\N
t	2078	301	\N
t	2079	102	\N
t	2080	102	\N
t	2081	102	\N
t	2082	102	\N
t	2083	102	\N
t	2084	102	\N
t	2085	102	\N
t	2086	102	\N
t	2087	102	\N
t	2088	102	\N
t	2089	301	\N
t	2090	102	\N
t	2093	107	\N
t	2094	3	\N
t	2095	3	\N
t	2096	3	\N
t	2097	107	\N
t	2098	107	\N
t	2099	107	\N
t	2100	107	\N
t	2101	107	\N
t	2102	4	\N
t	2103	107	\N
t	2104	3	\N
t	2105	107	\N
t	2106	107	\N
t	2107	107	\N
t	2108	107	\N
t	2109	107	\N
t	2110	107	\N
t	2111	107	\N
t	2112	107	\N
t	2113	107	\N
t	2114	107	\N
t	2115	107	\N
t	2116	107	\N
t	2117	107	\N
t	2118	107	\N
t	2119	107	\N
t	2120	107	\N
t	2121	107	\N
t	2123	301	\N
t	2124	107	\N
t	2125	107	\N
t	2126	107	\N
t	2127	107	\N
t	2128	103	\N
t	2129	107	\N
t	2130	107	\N
t	2131	107	\N
t	2132	107	\N
t	2133	107	\N
t	2134	107	\N
t	2135	107	\N
t	2136	107	\N
t	2137	107	\N
t	2138	107	\N
t	2139	107	\N
t	2140	107	\N
t	2141	107	\N
t	2142	107	\N
t	2143	107	\N
t	2144	107	\N
t	2145	107	\N
t	2146	107	\N
t	2147	107	\N
t	2148	107	\N
t	2149	107	\N
t	2150	107	\N
t	2151	107	\N
t	2152	107	\N
t	2153	107	\N
t	2154	107	\N
t	2155	107	\N
t	2156	201	46
t	2157	108	46
t	2158	201	46
t	2159	201	46
t	2160	201	46
t	2161	201	46
t	2162	201	46
t	2163	201	46
t	2164	201	46
t	2165	201	46
t	2166	201	46
t	2169	201	46
t	2167	201	46
t	2168	108	46
t	2171	108	47
t	2172	201	47
t	2173	201	47
t	2174	201	47
t	2175	201	47
t	2176	201	47
t	2177	201	47
t	2178	201	47
t	2179	108	48
t	2180	201	48
t	2181	201	48
t	2182	201	48
t	2183	201	48
t	2184	201	48
t	2185	201	48
t	2186	201	48
t	2187	201	48
t	2188	201	48
t	2189	108	48
t	2190	108	48
t	2191	201	48
t	2192	108	48
t	2193	201	49
t	2194	201	49
t	2195	201	49
t	2196	201	49
t	2197	201	49
t	2198	201	49
t	2199	201	49
t	2200	108	49
t	2201	201	49
t	2202	108	\N
t	2203	108	\N
t	2204	108	\N
t	2205	108	\N
t	2206	108	\N
t	2207	108	\N
t	2208	108	\N
t	2209	108	\N
t	2210	108	\N
t	2211	108	\N
t	2212	108	\N
t	2213	108	\N
t	2214	108	\N
t	2215	108	\N
t	2216	108	\N
t	2217	108	\N
t	2218	108	\N
t	2219	108	\N
t	2220	108	\N
t	2221	108	\N
t	2222	108	\N
t	2223	108	\N
t	2224	108	\N
t	2225	108	\N
t	2226	108	\N
t	2227	108	\N
t	2228	108	\N
t	2233	108	\N
t	2234	108	\N
t	2235	108	\N
t	2236	102	\N
t	2237	102	\N
t	2238	301	\N
t	2239	107	\N
t	2240	102	\N
t	2241	107	\N
t	2242	108	\N
t	2243	102	\N
t	2244	102	\N
t	2245	102	\N
t	2246	102	\N
t	2247	301	\N
t	2248	2	\N
t	2249	102	\N
t	2250	107	\N
t	2251	2	\N
t	2252	107	\N
t	2253	107	\N
t	2254	102	\N
t	2255	108	\N
t	2256	104	\N
t	2257	103	\N
t	2258	103	\N
t	2259	103	\N
t	2260	107	\N
t	2261	107	\N
t	2262	102	\N
t	2263	107	\N
t	2264	107	\N
t	2265	108	\N
t	2266	103	\N
t	2267	301	\N
t	2268	3	\N
t	2269	104	\N
t	2270	108	\N
t	2271	104	\N
t	2272	102	\N
t	2273	104	\N
t	2274	102	\N
t	2275	102	\N
t	2276	107	\N
t	2277	103	\N
t	2278	108	\N
t	2279	108	\N
t	2280	107	\N
t	2281	107	\N
t	2282	102	\N
t	2283	107	\N
t	2284	107	\N
t	2285	102	\N
t	2286	301	\N
t	2287	3	\N
t	2288	102	\N
t	2289	201	\N
t	2290	108	\N
t	2291	102	\N
t	2292	102	\N
t	2293	108	50
t	2294	201	50
t	2295	201	50
t	2296	201	50
t	2297	201	50
t	2298	201	50
t	2299	201	50
t	2300	201	50
t	2303	201	50
t	2301	201	50
t	2302	108	50
t	2305	107	\N
t	2306	301	\N
t	2307	301	\N
t	2308	102	\N
t	2309	108	\N
t	2310	108	\N
t	2311	4	\N
t	2312	4	\N
t	2313	4	\N
t	2314	108	\N
t	2315	4	\N
t	2316	4	\N
t	2317	4	\N
t	2318	4	\N
t	2319	108	\N
t	2320	108	\N
t	2321	4	\N
t	2322	4	\N
t	2323	4	\N
t	2324	4	\N
t	2325	108	52
t	2326	201	52
t	2327	201	52
t	2328	107	52
t	2329	107	52
t	2330	102	52
t	2331	107	52
t	2332	102	52
t	2333	102	52
t	2334	107	52
t	2335	102	52
t	2336	201	52
t	2337	201	52
t	2338	102	52
t	2339	102	52
t	2340	201	52
t	2341	107	52
t	2342	301	52
t	2343	102	52
t	2344	102	52
t	2345	102	52
t	2346	102	52
t	2347	102	52
t	2348	102	52
t	2349	104	52
t	2350	102	52
t	2351	102	52
t	2352	102	52
t	2353	102	52
t	2354	102	52
t	2355	102	52
t	2356	201	52
t	2357	107	52
t	2358	2	52
t	2359	301	52
t	2360	102	52
t	2361	102	52
t	2362	107	52
t	2363	107	52
t	2364	102	52
t	2365	201	52
t	2366	102	52
t	2367	102	52
t	2368	107	52
t	2369	102	52
t	2370	102	52
t	2372	104	54
t	2373	107	54
t	2374	107	54
t	2375	201	54
t	2376	201	54
t	2377	107	54
t	2378	201	54
t	2379	107	54
t	2380	201	54
t	2381	201	54
t	2382	201	54
t	2383	107	54
t	2386	107	54
t	2387	201	54
t	2388	201	54
t	2384	201	54
t	2385	108	54
t	2390	104	56
t	2391	201	56
t	2392	201	56
t	2393	201	56
t	2394	201	56
t	2395	201	56
t	2396	201	56
t	2397	201	56
t	2398	108	56
t	2400	102	\N
t	2401	102	\N
t	2402	102	\N
t	2403	102	\N
t	2404	102	\N
t	2405	102	\N
t	2406	102	\N
t	2407	102	\N
t	2408	102	\N
t	2410	4	\N
t	2412	4	\N
t	2414	108	\N
t	2417	4	\N
t	2418	102	\N
t	2420	102	\N
t	2427	102	\N
t	2431	4	\N
t	2433	108	\N
t	2435	108	\N
t	2436	108	\N
t	2439	102	\N
t	2441	102	\N
t	2442	102	\N
t	2443	102	\N
t	2444	102	\N
t	2445	102	\N
t	2446	102	\N
t	2448	102	\N
t	2450	1	\N
t	2452	301	\N
t	2453	102	\N
t	2454	102	\N
t	2455	104	\N
t	2456	104	\N
t	2457	102	\N
t	2458	102	\N
t	2459	1	\N
t	2460	102	\N
t	2461	107	\N
t	2462	103	\N
t	2463	103	\N
t	2464	103	\N
t	2465	107	\N
t	2466	107	\N
t	2467	102	\N
t	2468	102	\N
t	2469	102	\N
t	2470	4	\N
t	2471	102	\N
t	2472	108	\N
t	2473	108	\N
t	2474	102	\N
t	2475	102	\N
t	2476	301	\N
t	2477	102	\N
t	2478	108	\N
t	2479	108	\N
t	2480	301	\N
t	2481	102	\N
t	2482	102	\N
t	2483	102	\N
t	2484	102	\N
t	2485	102	\N
t	2486	104	\N
t	2487	201	\N
t	2488	104	\N
t	2489	301	\N
t	2490	102	\N
t	2491	102	\N
t	2492	102	\N
t	2493	102	\N
t	2494	102	\N
t	2495	102	\N
t	2496	102	\N
t	2497	301	\N
t	2498	102	\N
t	2499	4	\N
t	2500	4	\N
t	2501	4	\N
t	2502	102	\N
t	2503	102	\N
t	2504	107	\N
t	2505	102	\N
t	2506	102	\N
t	2507	102	\N
t	2508	102	\N
t	2509	201	\N
t	2510	108	\N
t	2511	108	\N
t	2512	3	\N
t	2513	102	\N
t	2514	107	\N
t	2515	102	\N
t	2516	1	\N
t	2517	102	\N
t	2518	301	\N
t	2520	102	\N
t	2521	102	\N
t	2522	102	\N
t	2523	102	\N
t	2524	102	\N
t	2525	301	\N
t	2526	102	\N
t	2527	102	\N
t	2528	102	\N
t	2529	102	\N
t	2530	102	\N
t	2531	102	\N
t	2532	102	\N
t	2533	102	\N
t	2534	102	\N
t	2535	102	\N
t	2536	102	\N
t	2537	102	\N
t	2538	102	\N
t	2539	102	\N
t	2540	201	\N
t	2541	102	\N
t	2542	102	\N
t	2543	102	\N
t	2544	102	\N
t	2545	102	\N
t	2546	102	\N
t	2547	102	\N
t	2548	102	\N
t	2549	102	\N
t	2550	102	\N
t	2551	102	\N
t	2552	3	\N
t	2553	102	\N
t	2554	108	\N
t	2555	108	\N
t	2556	102	\N
t	2557	4	\N
t	2558	4	\N
t	2559	4	\N
t	2560	102	\N
t	2561	102	\N
t	2562	3	\N
t	2563	102	\N
t	2564	102	\N
t	2565	102	\N
t	2566	102	\N
t	2567	102	\N
t	2568	102	\N
t	2569	301	\N
t	2570	102	\N
t	2572	102	\N
t	2573	301	\N
t	2574	102	\N
t	2575	102	\N
t	2576	107	\N
t	2577	107	\N
t	2578	102	\N
t	2579	102	\N
t	2580	103	\N
t	2581	104	\N
t	2582	104	\N
t	2583	102	\N
t	2584	102	\N
t	2585	107	\N
t	2586	107	\N
t	2587	102	\N
t	2588	102	\N
t	2589	301	\N
t	2590	102	\N
t	2591	201	\N
t	2592	102	\N
t	2593	102	\N
t	2594	102	\N
t	2595	102	\N
t	2596	102	\N
t	2597	102	\N
t	2598	108	\N
t	2599	108	\N
t	2600	102	\N
t	2601	4	\N
t	2602	4	\N
t	2603	107	\N
t	2604	107	\N
t	2605	102	\N
t	2606	102	\N
t	2607	102	\N
t	2608	301	\N
t	2609	102	\N
t	2610	107	\N
t	2611	107	\N
t	2613	107	\N
t	2614	107	\N
t	2615	107	\N
t	2616	107	\N
t	2617	4	\N
t	2618	107	\N
t	2619	107	\N
t	2620	107	\N
t	2621	107	\N
t	2622	107	\N
t	2623	107	\N
t	2624	107	\N
t	2625	107	\N
t	2626	201	\N
t	2627	107	\N
t	2628	107	\N
t	2629	107	\N
t	2630	107	\N
t	2631	107	\N
t	2632	107	\N
t	2633	107	\N
t	2634	3	\N
t	2635	107	\N
t	2636	107	\N
t	2637	107	\N
t	2638	107	\N
t	2639	107	\N
t	2640	107	\N
t	2641	107	\N
t	2642	107	\N
t	2643	107	\N
t	2644	107	\N
t	2645	107	\N
t	2646	107	\N
t	2647	107	\N
t	2648	107	\N
t	2649	107	\N
t	2650	107	\N
t	2651	107	\N
t	2652	107	\N
t	2653	107	\N
t	2654	107	\N
t	2655	107	\N
t	2656	3	\N
t	2657	102	\N
t	2658	102	\N
t	2659	102	\N
t	2660	102	\N
t	2661	102	\N
t	2662	102	\N
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
31	6	2021-11-11 00:00:00	2021-10-27 00:00:00	t
32	6	2021-10-11 00:00:00	2021-09-27 00:00:00	t
35	6	2021-09-11 00:00:00	2021-08-27 00:00:00	t
36	6	2021-12-11 00:00:00	2021-11-27 00:00:00	t
38	6	2022-01-11 00:00:00	2021-12-27 00:00:00	t
40	6	2022-02-11 00:00:00	2022-01-27 00:00:00	t
41	6	2022-03-11 00:00:00	2022-02-27 00:00:00	t
42	6	2022-04-11 00:00:00	2022-03-27 00:00:00	t
44	6	2022-06-11 00:00:00	2022-05-27 00:00:00	t
43	6	2022-05-11 00:00:00	2022-04-27 00:00:00	t
45	6	2022-07-11 00:00:00	2022-06-27 00:00:00	t
46	6	2022-08-11 00:00:00	2022-07-27 00:00:00	t
47	6	2022-09-11 00:00:00	2022-08-27 00:00:00	t
48	6	2022-10-11 00:00:00	2022-09-27 00:00:00	t
49	6	2022-11-11 00:00:00	2022-10-27 00:00:00	t
50	6	2022-12-11 00:00:00	2022-11-27 00:00:00	t
52	6	2023-01-11 00:00:00	2022-12-27 00:00:00	t
54	6	2023-02-11 00:00:00	2023-01-27 00:00:00	t
56	6	2023-03-11 00:00:00	2023-02-27 00:00:00	t
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
27	11	2021	2500.00
28	1	2022	2800.00
29	2	2022	2800.00
30	3	2022	2800.00
31	4	2022	2800.00
32	11	2022	2600.00
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
1058	almoço	2021-09-28	6.90	2021-09-28	3	EURO
1059	depilação	2021-09-28	200.00	2021-09-25	3	EURO
1060	Edeka	2021-09-28	44.91	2021-09-25	3	EURO
1061	Saque	2021-09-28	100.00	2021-09-25	3	EURO
1062	almoço 2	2021-09-28	10.15	2021-09-24	3	EURO
1063	bar	2021-09-28	37.40	2021-09-23	3	EURO
1064	Edeka2	2021-09-28	6.60	2021-09-23	3	EURO
1065	Edeka3	2021-09-28	11.32	2021-09-22	3	EURO
1066	Saque2	2021-09-28	100.00	2021-09-22	3	EURO
1067	Cobrir Conta	\N	200.00	2021-09-20	3	EURO
1068	Edeka	2021-09-28	52.70	2021-09-21	3	EURO
1069	Almoço	2021-09-28	10.15	2021-09-21	3	EURO
1070	Almoço2	2021-09-28	6.40	2021-09-17	3	EURO
1071	KFC	2021-09-28	9.29	2021-09-28	4	EURO
1072	Uber	2021-09-28	20.59	2021-09-22	4	EURO
1073	Edeka	2021-09-28	8.80	2021-09-20	4	EURO
1074	KFC2	2021-09-28	9.29	2021-09-16	4	EURO
1075	comgas	2021-09-28	9.89	2021-09-16	5	REAL
1076	vivo	2021-09-28	141.99	2021-09-15	5	REAL
1077	eletropaulo	2021-09-28	31.68	2021-09-29	5	REAL
1078	Transferencia do PC	\N	4000.00	2021-09-30	3	EURO
1079	Cobrir Conta	\N	300.00	2021-10-07	3	EURO
1080	Salario	2021-10-31	3177.00	2021-10-28	3	EURO
1081	AUGUSTINER BRAEUSTUBEN	2021-10-31	19.00	2021-10-29	3	EURO
1082	DB MUENCHEN D MUENCHE	2021-10-31	105.49	2021-10-28	3	EURO
1083	EDEKA M ERIKA MANN 880	2021-10-31	6.60	2021-10-27	3	EURO
1084	KAMILIA PEREIRA MUENCHEN DE	2021-10-31	200.00	2021-10-26	3	EURO
1085	EDEKA CENTER OEZ MUENCHEN DE	2021-10-31	34.52	2021-10-26	3	EURO
1086	EDEKA M ERIKA MANN 880	2021-10-31	5.40	2021-10-22	3	EURO
1087	EDEKA M ERIKA MANN 880	2021-10-31	6.95	2021-10-21	3	EURO
1088	EDEKA CENTER OEZ MUENCHEN DE	2021-10-31	33.28	2021-10-19	3	EURO
1089	BAECKEREI ZIEGLER MUENC	2021-10-31	12.10	2021-10-19	3	EURO
1090	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-10-31	57.00	2021-10-15	3	EURO
1091	DB MUENCHEN D MUENCHE	2021-10-31	105.49	2021-10-15	3	EURO
1092	SumUp Pasta Traum Marti	2021-10-31	6.50	2021-10-15	3	EURO
1093	BAECKEREI ZIEGLER MUENC	2021-10-31	8.00	2021-10-15	3	EURO
1094	Lilli P. MUnchen DE	2021-10-31	11.00	2021-10-14	3	EURO
1095	KFC 1039 MUNCHEN DE	2021-10-31	9.29	2021-10-13	3	EURO
1096	BAECKEREI ZIEGLER MUENC	2021-10-31	8.00	2021-10-13	3	EURO
1097	EDEKA M ERIKA MANN 880	2021-10-31	4.25	2021-10-13	3	EURO
1098	DMDrogerie Markt Muenc	2021-10-31	22.40	2021-10-12	3	EURO
1099	EDEKA CENTER OEZ MUENCHEN DE	2021-10-31	44.58	2021-10-12	3	EURO
1100	BAECKEREI ZIEGLER MUENC	2021-10-31	10.15	2021-10-08	3	EURO
1101	EDEKA M ERIKA MANN 880	2021-10-31	7.90	2021-10-08	3	EURO
1102	EDEKA M ERIKA MANN 880	2021-10-31	8.80	2021-10-07	3	EURO
1103	KFC 1039 MUNCHEN DE	2021-10-31	9.99	2021-10-06	3	EURO
1104	EDEKA M ERIKA MANN 880	2021-10-31	3.95	2021-10-06	3	EURO
1105	EDEKA CENTER OEZ MUENCHEN DE	2021-10-31	41.00	2021-10-05	3	EURO
1106	EDEKA M ERIKA MANN 880	2021-10-31	7.05	2021-10-01	3	EURO
1107	EDEKA M ERIKA MANN 880	2021-10-31	4.58	2021-10-01	3	EURO
1108	WeWash	2021-10-31	18.00	2021-10-02	4	EURO
1109	TAP0470000946895	2021-10-31	1424.78	2021-10-07	4	EURO
1110	Comida	2021-10-31	16.15	2021-10-08	4	EURO
1111	Master PC	2021-10-31	2858.90	2021-10-13	4	EURO
1112	Comida 2	2021-10-31	16.16	2021-10-13	4	EURO
1113	Polo Vermelha	2021-10-31	19.99	2021-10-19	4	EURO
1114	KFC	2021-10-31	9.29	2021-10-20	4	EURO
1115	WeWash 2	2021-10-31	20.00	2021-10-24	4	EURO
1116	Tarifa	2021-10-31	71.90	2021-10-04	5	REAL
1117	Vivo	2021-10-31	141.99	2021-10-15	5	REAL
1118	Condominio	2021-10-31	584.46	2021-10-20	5	REAL
1119	Eletropaulo	2021-10-31	32.62	2021-10-29	5	REAL
1121	ANUIDADE DIFERENCIADA 12/12	2021-10-31	26.00	2021-09-28	6	REAL
1122	EBANX*SPOTIFY CURITIBA BR	2021-10-31	19.90	2021-09-28	6	REAL
1123	AmazonPrimeBR SAO PAULO BR	2021-10-31	9.90	2021-10-03	6	REAL
1124	Amazon.com.br Digital SAO PAULO BR	2021-10-31	19.90	2021-10-03	6	REAL
1125	Disney Plus SAO PAULO BR	2021-10-31	27.90	2021-10-06	6	REAL
1126	NETFLIX.COM SAO PAULO BR	2021-10-31	39.90	2021-10-11	6	REAL
1127	IOF TRANSACOES INTERNACIONAIS	2021-10-31	7.33	2021-10-24	6	REAL
1128	STEAM PURCHASE SEATTLE DE	2021-10-31	114.95	2021-10-15	6	REAL
1129	LOCALIZA RAC ACCAE1 10/10 SAO CAET	2021-10-31	82.55	2021-08-30	6	REAL
1130	ANUIDADE DIFERENCIADA 11/12	2021-10-31	26.00	2021-08-27	6	REAL
1131	EBANX*SPOTIFY CURITIBA BR	2021-10-31	19.90	2021-08-28	6	REAL
1132	AmazonPrimeBR SAO PAULO BR	2021-10-31	9.90	2021-09-03	6	REAL
1133	Amazon.com.br Digital SAO PAULO BR	2021-10-31	19.90	2021-09-03	6	REAL
1134	Disney Plus SAO PAULO BR	2021-10-31	27.90	2021-09-06	6	REAL
1135	NETFLIX.COM SAO PAULO BR	2021-10-31	39.90	2021-09-11	6	REAL
1136	APPLE.COM/BILL SAO PAULO BR	2021-10-31	9.90	2021-09-20	6	REAL
1137	LOCALIZA RAC ACCAE1 09/10 SAO CAET	2021-10-31	82.55	2021-08-09	6	REAL
1138	ANUIDADE DIFERENCIADA 10/12	2021-10-31	26.00	2021-08-09	6	REAL
1139	EBANX*SPOTIFY CURITIBA BR	2021-10-31	19.90	2021-08-09	6	REAL
1140	Amazon.com.br Digital SAO PAULO BR	2021-10-31	19.90	2021-08-03	6	REAL
1141	AmazonPrimeBR SAO PAULO BR	2021-10-31	9.90	2021-08-03	6	REAL
1142	The Walt Disney Compan SAO PAULO B	2021-10-31	27.90	2021-08-06	6	REAL
1143	NETFLIX.COM SAO PAULO BR	2021-10-31	32.90	2021-08-11	6	REAL
1144	APPLE.COM/BILL SAO PAULO BR	2021-10-31	9.90	2021-08-20	6	REAL
1145	IOF TRANSACOES INTERNACIONAIS	2021-10-31	4.34	2021-08-24	6	REAL
1146	UBER *TRIP HELP.UBER.COM DE	2021-10-31	68.08	2021-08-10	6	REAL
1147	EDEKA CENTER OEZ MUENCHEN DE	2021-11-11	40.14	2021-11-09	3	EURO
1148	BAECKEREI ZIEGLER MUENC	2021-11-11	7.95	2021-11-09	3	EURO
1149	EDEKA M ERIKA MANN 880	2021-11-11	7.75	2021-11-09	3	EURO
1150	Foodtruck HerrVonSchwa	2021-11-11	7.80	2021-11-05	3	EURO
1151	BAECKEREI ZIEGLER MUENC	2021-11-11	8.00	2021-11-05	3	EURO
1152	KFC 1039 MUNCHEN DE	2021-11-11	9.49	2021-11-05	3	EURO
1153	EDEKA M ERIKA MANN 880	2021-11-11	7.90	2021-11-04	3	EURO
1154	EDEKA CENTER OEZ MUENCHEN DE	2021-11-11	40.34	2021-11-02	3	EURO
1155	EDEKA M ERIKA MANN 880	2021-11-11	8.80	2021-11-01	3	EURO
1156	Mollie *WeWash GmbH	2021-11-11	5.00	2021-11-03	4	EURO
1157	SumUp  *Pasta Traum	2021-11-11	7.00	2021-11-03	4	EURO
1158	EDEKA M ERIKA MANN 880	2021-11-11	5.90	2021-11-08	4	EURO
1159	EDEKA M ERIKA MANN 880	2021-11-11	3.78	2021-11-09	4	EURO
1160	Lieferando.de lieferse	2021-11-11	13.23	2021-11-09	4	EURO
1161	condominio	2021-11-11	573.00	2021-11-11	5	REAL
1162	taxa	2021-11-11	71.90	2021-11-03	5	REAL
1120	Salario	\N	5135.00	2021-11-29	3	EURO
1163	Cobrir Conta	\N	500.00	2021-11-25	3	EURO
1165	KAMILIA PEREIRA MUENCHEN DE	2021-11-30	200.00	2021-11-30	3	EURO
1166	EDEKA CENTER OEZ MUENCHEN DE	2021-11-30	20.07	2021-11-30	3	EURO
1167	MVZ MARTINSRIED GMBH MARTINSRIED BE	2021-11-30	128.00	2021-11-30	3	EURO
1168	EDEKA M ERIKA MANN 880  CONTACTLESS	2021-11-30	6.95	2021-11-25	3	EURO
1169	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-11-30	17.80	2021-11-24	3	EURO
1170	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE UNI.UB	2021-11-30	100.00	2021-11-24	3	EURO
1171	EDEKA CENTER OEZ MUENCHEN DE	2021-11-30	41.20	2021-11-23	3	EURO
1172	AUGUSTINER BRAEUSTUBEN  CONTACTLESS	2021-11-30	18.00	2021-11-19	3	EURO
1173	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLYEIN	2021-11-30	100.00	2021-11-18	3	EURO
1174	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-11-30	17.80	2021-11-17	3	EURO
1175	EDEKA CENTER OEZ MUENCHEN DE	2021-11-30	47.84	2021-11-16	3	EURO
1176	LEV ATM 3613 DEU 49001770 DB MUENCHEN D MUENCHE	2021-11-30	105.49	2021-11-12	3	EURO
1177	Salário	2022-01-07	3328.00	2021-12-28	3	EURO
1178	Saque	2022-01-07	100.00	2022-01-07	3	EURO
1179	Edeka	2022-01-07	45.61	2022-01-07	3	EURO
1180	Saque	2022-01-07	100.00	2021-12-03	3	EURO
1181	Saque 2	2022-01-07	100.00	2021-12-01	3	EURO
1182	Almoco	2022-01-07	10.15	2021-12-01	3	EURO
1184	KFC	2022-01-07	9.49	2022-01-06	4	EURO
1185	Vodafone	2022-01-07	50.00	2022-01-05	4	EURO
1186	WeWash	2022-01-07	5.00	2022-01-02	4	EURO
1187	EDFC	2022-01-07	5.32	2021-12-26	4	EURO
1188	Comida	2022-01-07	1.68	2021-12-13	4	EURO
1189	Dallmayr	2022-01-07	6.65	2021-12-02	4	EURO
1190	WeWash	2022-01-07	15.00	2021-12-01	4	EURO
1191	Trem	2022-01-07	11.90	2021-12-01	4	EURO
1192	Cafe Vergano	2022-01-07	12.70	2021-12-01	4	EURO
1193	MVG	2022-01-07	13.60	2021-12-01	4	EURO
1194	Vivo	2022-01-08	141.99	2021-11-16	5	REAL
1195	Eletropaulo	2022-01-08	32.64	2021-11-29	5	REAL
1196	GUARUCOOP	2022-01-08	192.07	2021-12-02	5	REAL
1197	TAR PACOTE ITAU NOV/21	2022-01-08	71.90	2021-12-02	5	REAL
1198	ALEXANDRE	2022-01-08	16.00	2021-12-03	5	REAL
1199	CARREFOUR	2022-01-08	4.99	2021-12-03	5	REAL
1200	CARREFOUR	2022-01-08	196.56	2021-12-03	5	REAL
1201	MOOCA PLAZA	2022-01-08	12.00	2021-12-03	5	REAL
1202	EXTRA HIPER0	2022-01-08	68.04	2021-12-06	5	REAL
1203	EXTRA HIPER0	2022-01-08	2199.00	2021-12-06	5	REAL
1204	RAIA 231	2022-01-08	31.98	2021-12-06	5	REAL
1205	CDB CENTRO	2022-01-08	320.00	2021-12-07	5	REAL
1206	PAG*Ronaldo	2022-01-08	120.00	2021-12-07	5	REAL
1207	CARREFOUR	2022-01-08	76.59	2021-12-08	5	REAL
1208	B CATH CAR	2022-01-08	60.00	2021-12-10	5	REAL
1209	AVENIDA PAR	2022-01-08	13.00	2021-12-13	5	REAL
1210	ETNA BER	2022-01-08	2114.99	2021-12-13	5	REAL
1211	PAG*Italva	2022-01-08	18.34	2021-12-13	5	REAL
1212	INT TED aa3d3fb5	2022-01-08	390.00	2021-12-13	5	REAL
1213	BOM BILHAR	2022-01-08	145.00	2021-12-14	5	REAL
1214	CARREFOUR	2022-01-08	168.61	2021-12-14	5	REAL
1215	PAG*Italva	2022-01-08	2.45	2021-12-14	5	REAL
1216	PAG*Marcio	2022-01-08	6.00	2021-12-14	5	REAL
1217	INT PAG TIT 109005317206	2022-01-08	573.00	2021-12-15	5	REAL
1218	DA VIVO FIXO 9324810660	2022-01-08	146.99	2021-12-15	5	REAL
1219	MOOCA PLAZA	2022-01-08	12.00	2021-12-17	5	REAL
1220	ECALAUTO	2022-01-08	10.00	2021-12-20	5	REAL
1221	JORGE KOBAS	2022-01-08	16.00	2021-12-20	5	REAL
1222	KZEN	2022-01-08	122.76	2021-12-20	5	REAL
1223	PAG*Italva	2022-01-08	7.70	2021-12-20	5	REAL
1224	PAG*Italva	2022-01-08	7.44	2021-12-21	5	REAL
1225	SAQUE 24H 01059864	2022-01-08	100.00	2021-12-23	5	REAL
1226	CARREFOUR	2022-01-08	93.82	2021-12-24	5	REAL
1227	DRIVE SP	2022-01-08	29.90	2021-12-27	5	REAL
1228	PAG*Italva	2022-01-08	13.26	2021-12-27	5	REAL
1229	PAG*LEITURA	2022-01-08	54.90	2021-12-27	5	REAL
1230	TUTTI BUONO	2022-01-08	9.00	2021-12-28	5	REAL
1231	DA ELETROPAULO 56301179	2022-01-08	55.58	2021-12-29	5	REAL
1232	YOSHIDA	2022-01-08	150.00	2021-12-30	5	REAL
1233	CARREFOUR	2022-01-08	70.43	2021-12-31	5	REAL
1234	POSTO 5	2022-01-08	100.00	2021-12-31	5	REAL
1235	Estorno Localiza	2022-01-08	3567.79	2022-01-05	5	REAL
1236	RSHOPCDB CENTRO	2022-01-08	350.00	2022-01-03	5	REAL
1237	RSHOPPOSTO 5 DE	2022-01-08	215.89	2022-01-03	5	REAL
1238	TAR PACOTE ITAU DEZ/21	2022-01-08	71.90	2022-01-04	5	REAL
1239	INT PAG TIT 109005328831	2022-01-08	635.00	2022-01-07	5	REAL
1240	INT COMGAS 71300372	2022-01-08	9.89	2022-01-07	5	REAL
1241	INT COMGAS 73600320	2022-01-08	10.56	2022-01-07	5	REAL
1242	INT COMGAS 74400302	2022-01-08	9.89	2022-01-07	5	REAL
1244	Saque	2022-01-08	100.00	2022-01-08	3	EURO
1245	Edeka	2022-01-08	8.13	2022-01-08	3	EURO
1246	Imposto	2022-01-08	5.41	2022-01-08	3	EURO
1247	ANUIDADE DIFERENCIADA 01/12	2022-01-08	26.00	2021-10-29	6	REAL
1248	EBANX*SPOTIFY CURITIBA BR	2022-01-08	19.90	2021-10-29	6	REAL
1249	Amazon.com.br Digital SAO PAULO BR	2022-01-08	19.90	2021-11-03	6	REAL
1250	AmazonPrimeBR SAO PAULO BR	2022-01-08	9.90	2021-11-03	6	REAL
1251	Disney Plus SAO PAULO BR	2022-01-08	27.90	2021-11-06	6	REAL
1252	APPLE.COM/BILL SAO PAULO BR	2022-01-08	9.90	2021-11-07	6	REAL
1253	NETFLIX.COM SAO PAULO BR	2022-01-08	39.90	2021-11-11	6	REAL
1254	APPLE.COM/BILL SAO PAULO BR	2022-01-08	9.90	2021-11-20	6	REAL
1255	DEMERGE BRAS*Blizzard SAO PAULO BR	2022-01-08	89.00	2021-11-21	6	REAL
1256	IOF TRANSACOES INTERNACIONAIS	2022-01-08	13.93	2021-11-28	6	REAL
1257	STEAMGAMES.COM 4259522 Hamburg DE	2022-01-08	199.99	2021-10-30	6	REAL
1258	STEAMGAMES.COM 4259522 Hamburg DE	2022-01-08	18.49	2021-11-25	6	REAL
1259	STEAM PURCHASE	2022-01-09	8.98	2021-11-28	6	REAL
1260	ANUIDADE DIFERENCIADA 02/12	2022-01-09	26.00	2021-11-28	6	REAL
1261	EBANX *SPOTIFY	2022-01-09	19.90	2021-11-28	6	REAL
1262	SERVICOS CLA*119137304	2022-01-09	15.00	2021-12-03	6	REAL
1263	UBER *TRIP HELP.UBER.C	2022-01-09	19.95	2021-12-03	6	REAL
1264	AmazonPrimeBR	2022-01-09	9.90	2021-12-03	6	REAL
1265	IFD*LANCHONETE MELLO	2022-01-09	33.83	2021-12-03	6	REAL
1267	Amazon.com.br Digital	2022-01-09	19.90	2021-12-03	6	REAL
1268	IFD*ESTACAO DO VINHO B	2022-01-09	38.99	2021-12-04	6	REAL
1269	IFD*LUCAS PEREIRA GOME	2022-01-09	44.89	2021-12-05	6	REAL
1270	IFD*CONFEITARIA DOLCI	2022-01-09	24.98	2021-12-05	6	REAL
1271	Disney Plus	2022-01-09	27.90	2021-12-06	6	REAL
1272	IFD*IFOOD.COM AGENCIA	2022-01-09	41.20	2021-12-08	6	REAL
1273	IFD*XANGAI COMERCIO AR	2022-01-09	34.20	2021-12-09	6	REAL
1274	IFD*IFOOD.COM AGENCIA	2022-01-09	30.70	2021-12-10	6	REAL
1275	IFD*RESTAURANTE R AZEV	2022-01-09	26.99	2021-12-10	6	REAL
1276	NETFLIX.COM	2022-01-09	39.90	2021-12-11	6	REAL
1277	CARREFOUR 388 PAN	2022-01-09	309.03	2021-12-11	6	REAL
1278	IFD*RIQS HAMBURGUERIA	2022-01-09	15.99	2021-12-12	6	REAL
1279	IFD*LANCHONETE MELLO	2022-01-09	39.64	2021-12-12	6	REAL
1280	SERVICOS CLA*119137304	2022-01-09	25.00	2021-12-13	6	REAL
1281	IFD*RESTAURANTE R AZEV	2022-01-09	37.98	2021-12-14	6	REAL
1282	IFD*LA MINUTE PIZZARIA	2022-01-09	46.88	2021-12-14	6	REAL
1283	IFD*XANGAI COMERCIO AR	2022-01-09	34.20	2021-12-16	6	REAL
1284	IFD*FERNANDO RABELO LE	2022-01-09	35.79	2021-12-16	6	REAL
1285	IFD*MARCIA APARECIDA L	2022-01-09	26.99	2021-12-18	6	REAL
1286	CARREFOUR 388 PAN	2022-01-09	300.14	2021-12-20	6	REAL
1287	APPLE.COM/BILL	2022-01-09	9.90	2021-12-20	6	REAL
1288	IFD*PIMENTA DA TERRA R	2022-01-09	37.90	2021-12-21	6	REAL
1289	RAPPI*Rappi Brasil Int	2022-01-09	59.86	2021-12-22	6	REAL
1290	IFD*BRAZZATTO PIZZA LT	2022-01-09	47.00	2021-12-22	6	REAL
1291	VAMO TOMA UMA	2022-01-09	74.25	2021-12-23	6	REAL
1292	UBER *TRIP HELP.UBER.C	2022-01-09	34.99	2021-12-23	6	REAL
1293	IFD*I.B. CAFE LTDA	2022-01-09	50.49	2021-12-25	6	REAL
1294	CINEMARK MOOCA	2022-01-09	60.00	2021-12-26	6	REAL
1295	IFD*SEU TEMPERO RESTAU	2022-01-09	37.00	2021-12-26	6	REAL
1296	IFD*LANCHONETE MELLO	2022-01-09	39.64	2021-12-27	6	REAL
1297	IOF TRANSACOES INTERNACIONAIS	2022-01-09	0.57	2021-12-28	6	REAL
1266	LOCALIZA RAC ACCAE0	2022-01-09	1446.33	2021-12-03	6	REAL
1298	Pagamento fatura 01/2022	2022-01-10	3232.78	2022-01-10	5	REAL
1299	KFC	2022-01-19	9.49	2022-01-18	3	EURO
1300	EDEKA	2022-01-19	12.73	2022-01-18	3	EURO
1301	Pizza	2022-01-19	6.95	2022-01-18	4	EURO
1302	Almoco	2022-01-19	12.50	2022-01-18	4	EURO
1303	Edeka	2022-01-19	37.12	2022-01-14	4	EURO
1304	Solange	2022-01-19	1100.00	2022-01-19	5	REAL
1305	Comgas	2022-01-19	24.32	2022-01-18	5	REAL
1306	Vivo	2022-01-19	146.99	2022-01-17	5	REAL
1307	Mae	2022-01-19	1000.00	2022-01-11	5	REAL
1308	Cafe da Manha	2022-01-22	4.20	2022-01-22	3	EURO
1309	Edeka	2022-01-22	33.54	2022-01-21	3	EURO
1310	Cuecas	2022-01-22	9.99	2022-01-21	3	EURO
1311	Almoco	2022-01-22	7.80	2022-01-21	3	EURO
1312	Jogo	2022-01-22	1.99	2022-01-22	4	EURO
1313	Almoco	2022-01-22	12.80	2022-01-21	4	EURO
1314	Almoco 1	2022-01-22	12.50	2022-01-20	4	EURO
1315	Edeka	2022-01-25	15.49	2022-01-24	3	EURO
1316	almoco	2022-01-25	10.15	2022-01-24	4	EURO
1317	cafe da manha	2022-01-25	6.80	2022-01-24	4	EURO
1318	Jantar	2022-01-25	5.90	2022-01-22	4	EURO
1183	Salario	\N	3387.00	2022-01-28	3	EURO
1319	Saque	2022-01-27	100.00	2022-01-27	3	EURO
1320	Jantar	2022-01-27	8.50	2022-01-27	4	EURO
1321	Almoco	2022-01-27	10.15	2022-01-27	4	EURO
1322	Almoco 2	2022-01-27	7.80	2022-01-26	4	EURO
1323	KFC	2022-01-27	9.49	2022-01-25	4	EURO
1324	Almoco 3	2022-01-27	7.80	2022-01-25	4	EURO
1325	EBANX *SPOTIFY	2022-02-01	19.90	2021-12-28	6	REAL
1326	IFD*XANGAI COMERCIO AR	2022-02-01	34.20	2021-12-29	6	REAL
1327	IFD*EDISON LUIZ DE PAS	2022-02-01	22.98	2021-12-29	6	REAL
1328	IFD*IFOOD.COM AGENCIA	2022-02-01	35.99	2021-12-29	6	REAL
1329	IFD*RESTAURANTE R AZEV	2022-02-01	38.98	2021-12-30	6	REAL
1330	IFD*LANCHONETE MELLO	2022-02-01	39.64	2021-12-30	6	REAL
1331	IFD*CLEUNICE SANTOS HA	2022-02-01	29.99	2021-12-31	6	REAL
1332	SERVICOS CLA*119137304	2022-02-01	25.00	2022-01-02	6	REAL
1333	IFD*SEU TEMPERO RESTAU	2022-02-01	42.00	2022-01-02	6	REAL
1334	LOCALIZA RAC ACCAE0 D	2022-02-01	3980.26	2022-01-02	6	REAL
1335	AmazonPrimeBR	2022-02-01	9.90	2022-01-03	6	REAL
1336	Uber *UBER *TRIP	2022-02-01	29.91	2022-01-03	6	REAL
1337	IFD*GABRIEL PITA 22985	2022-02-01	23.40	2022-01-03	6	REAL
1338	IFD*ESTAIL RESTAURANTE	2022-02-01	36.89	2022-01-03	6	REAL
1339	UBER *TRIP HELP.UBER.C	2022-02-01	24.91	2022-01-03	6	REAL
1340	Amazon.com.br Digital	2022-02-01	19.90	2022-01-03	6	REAL
1341	UBER *TRIP HELP.UBER.C	2022-02-01	24.91	2022-01-04	6	REAL
1342	Uber *UBER *TRIP	2022-02-01	24.96	2022-01-04	6	REAL
1343	UBER *TRIP HELP.UBER.C	2022-02-01	70.93	2022-01-04	6	REAL
1344	IFD*XANGAI COMERCIO AR	2022-02-01	34.20	2022-01-04	6	REAL
1345	Disney Plus	2022-02-01	27.90	2022-01-06	6	REAL
1346	NETFLIX.COM	2022-02-01	39.90	2022-01-11	6	REAL
1347	APPLE.COM/BILL	2022-02-01	9.90	2022-01-20	6	REAL
1348	Metro	2022-02-01	7.00	2022-01-31	3	EURO
1349	Edeka	2022-02-01	41.75	2022-01-29	3	EURO
1351	WeWash	2022-02-01	5.00	2022-02-01	4	EURO
1352	Almoco	2022-02-01	12.50	2022-02-01	4	EURO
1353	Sausalitos	2022-02-01	29.00	2022-01-31	4	EURO
1354	Almoco2	2022-02-01	10.15	2022-01-31	4	EURO
1355	cafe da manha	2022-02-01	7.95	2022-01-31	4	EURO
1356	cafe da manha2	2022-02-01	7.95	2022-01-29	4	EURO
1357	nordvpn	2022-02-01	10.58	2022-01-28	4	EURO
1358	Almoco3	2022-02-01	10.30	2022-01-28	4	EURO
1359	Eletropaulo	2022-02-01	111.92	2022-01-31	5	REAL
1361	Edeka	2022-02-07	38.75	2022-02-04	3	EURO
1362	Almoco	2022-02-07	7.80	2022-02-07	4	EURO
1363	KFC	2022-02-07	9.99	2022-02-05	4	EURO
1364	Almoco 2	2022-02-07	12.65	2022-02-04	4	EURO
1365	Almoco 3	2022-02-07	12.50	2022-02-03	4	EURO
1366	Almoco 4	2022-02-07	12.50	2022-02-02	4	EURO
1367	Doce	2022-02-07	3.79	2022-02-01	4	EURO
1368	Taifa	2022-02-07	71.90	2022-02-02	5	REAL
1369	Condominio	2022-02-07	635.00	2022-02-07	5	REAL
1370	Pagamento fatura 02/2022	2022-02-07	4646.55	2022-02-07	5	REAL
1371	EBANX *SPOTIFY	2022-02-11	19.90	2022-01-28	6	REAL
1372	Amazon.com.br Digital	2022-02-11	19.90	2022-02-03	6	REAL
1373	AmazonPrimeBR	2022-02-11	9.90	2022-02-03	6	REAL
1374	Disney Plus	2022-02-11	27.90	2022-02-06	6	REAL
1375	STEAMGAMES.COM	2022-02-11	22.25	2022-02-08	6	REAL
1377	Axel F	2022-02-11	19.30	2022-02-08	4	EURO
1378	BAECKEREI ZIEGLER	2022-02-11	12.50	2022-02-08	4	EURO
1379	MuNCHNER VERKEHRSGESEL	2022-02-11	7.00	2022-02-09	4	EURO
1380	Baeckerei Ziegler	2022-02-11	6.75	2022-02-11	4	EURO
1381	Baeckerei Ziegler	2022-02-11	12.80	2022-02-11	4	EURO
1382	BAECKEREI ZIEGLER	2022-02-11	6.80	2022-02-10	4	EURO
1383	BAECKEREI ZIEGLER	2022-02-11	10.15	2022-02-10	4	EURO
1384	Edeka Center OEZ	2022-02-11	28.22	2022-02-11	4	EURO
1385	Cueca	2022-02-11	13.19	2022-02-09	3	EURO
1386	Almoco	2022-02-11	12.85	2022-02-09	3	EURO
1387	Corte Cabelo	2022-02-11	35.00	2022-02-09	3	EURO
1388	Cuecas	2022-02-15	40.05	2022-02-14	3	EURO
1389	Gog	2022-02-15	2.19	2022-02-15	4	EURO
1391	Almoco	2022-02-15	12.50	2022-02-14	4	EURO
1392	Comgas	2022-02-15	11.39	2022-02-14	5	REAL
1393	Vivo	2022-02-15	146.99	2022-02-15	5	REAL
1394	Netflix	2022-02-15	39.90	2022-02-11	6	REAL
1395	Saque	2022-02-16	100.00	2022-02-16	3	EURO
1396	Almoco	2022-02-16	10.15	2022-02-16	3	EURO
1397	cafe da manha	2022-02-16	6.75	2022-02-16	3	EURO
1360	Salario	\N	3477.00	2022-02-23	3	EURO
1398	Almoco	2022-02-25	12.65	2022-02-25	3	EURO
1399	Saida	2022-02-25	17.00	2022-02-24	3	EURO
1400	Almoco	2022-02-25	8.50	2022-02-24	3	EURO
1401	Metro	2022-02-25	18.60	2022-02-23	3	EURO
1402	Cafe da manha	2022-02-25	7.05	2022-02-22	3	EURO
1403	Edeka	2022-02-25	36.49	2022-02-22	3	EURO
1404	Almoco	2022-02-25	10.15	2022-02-18	3	EURO
1405	Almoco	2022-02-25	10.15	2022-02-18	3	EURO
1406	cafe da manha	2022-02-25	6.75	2022-02-18	3	EURO
1407	Cobrir Conta	\N	200.00	2022-02-28	3	EURO
1410	Almoco	2022-03-01	8.85	2022-02-28	3	EURO
1411	cafe da manha	2022-03-01	6.75	2022-02-28	3	EURO
1412	janta	2022-03-01	6.50	2022-02-28	3	EURO
1413	Supermercadp	2022-03-01	35.45	2022-02-26	3	EURO
1414	imposto	2022-03-01	1.14	2022-02-28	3	EURO
1416	WeWash	2022-03-01	15.00	2022-03-01	4	EURO
1418	Steam Games	2022-03-01	19.13	2022-02-16	6	REAL
1420	Apple+	2022-03-01	9.90	2022-02-20	6	REAL
1421	Imposto	2022-03-01	2.64	2022-02-15	6	REAL
1427	Condomino	2022-03-06	635.00	2022-03-06	5	REAL
1428	Pagamento fatura 03/2022	2022-03-06	171.42	2022-03-06	5	REAL
1429	Pacote Itau	2022-03-06	71.90	2022-03-04	5	REAL
1430	Eletropaulo	2022-03-06	35.98	2022-03-02	5	REAL
1439	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-25	3	EURO
1440	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-24	3	EURO
1441	KFC 1039	2022-03-27	8.49	2022-03-23	3	EURO
1442	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-23	3	EURO
1443	LEV ATM 6251 DEU 22201292 Muenchen	2022-03-27	100.00	2022-03-23	3	EURO
1444	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-22	3	EURO
1445	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-22	3	EURO
1446	EDEKA CENTER OEZ	2022-03-27	36.29	2022-03-22	3	EURO
1447	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-18	3	EURO
1448	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-18	3	EURO
1449	BAECKEREI ZIEGLER	2022-03-27	0.96	2022-03-18	3	EURO
1450	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-18	3	EURO
1451	BAECKEREI ZIEGLER	2022-03-27	2.35	2022-03-17	3	EURO
1452	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-17	3	EURO
1453	BAECKEREI ZIEGLER	2022-03-27	6.80	2022-03-17	3	EURO
1454	BAECKEREI ZIEGLER	2022-03-27	5.85	2022-03-16	3	EURO
1455	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-16	3	EURO
1456	BAECKEREI ZIEGLER	2022-03-27	10.85	2022-03-16	3	EURO
1457	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-15	3	EURO
1458	MODEFRISEUR BLATTER	2022-03-27	35.00	2022-03-15	3	EURO
1459	BAECKEREI ZIEGLER	2022-03-27	8.85	2022-03-15	3	EURO
1460	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-15	3	EURO
1461	EDEKA CENTER OEZ	2022-03-27	36.25	2022-03-15	3	EURO
1462	BAckerei Wimmer Fil.39	2022-03-27	2.95	2022-03-11	3	EURO
1463	Milano s GmbH Muenchen	2022-03-27	8.50	2022-03-11	3	EURO
1464	BAECKEREI ZIEGLER	2022-03-27	10.15	2022-03-11	3	EURO
1465	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-11	3	EURO
1466	KAIMUG RESTAURANT GMBH	2022-03-27	12.85	2022-03-11	3	EURO
1467	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-11	3	EURO
1468	BAECKEREI ZIEGLER	2022-03-27	12.50	2022-03-11	3	EURO
1469	BAECKEREI ZIEGLER	2022-03-27	12.50	2022-03-10	3	EURO
1470	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-10	3	EURO
1471	BAECKEREI ZIEGLER	2022-03-27	8.23	2022-03-09	3	EURO
1472	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-09	3	EURO
1473	KFC 1039	2022-03-27	8.49	2022-03-09	3	EURO
1474	BAECKEREI ZIEGLER	2022-03-27	12.65	2022-03-08	3	EURO
1475	EDEKA CENTER OEZ	2022-03-27	24.68	2022-03-08	3	EURO
1476	BAECKEREI ZIEGLER	2022-03-27	12.50	2022-03-04	3	EURO
1477	BAECKEREI ZIEGLER	2022-03-27	4.70	2022-03-04	3	EURO
1478	BAECKEREI ZIEGLER	2022-03-27	10.15	2022-03-04	3	EURO
1479	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-04	3	EURO
1480	LEV ATM 6251 DEU STADTSPARKASSE	2022-03-27	100.00	2022-03-04	3	EURO
1481	BAECKEREI ZIEGLER	2022-03-27	6.75	2022-03-03	3	EURO
1482	BAECKEREI ZIEGLER	2022-03-27	10.15	2022-03-03	3	EURO
1483	Edeka	2022-03-27	41.57	2022-03-26	3	EURO
1484	Cafe da Manha	2022-03-27	6.75	2022-03-26	3	EURO
1485	Almoco	2022-03-27	10.85	2022-03-25	3	EURO
1486	Cafe da Manha2	2022-03-27	6.75	2022-03-25	3	EURO
1487	KFC	2022-03-27	8.79	2022-02-27	3	EURO
1488	MIlanos	2022-03-27	6.75	2022-03-26	3	EURO
1489	Uber	2022-03-27	12.73	2022-03-24	4	EURO
1490	Vodaphone	2022-03-27	50.00	2022-03-24	4	EURO
1491	MVG	2022-03-27	7.00	2022-03-24	4	EURO
1492	Gog	2022-03-27	15.59	2022-03-23	4	EURO
1494	Comgas	2022-03-27	9.72	2022-03-16	5	REAL
1495	vivo	2022-03-27	146.99	2022-03-15	5	REAL
1415	salario	\N	3387.00	2022-03-31	3	EURO
1496	BAECKEREI ZIEGLER	2022-04-09	6.20	2022-04-08	3	EURO
1497	EDEKA M ERIKA MANN 880	2022-04-09	7.90	2022-04-08	3	EURO
1498	KFC 1039	2022-04-09	2.49	2022-04-08	3	EURO
1499	KFC 1039	2022-04-09	8.49	2022-04-08	3	EURO
1500	MUNCHNER VERKEHRSGESEL	2022-04-09	18.60	2022-04-08	3	EURO
1501	BAECKEREI ZIEGLER	2022-04-09	6.75	2022-04-08	3	EURO
1502	EDEKA M ERIKA MANN 880	2022-04-09	5.84	2022-04-08	3	EURO
1503	BAECKEREI ZIEGLER	2022-04-09	10.85	2022-04-07	3	EURO
1504	BAECKEREI ZIEGLER	2022-04-09	6.75	2022-04-07	3	EURO
1505	KAIMUG RESTAURANT GMBH	2022-04-09	12.85	2022-04-06	3	EURO
1506	BAECKEREI ZIEGLER	2022-04-09	10.85	2022-04-06	3	EURO
1507	BAECKEREI ZIEGLER	2022-04-09	6.75	2022-04-06	3	EURO
1508	ALDI SUED Muenchen	2022-04-09	1.59	2022-04-06	3	EURO
1509	BAECKEREI ZIEGLER	2022-04-09	6.75	2022-04-05	3	EURO
1510	EDEKA CENTER OEZ	2022-04-09	21.59	2022-04-05	3	EURO
1511	BAECKEREI ZIEGLER	2022-04-09	10.85	2022-04-05	3	EURO
1512	MUNCHNER VERKEHRSGESEL	2022-04-09	3.50	2022-04-04	3	EURO
1513	MILLE MIGLIA MUENCHEN	2022-04-09	33.10	2022-04-04	3	EURO
1514	BAECKEREI ZIEGLER	2022-04-09	6.75	2022-04-04	3	EURO
1515	BAECKEREI ZIEGLER	2022-04-09	10.85	2022-04-01	3	EURO
1516	BAECKEREI ZIEGLER	2022-04-09	7.95	2022-04-01	3	EURO
1517	EDEKA CENTER OEZ	2022-04-09	20.99	2022-04-01	3	EURO
1518	BAECKEREI ZIEGLER	2022-04-09	10.85	2022-03-31	3	EURO
1519	BAECKEREI ZIEGLER	2022-04-09	10.85	2022-03-30	3	EURO
1520	Edeka	2022-04-09	53.42	2022-04-09	3	EURO
1521	Saque	2022-04-09	100.00	2022-04-08	3	EURO
1522	janta	2022-04-09	10.50	2022-04-08	3	EURO
1523	Cafe da manha	2022-04-09	6.75	2022-04-08	3	EURO
1525	Pacote	2022-04-09	71.90	2022-04-04	5	REAL
1526	Eletropaulo	2022-04-09	24.38	2022-03-29	5	REAL
1527	WeWash	2022-04-09	10.00	2022-04-03	4	EURO
1528	ANUIDADE DIFERENCIADA 05/12	2022-04-09	26.00	2022-02-28	6	REAL
1529	EBANX *SPOTIFY CURITIBA BR	2022-04-09	19.90	2022-02-28	6	REAL
1530	AmazonPrimeBR SAO PAULO BR	2022-04-09	9.90	2022-03-03	6	REAL
1531	Amazon Digital BR SAO PAULO BR	2022-04-09	19.90	2022-03-03	6	REAL
1532	Disney Plus SAO PAULO BR	2022-04-09	27.90	2022-03-06	6	REAL
1533	NETFLIX.COM SAO PAULO BR	2022-04-09	39.90	2022-03-11	6	REAL
1534	APPLE.COM/BILL SAO PAULO BR	2022-04-09	9.90	2022-03-20	6	REAL
1524	Salário	\N	3440.00	2022-04-27	3	EURO
1535	Cobrir Conta	\N	200.00	2022-04-25	3	EURO
1536	MUNCHNER VERKEHRSGESEL	2022-05-18	18.60	2022-05-18	3	EURO
1537	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-18	3	EURO
1538	SANI PLUSAPOTHEKE MUEN	2022-05-18	13.99	2022-05-17	3	EURO
1539	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-17	3	EURO
1540	EDEKA CENTER OEZH	2022-05-18	41.24	2022-05-17	3	EURO
1541	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-17	3	EURO
1542	La Pizza EnricoRossini	2022-05-18	8.50	2022-05-13	3	EURO
1543	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-13	3	EURO
1544	EDEKA CENTER OEZH	2022-05-18	11.39	2022-05-13	3	EURO
1545	BAECKEREI ZIEGLER	2022-05-18	11.95	2022-05-13	3	EURO
1546	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-13	3	EURO
1547	LEV ATM 6251 DEU STADTSPARKASSEHE OLYEIN	2022-05-18	100.00	2022-05-13	3	EURO
1548	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-12	3	EURO
1549	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-12	3	EURO
1550	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-11	3	EURO
1551	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-11	3	EURO
1552	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-10	3	EURO
1553	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-10	3	EURO
1554	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-10	3	EURO
1555	BAECKEREI ZIEGLER	2022-05-18	9.65	2022-05-10	3	EURO
1556	EDEKA CENTER OEZH	2022-05-18	44.43	2022-05-10	3	EURO
1557	KFC 1039	2022-05-18	8.49	2022-05-09	3	EURO
1558	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-09	3	EURO
1559	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-09	3	EURO
1560	DB Automaten MUnchen	2022-05-18	3.50	2022-05-09	3	EURO
1561	SumUp Pasta Traum Marti	2022-05-18	7.50	2022-05-06	3	EURO
1562	MUNCHNER VERKEHRSGESEL	2022-05-18	7.00	2022-05-06	3	EURO
1563	BAECKEREI ZIEGLER	2022-05-18	8.40	2022-05-06	3	EURO
1564	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-05	3	EURO
1565	BAECKEREI ZIEGLER	2022-05-18	10.95	2022-05-04	3	EURO
1566	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-04	3	EURO
1567	BAECKEREI ZIEGLER	2022-05-18	7.30	2022-05-03	3	EURO
1568	EDEKA CENTER OEZH	2022-05-18	42.95	2022-05-03	3	EURO
1569	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-05-03	3	EURO
1570	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-05-03	3	EURO
1571	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-05-02	3	EURO
1572	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-05-02	3	EURO
1573	EDEKA CENTER OEZH	2022-05-18	21.79	2022-05-02	3	EURO
1574	MUNCHNER VERKEHRSGESEL	2022-05-18	7.00	2022-05-02	3	EURO
1575	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-05-02	3	EURO
1576	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-04-28	3	EURO
1577	KFC 1039	2022-05-18	8.49	2022-04-27	3	EURO
1578	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-04-27	3	EURO
1579	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-26	3	EURO
1580	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-26	3	EURO
1581	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-04-26	3	EURO
1582	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-26	3	EURO
1583	EDEKA CENTER OEZH	2022-05-18	56.31	2022-04-26	3	EURO
1584	Comissao Emissao s/ Ordem Pag.  Ref.20220703129	2022-05-18	1.10	2022-04-25	3	EURO
1585	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20220703129	2022-05-18	0.04	2022-04-25	3	EURO
1586	BAECKEREI ZIEGLER	2022-05-18	4.45	2022-04-22	3	EURO
1587	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-04-22	3	EURO
1588	Tap House	2022-05-18	19.00	2022-04-22	3	EURO
1589	MUNCHNER VERKEHRSGESEL	2022-05-18	7.00	2022-04-22	3	EURO
1590	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-22	3	EURO
1591	SATURN ELECTROHANDELS	2022-05-18	9.99	2022-04-21	3	EURO
1592	TretterSchuhehen	2022-05-18	99.90	2022-04-21	3	EURO
1593	MODEFRISEUR BLATTER MUE	2022-05-18	35.00	2022-04-21	3	EURO
1594	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-04-21	3	EURO
1595	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-21	3	EURO
1596	KFC 1039	2022-05-18	10.98	2022-04-20	3	EURO
1597	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-20	3	EURO
1598	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-20	3	EURO
1599	EDEKA CENTER OEZH	2022-05-18	20.57	2022-04-20	3	EURO
1600	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-19	3	EURO
1601	BAECKEREI ZIEGLER	2022-05-18	10.85	2022-04-19	3	EURO
1602	EDEKA CENTER OEZH	2022-05-18	19.10	2022-04-19	3	EURO
1603	MUNCHNER VERKEHRSGESEL	2022-05-18	18.60	2022-04-14	3	EURO
1604	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-14	3	EURO
1605	Lilli P.	2022-05-18	11.00	2022-04-14	3	EURO
1606	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-14	3	EURO
1607	BAECKEREI ZIEGLER	2022-05-18	6.75	2022-04-13	3	EURO
1608	EDEKA M ERIKA MANN 880	2022-05-18	14.73	2022-04-13	3	EURO
1609	BAECKEREI ZIEGLER	2022-05-18	7.25	2022-04-12	3	EURO
1611	WeWash	2022-05-18	18.00	2022-05-03	4	EURO
1612	Academia	2022-05-18	94.00	2022-04-29	4	EURO
1613	Gog	2022-05-18	4.19	2022-04-29	4	EURO
1614	Uber	2022-05-18	21.28	2022-04-20	4	EURO
1616	comgas	2022-05-18	9.72	2022-05-16	5	REAL
1617	condominio	2022-05-18	635.00	2022-05-11	5	REAL
1618	Pagamento fatura 04/2022	2022-05-11	153.40	2022-05-18	5	REAL
1619	pacote	2022-05-18	71.90	2022-05-03	5	REAL
1620	eletropaulo	2022-05-18	24.39	2022-04-29	5	REAL
1621	contas mae	2022-05-18	800.00	2022-04-28	5	REAL
1622	vivo	2022-05-18	146.99	2022-04-18	5	REAL
1623	comgas	2022-05-18	9.72	2022-04-14	5	REAL
1615	Vivo	2022-05-18	146.75	2022-05-16	5	REAL
1624	PAD PORT RESTELO LISBOA	2022-06-19	4.90	2022-06-16	3	EURO
1625	PORTOBAY FALESIA ALBUFE	2022-06-19	91.75	2022-06-16	3	EURO
1626	4S HAMBURGUER HOUSE LIS	2022-06-19	10.94	2022-06-15	3	EURO
1627	CAFFE CREME ALBUFEIRA P	2022-06-19	30.30	2022-06-15	3	EURO
1628	IMPOSTO DO SELO	2022-06-19	0.04	2022-06-14	3	EURO
1629	CUSTO DE SERVICO INTERNACIONAL	2022-06-19	1.12	2022-06-14	3	EURO
1630	VIATOR IT-1284814038 LONDON GB	2022-06-19	29.00	2022-06-14	3	EURO
1631	PORTO BAY FALESIA ALBUF	2022-06-19	910.00	2022-06-14	3	EURO
1632	BRISA AREAS SERVICO GRA	2022-06-19	8.70	2022-06-14	3	EURO
1633	ALGARFAVORITA LDA GUIA	2022-06-19	14.99	2022-06-14	3	EURO
1634	WINE TAPAS LISBOA PR	2022-06-19	22.35	2022-06-14	3	EURO
1635	EST SERVICO A S ALJUSTREL ALJUSTREL	2022-06-19	45.80	2022-06-13	3	EURO
1636	BODY CONCEPT LISBOA PR	2022-06-19	16.00	2022-06-13	3	EURO
1637	MARITIMA DO RESTELO LIS	2022-06-19	19.00	2022-06-13	3	EURO
1638	Comissao Emissao s/ Ordem Pag.  Ref.20221041613	2022-06-19	1.10	2022-06-09	3	EURO
1639	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20221041613	2022-06-19	0.04	2022-06-09	3	EURO
1640	4S HAMBURGUER HOUSE LIS	2022-06-19	7.99	2022-06-08	3	EURO
1641	CONFEITARIA MARQUES LIS	2022-06-19	2.55	2022-06-08	3	EURO
1642	PAD PORT BAR SALG LISBO	2022-06-19	6.40	2022-06-07	3	EURO
1643	XB BARBEARIA 1150-109 LISBOA	2022-06-19	28.00	2022-06-07	3	EURO
1644	MARQUES POMBAL 1 LISBOA	2022-06-19	40.00	2022-06-07	3	EURO
1645	N E N HOTELARIA LDA LIS	2022-06-19	42.00	2022-06-07	3	EURO
1646	4S HAMBURGUER HOUSE LIS	2022-06-19	13.69	2022-06-07	3	EURO
1647	PINGO DOCE RESTELO LISB	2022-06-19	26.17	2022-06-07	3	EURO
1648	NUVEM MATRIARCA LDA LIS	2022-06-19	6.85	2022-06-07	3	EURO
1649	CONFEIT MARQUE POMBA LI	2022-06-19	2.60	2022-06-07	3	EURO
1650	Comissao Emissao s/ Ordem Pag.  Ref.20221011447	2022-06-19	1.10	2022-06-06	3	EURO
1651	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20221011447	2022-06-19	0.04	2022-06-06	3	EURO
1652	LEV ATM 6251 BESCL Lisboa	2022-06-19	100.00	2022-06-06	3	EURO
1653	LUFTHANSA 2608679092 MU	2022-06-19	60.00	2022-06-03	3	EURO
1654	FUERSTENLOUNGE E4 T2 MU	2022-06-19	11.10	2022-06-02	3	EURO
1655	THE FLAG MUENCHEN M. MU	2022-06-19	14.50	2022-06-02	3	EURO
1656	EDEKA M ERIKA MANN 880	2022-06-19	9.60	2022-06-02	3	EURO
1657	4S HAMBURGUER HOUSE LIS	2022-06-19	13.69	2022-06-02	3	EURO
1658	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2022-06-19	7.00	2022-06-01	3	EURO
1659	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2022-06-19	7.00	2022-06-01	3	EURO
1660	BAECKEREI ZIEGLER MUENC	2022-06-19	8.50	2022-06-01	3	EURO
1661	LEV ATM 6251 DEU STADTSPARKASSE MUENCHE OLY.EKZ	2022-06-19	100.00	2022-06-01	3	EURO
1662	BAECKEREI ZIEGLER MUENC	2022-06-19	7.30	2022-05-31	3	EURO
1663	EDEKA CENTER OEZ MUENCH	2022-06-19	29.10	2022-05-31	3	EURO
1664	BAECKEREI ZIEGLER MUENC	2022-06-19	10.95	2022-05-31	3	EURO
1665	BAECKEREI ZIEGLER MUENC	2022-06-19	7.30	2022-05-31	3	EURO
1666	Comissao Emissao s/ Ordem Pag.  Ref.20220954522	2022-06-19	1.10	2022-05-30	3	EURO
1667	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20220954522	2022-06-19	0.04	2022-05-30	3	EURO
1668	BAECKEREI ZIEGLER MUENC	2022-06-19	7.30	2022-05-27	3	EURO
1669	BAECKEREI ZIEGLER MUENC	2022-06-19	11.95	2022-05-27	3	EURO
1670	EDEKA CENTER OEZ MUENCH	2022-06-19	39.26	2022-05-27	3	EURO
1671	BAECKEREI ZIEGLER MUENC	2022-06-19	10.95	2022-05-26	3	EURO
1672	BAECKEREI ZIEGLER MUENC	2022-06-19	7.30	2022-05-26	3	EURO
1673	Lieferando.de lieferse Amsterdam NL	2022-06-19	13.23	2022-05-26	3	EURO
1674	KFC 1039 MUNCHEN DE	2022-06-19	8.49	2022-05-25	3	EURO
1675	BAECKEREI ZIEGLER MUENC	2022-06-19	10.95	2022-05-25	3	EURO
1676	BAECKEREI ZIEGLER MUENC	2022-06-19	7.30	2022-05-25	3	EURO
1677	EDEKA CENTER OEZ MUENCH	2022-06-19	36.84	2022-05-25	3	EURO
1678	ZTL SOEREN RABE MARKT S	2022-06-19	10.50	2022-05-24	3	EURO
1679	BAECKEREI ZIEGLER MUENC	2022-06-19	7.30	2022-05-24	3	EURO
1610	Salário	\N	3477.00	2022-05-26	3	EURO
1680	Cobrir Conta	\N	1000.00	2022-06-09	3	EURO
1681	Cobrir Conta	\N	1000.00	2022-06-06	3	EURO
1682	Cobrir Conta	\N	200.00	2022-05-30	3	EURO
1684	Europcar	2022-06-19	751.29	2022-06-16	4	EURO
1685	UBER	2022-06-19	7.67	2022-06-12	4	EURO
1686	Mollie *WeWash GmbH	2022-06-19	18.00	2022-06-04	4	EURO
1687	UBER   *TRIP	2022-06-19	72.76	2022-05-31	4	EURO
1688	UBER   *TRIP	2022-06-19	12.39	2022-05-31	4	EURO
1689	body + soul group AG & Co. KG	2022-06-19	94.00	2022-05-31	4	EURO
1690	Vodafone GmbH CallYa	2022-06-19	25.00	2022-05-30	4	EURO
1691	Padaria	2022-06-19	3.50	2022-06-19	3	EURO
1692	pingo de ouro	2022-06-19	8.55	2022-06-18	3	EURO
1693	saque	2022-06-19	100.00	2022-06-18	3	EURO
1694	janta	2022-06-19	12.90	2022-06-17	3	EURO
1695	padaria 1	2022-06-19	3.50	2022-06-17	3	EURO
1696	EBANX SPOTIFY	2022-06-19	19.90	2022-03-29	6	REAL
1697	ANUIDADE DIFERENCIADA 06/12	2022-06-19	26.00	2022-03-29	6	REAL
1698	Amazon.com.br Digital	2022-06-19	19.90	2022-04-03	6	REAL
1699	AmazonPrimeBR	2022-06-19	9.90	2022-04-03	6	REAL
1700	Disney Plus	2022-06-19	27.90	2022-04-06	6	REAL
1701	NETFLIX.COM	2022-06-19	39.90	2022-04-11	6	REAL
1702	APPLE.COM/BILL	2022-06-19	9.90	2022-04-20	6	REAL
1703	EBANX SPOTIFY	2022-06-19	19.90	2022-04-29	6	REAL
1704	ANUIDADE DIFERENCIADA 07/12	2022-06-19	26.00	2022-04-29	6	REAL
1705	AmazonPrimeBR	2022-06-19	9.90	2022-05-03	6	REAL
1706	Amazon.com.br Digital	2022-06-19	19.90	2022-05-03	6	REAL
1707	Disney Plus	2022-06-19	27.90	2022-05-06	6	REAL
1708	NETFLIX.COM	2022-06-19	39.90	2022-05-11	6	REAL
1709	APPLE.COM/BILL	2022-06-19	9.90	2022-05-20	6	REAL
1710	Pagamento fatura 06/2022	2022-06-09	153.40	2022-06-19	5	REAL
1711	DA  ELETROPAULO 56301179	2022-06-19	20.10	2022-05-30	5	REAL
1712	TAR PACOTE ITAU   MAI/22	2022-06-19	71.90	2022-06-02	5	REAL
1713	INT PAG TIT 109005364281	2022-06-19	635.00	2022-06-09	5	REAL
1714	DA  COMGAS 48353698	2022-06-19	9.72	2022-06-14	5	REAL
1715	DA  VIVO FIXO 9324810660	2022-06-19	145.99	2022-06-15	5	REAL
1716	Restituicao	2022-07-03	1244.00	2022-06-24	3	EURO
1775	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20221318048	2022-08-04	0.04	2022-07-19	3	EURO
1717	Salário	2022-07-03	1458.00	2022-06-28	3	EURO
1718	MINIPRECO BARATA SAL LI	2022-07-03	5.26	2022-07-01	3	EURO
1719	MARQUES POMBAL 1 LISBOA	2022-07-03	40.00	2022-06-30	3	EURO
1720	PAD PORT MARQUES POM LI	2022-07-03	3.50	2022-06-30	3	EURO
1721	LEV ATM 6251 BBV Lisboa Av da Liberdad	2022-07-03	100.00	2022-06-29	3	EURO
1722	PAD PORT MARQUES POM LI	2022-07-03	3.50	2022-06-29	3	EURO
1723	Glovo 27JUN LIEK1H8NK Lisbon PR	2022-07-03	12.22	2022-06-29	3	EURO
1724	PAD PORT RESTELO LISBOA	2022-07-03	4.90	2022-06-28	3	EURO
1725	Glovo 26JUN LI1A4TBPE Lisbon PR	2022-07-03	10.89	2022-06-28	3	EURO
1726	PAD PORT RESTELO LISBOA	2022-07-03	4.90	2022-06-28	3	EURO
1727	PINGO DOCE RESTELO LISB	2022-07-03	16.59	2022-06-28	3	EURO
1728	PAD PORT MARQUES POM LI	2022-07-03	4.10	2022-06-28	3	EURO
1729	PAD PORT MARQUES POM LI	2022-07-03	3.50	2022-06-24	3	EURO
1730	PAD PORT MARQUES POM LI	2022-07-03	3.50	2022-06-24	3	EURO
1731	LEV ATM 6251 BBV Lisboa Av da Liberdad	2022-07-03	100.00	2022-06-23	3	EURO
1732	PAD PORT MARQUES POM LI	2022-07-03	3.80	2022-06-23	3	EURO
1733	PAD PORT MARQUES POM LI	2022-07-03	3.50	2022-06-22	3	EURO
1734	Worten Sacola	2022-07-03	0.20	2022-07-02	3	EURO
1735	Aspirador	2022-07-03	59.99	2022-07-02	3	EURO
1736	Padaria	2022-07-03	5.20	2022-07-02	3	EURO
1737	Padaria2	2022-07-03	5.20	2022-07-01	3	EURO
1739	Almoco	2022-07-03	12.89	2022-07-02	4	EURO
1740	Supemercado	2022-07-03	25.27	2022-07-02	4	EURO
1741	Body And Soul	2022-07-03	94.00	2022-06-30	4	EURO
1742	Europcar	2022-07-03	45.05	2022-06-30	4	EURO
1743	Uber 1	2022-07-03	3.58	2022-06-30	4	EURO
1744	Uber 2	2022-07-03	3.25	2022-06-30	4	EURO
1745	Uber 3	2022-07-03	8.50	2022-06-30	4	EURO
1746	Condominio	2022-07-03	664.00	2022-07-04	5	REAL
1747	Luz	2022-07-03	19.65	2022-06-29	5	REAL
1748	EBANX SPOTIFY	2022-07-03	19.90	2022-05-29	6	REAL
1749	ANUIDADE DIFERENCIADA 08/12	2022-07-03	26.00	2022-05-29	6	REAL
1750	AmazonPrimeBR	2022-07-03	9.90	2022-06-03	6	REAL
1751	Amazon.com.br Digital	2022-07-03	19.90	2022-06-03	6	REAL
1752	Disney Plus	2022-07-03	27.90	2022-06-06	6	REAL
1753	NETFLIX.COM	2022-07-03	39.90	2022-06-11	6	REAL
1754	APPLE.COM/BILL	2022-07-03	9.90	2022-06-20	6	REAL
1757	TAKEAWAY S. VICENTE BRA	2022-08-04	5.60	2022-08-04	3	EURO
1758	LEV ATM	2022-08-04	100.00	2022-07-29	3	EURO
1759	PLURICOSMETICA PORTO PR	2022-08-04	1.25	2022-07-29	3	EURO
1760	TELEPIZZA BRAGANCA BRAG	2022-08-04	12.95	2022-07-28	3	EURO
1761	Grab And Fly Term A Zav	2022-08-04	4.10	2022-07-27	3	EURO
1762	Cafe Comptoir Zaventem	2022-08-04	13.40	2022-07-27	3	EURO
1763	CRF EXP CONGRES BRUXELL	2022-08-04	4.35	2022-07-27	3	EURO
1764	Belgian Chocolate Hous	2022-08-04	5.45	2022-07-27	3	EURO
1765	Per Bacco bruxelles	2022-08-04	20.00	2022-07-26	3	EURO
1766	LOJA SOHO LISBOA PR	2022-08-04	2.40	2022-07-26	3	EURO
1767	CONFEITARIA NACIONAL LI	2022-08-04	10.90	2022-07-26	3	EURO
1768	MOTEL ONE BRUXELLES BRU	2022-08-04	6.50	2022-07-26	3	EURO
1769	MOTEL ONE BRUXELLES BRU	2022-08-04	113.24	2022-07-26	3	EURO
1770	Flibtravel Internation	2022-08-04	17.50	2022-07-26	3	EURO
1771	PAD PORT MARQUES POM LI	2022-08-04	6.20	2022-07-26	3	EURO
1772	PAD PORT MARQUES POM LI	2022-08-04	5.20	2022-07-26	3	EURO
1773	PAD PORT MARQUES POM LI	2022-08-04	5.20	2022-07-20	3	EURO
1774	Comissao Emissao s/ Ordem Pag.  Ref.20221318048	2022-08-04	1.10	2022-07-19	3	EURO
1776	PAD PORT AMOREIRA LISBO	2022-08-04	5.55	2022-07-19	3	EURO
1777	PAD PORT AMOREIRA LISBO	2022-08-04	6.45	2022-07-19	3	EURO
1778	PINGO DOCE CAMPOLIDE LI	2022-08-04	6.23	2022-07-19	3	EURO
1779	PAD PORT MARQUES POM LI	2022-08-04	6.20	2022-07-19	3	EURO
1780	LEV ATM	2022-08-04	100.00	2022-07-15	3	EURO
1781	PAD PORT MARQUES POM LI	2022-08-04	6.20	2022-07-15	3	EURO
1782	XB BARBEARIA 1150109 LISBOA	2022-08-04	30.00	2022-07-14	3	EURO
1783	PAD PORT MAR POMBAL LIS	2022-08-04	6.20	2022-07-14	3	EURO
1784	PAD PORT MARQUES POM LI	2022-08-04	6.20	2022-07-14	3	EURO
1785	PAD PORT MARQUES POM LI	2022-08-04	6.20	2022-07-13	3	EURO
1755	Pagamento fatura 07/2022	2022-07-04	153.40	2022-07-03	5	REAL
1786	PAD PORT AMOREIRA LISBO	2022-08-04	5.55	2022-07-12	3	EURO
1787	PAD PORT MARQUES POM LI	2022-08-04	6.20	2022-07-12	3	EURO
1788	PAD PORT MARQUES POM LI	2022-08-04	5.20	2022-07-11	3	EURO
1789	IMPOSTO DE SELO 17.3.4	2022-08-04	0.21	2022-07-08	3	EURO
1790	COM. MANUTENCAO CONTA ORDENADO 062022	2022-08-04	5.20	2022-07-08	3	EURO
1791	PAD PORT MARQUES POM LI	2022-08-04	3.75	2022-07-08	3	EURO
1792	PAD PORT MARQUES POM LI	2022-08-04	5.20	2022-07-07	3	EURO
1793	PAD PORT MARQUES POM LI	2022-08-04	3.75	2022-07-06	3	EURO
1794	PAD PORT RESTELO LISBOA	2022-08-04	5.15	2022-07-05	3	EURO
1795	SAlario	2022-08-04	3677.32	2022-07-28	3	EURO
1796	Cobrir Conta	\N	2000.00	2022-07-19	3	EURO
1797	Ajuste	2022-08-04	90.63	2022-07-05	3	EURO
1798	Europcar Refund	2022-08-04	45.05	2022-07-08	4	EURO
1799	UBER   *TRIP	2022-08-04	8.50	2022-07-01	4	EURO
1800	UBER   *TRIP	2022-08-04	3.58	2022-07-02	4	EURO
1801	UBER   *TRIP	2022-08-04	3.25	2022-07-02	4	EURO
1802	Glovo 02JUL LID9X1BJM	2022-08-04	12.89	2022-07-03	4	EURO
1803	Glovo 02JUL LIAA85SQU	2022-08-04	25.57	2022-07-03	4	EURO
1804	Glovo GLOVO PRIME	2022-08-04	33.79	2022-07-09	4	EURO
1805	Glovo GLOVO PRIME	2022-08-04	46.04	2022-07-10	4	EURO
1806	Glovo GLOVO PRIME	2022-08-04	16.20	2022-07-11	4	EURO
1807	Glovo 13JUL LI6S49YSP	2022-08-04	13.20	2022-07-14	4	EURO
1808	Glovo 14JUL LI2ACBVNN	2022-08-04	11.09	2022-07-14	4	EURO
1809	Glovo GLOVO PRIME	2022-08-04	11.44	2022-07-17	4	EURO
1810	Glovo GLOVO PRIME	2022-08-04	10.79	2022-07-18	4	EURO
1811	Google Niantic Inc	2022-08-04	0.23	2022-07-18	4	EURO
1812	Glovo 18JUL LI2L8U2QN	2022-08-04	15.49	2022-07-19	4	EURO
1813	Glovo 20JUL LIWRDYDL6	2022-08-04	17.99	2022-07-21	4	EURO
1814	Glovo 21JUL LIFDPC1DJ	2022-08-04	20.49	2022-07-22	4	EURO
1815	Glovo 22JUL LIXY6SKBH	2022-08-04	15.44	2022-07-23	4	EURO
1816	HF HOTELS	2022-08-04	519.00	2022-07-23	4	EURO
1817	Vodafone GmbH CallYa	2022-08-04	50.00	2022-07-24	4	EURO
1818	Glovo 23JUL LITL1ZTR3	2022-08-04	20.49	2022-07-24	4	EURO
1819	RYANAIR	2022-08-04	3.00	2022-07-25	4	EURO
1820	UBER   *TRIP	2022-08-04	11.07	2022-07-25	4	EURO
1821	UBER   *TRIP	2022-08-04	9.07	2022-07-25	4	EURO
1822	Glovo 25JUL LILZGLM21	2022-08-04	8.98	2022-07-26	4	EURO
1823	Glovo 25JUL LIEBVRT1K	2022-08-04	11.48	2022-07-26	4	EURO
1824	UBER   *TRIP	2022-08-04	48.37	2022-07-26	4	EURO
1825	AIRBNB * HM3SM4DZNP	2022-08-04	623.50	2022-07-27	4	EURO
1826	Glovo 26JUL LI5KWMKSE	2022-08-04	11.80	2022-07-27	4	EURO
1827	Glovo 27JUL LI4Q246CR	2022-08-04	14.99	2022-07-28	4	EURO
1828	UBER   *TRIP	2022-08-04	3.25	2022-07-28	4	EURO
1829	Glovo 28JUL LIPZCMVF1	2022-08-04	16.18	2022-07-29	4	EURO
1830	body + soul group AG & Co. KG	2022-08-04	94.00	2022-07-29	4	EURO
1831	Glovo 29JUL LIMNL3GH8	2022-08-04	12.09	2022-07-30	4	EURO
1833	SUPER SABORES PARADA DE TIBAES	2022-11-22	6.10	2022-08-30	3	EURO
1834	AS TIBIAS DE JOAO BRAGA	2022-11-22	3.75	2022-08-30	3	EURO
1835	Glovo 28AUG BRL4RY1DG Lisbon PR	2022-11-22	27.31	2022-08-30	3	EURO
1836	Glovo 28AUG BRH1RDWJN Lisbon PR	2022-11-22	9.59	2022-08-30	3	EURO
1837	Glovo 28AUG BRCNSM9GZ Lisbon PR	2022-11-22	9.48	2022-08-30	3	EURO
1838	ATIPICO BRAGA PR	2022-11-22	18.10	2022-08-30	3	EURO
1839	AS TIBIAS DE JOAO BRAGA	2022-11-22	3.75	2022-08-30	3	EURO
1840	MESA DA PRC BRAGA PR	2022-11-22	5.00	2022-08-30	3	EURO
1841	MESA DA PRC BRAGA PR	2022-11-22	5.00	2022-08-30	3	EURO
1842	Glovo 26AUG BRJUWKQPT Lisbon PR	2022-11-22	9.39	2022-08-30	3	EURO
1843	LA FIAMMA BRAGA PR	2022-11-22	5.50	2022-08-26	3	EURO
1844	AIRBNB HMJ9MYXQ2J  LU	2022-11-22	555.00	2022-08-26	3	EURO
1845	AS TIBIAS DE JOAO BRAGA	2022-11-22	3.84	2022-08-26	3	EURO
1846	AS TIBIAS DE JOAO BRAGA	2022-11-22	2.95	2022-08-26	3	EURO
1847	PAK SONAKEBAB BRAGA PR	2022-11-22	5.50	2022-08-26	3	EURO
1848	SINAL MAGICO BRAGA BRAG	2022-11-22	9.49	2022-08-26	3	EURO
1849	Glovo 24AUG BR1RHQCU5 Lisbon PR	2022-11-22	38.02	2022-08-26	3	EURO
1850	LA FIAMMA BRAGA PR	2022-11-22	5.50	2022-08-25	3	EURO
1851	Glovo 22AUG BRA6JELJ3 Lisbon PR	2022-11-22	20.21	2022-08-24	3	EURO
1852	LOJA DELTA Q PORT	2022-11-22	6.30	2022-08-23	3	EURO
1853	MACHADO ALMENDRA IRM PO	2022-11-22	1.80	2022-08-23	3	EURO
1854	GRUPO CELESTE GUIMARAES	2022-11-22	3.20	2022-08-23	3	EURO
1855	GARDEN PR	2022-11-22	9.90	2022-08-23	3	EURO
1856	GARDEN PR	2022-11-22	10.90	2022-08-23	3	EURO
1857	METRO DA TRINDADE	2022-11-22	8.30	2022-08-23	3	EURO
1858	MACHADO ALMENDRA IRM PO	2022-11-22	2.30	2022-08-23	3	EURO
1859	GARDEN PR	2022-11-22	9.90	2022-08-23	3	EURO
1860	METRO DA TRINDADE	2022-11-22	8.70	2022-08-22	3	EURO
1861	GRUPO CELESTE GUIMARAES	2022-11-22	6.70	2022-08-22	3	EURO
1862	PAK DONER KEBAB 470020	2022-11-22	6.70	2022-08-22	3	EURO
1863	CP SAO BENTO	2022-11-22	3.75	2022-08-22	3	EURO
1864	PEDRO DOS FRANGOS	2022-11-22	11.50	2022-08-19	3	EURO
1865	MINIPRECO PR	2022-11-22	5.43	2022-08-19	3	EURO
1866	Confeitaria Do Bolhao P	2022-11-22	2.70	2022-08-19	3	EURO
1867	KEBABONLINE PT 2625167 P STA IRIA	2022-11-22	6.09	2022-08-19	3	EURO
1868	LAVORATTA N 280 1 POR	2022-11-22	4.00	2022-08-18	3	EURO
1869	CONF BELLA ROMA P	2022-11-22	7.80	2022-08-18	3	EURO
1870	Confeitaria Do Bolhao P	2022-11-22	3.10	2022-08-18	3	EURO
1871	PEDRO DOS FRANGOS	2022-11-22	9.40	2022-08-17	3	EURO
1872	CONFEITARIA BOLHAO PORT	2022-11-22	3.10	2022-08-17	3	EURO
1873	PADARIA CONFEITARIA 4000218	2022-11-22	3.50	2022-08-16	3	EURO
1874	LOS TAQUITOS PR	2022-11-22	8.95	2022-08-16	3	EURO
1875	HUSSEL VIA CATARINA POR	2022-11-22	6.01	2022-08-16	3	EURO
1876	CONTINENTE BOM DIA PORT	2022-11-22	7.79	2022-08-16	3	EURO
1877	ESPACO 77 PR	2022-11-22	3.50	2022-08-16	3	EURO
1878	ESPACO 77 PR	2022-11-22	3.60	2022-08-16	3	EURO
1879	NICOLAU PR	2022-11-22	12.00	2022-08-16	3	EURO
1880	CACAU	2022-11-22	4.30	2022-08-15	3	EURO
1881	NICOLAU 4050214	2022-11-22	15.50	2022-08-15	3	EURO
1882	CONFEITARIA ALIANCA 4050178	2022-11-22	3.05	2022-08-15	3	EURO
1883	MINIPRECO PR	2022-11-22	9.44	2022-08-12	3	EURO
1884	Oliveira?S Restaurante	2022-11-22	14.00	2022-08-12	3	EURO
1885	CONFEITARIA ALIANCA 4050178	2022-11-22	2.20	2022-08-12	3	EURO
1886	CONFEITARIA ALIANCA 4050178	2022-11-22	3.05	2022-08-12	3	EURO
1887	AIRBNB HMHQHPKF4A 1308803888 LU	2022-11-22	848.75	2022-08-12	3	EURO
1888	NICOLAU PR	2022-11-22	14.00	2022-08-11	3	EURO
1889	Oliveira?S Restaurante	2022-11-22	6.90	2022-08-11	3	EURO
1890	LEV ATM 6251 EWPT2365	2022-11-22	100.00	2022-08-11	3	EURO
1891	CONFEITARIA ALIANCA 4050178	2022-11-22	3.20	2022-08-10	3	EURO
1892	JORGE SILVA SAPATOS POR	2022-11-22	15.95	2022-08-10	3	EURO
1893	MINIPRECO PR	2022-11-22	19.70	2022-08-09	3	EURO
1894	TAKEAWAY S. VICENTE BRA	2022-11-22	5.60	2022-08-09	3	EURO
1895	M MIRANDA E MENDES NIPC	2022-11-22	8.00	2022-08-08	3	EURO
1896	REDM BILHETEIRA BRAGA	2022-11-22	6.00	2022-08-08	3	EURO
1897	REST D. AUGUSTO SAO VIC	2022-11-22	26.90	2022-08-08	3	EURO
1898	HAMBURGUERIA DEGEMA 470	2022-11-22	8.95	2022-08-08	3	EURO
1899	IMPOSTO DE SELO 17.3.4	2022-11-22	0.21	2022-08-05	3	EURO
1900	COM. MANUTENCAO CONTA ORDENADO 072022	2022-11-22	5.20	2022-08-05	3	EURO
1901	TAKEAWAY S. VICENTE BRA	2022-11-22	6.10	2022-08-05	3	EURO
1902	Comissao Emissao s/ Ordem Pag.  Ref.20221539673	2022-11-22	1.10	2022-08-22	3	EURO
1903	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20221539673	2022-11-22	0.04	2022-08-22	3	EURO
1904	Salario	2022-11-22	3900.81	2022-08-31	3	EURO
1905	Cobrir Conta	\N	200.00	2022-08-22	3	EURO
1906	Salario	2022-11-22	3800.00	2022-09-30	3	EURO
1907	Glovo 29SEP BRN2ACFH4 Lisbon PR	2022-11-22	36.78	2022-09-30	3	EURO
1908	LA PORTA REST BRAGA	2022-11-22	22.00	2022-09-30	3	EURO
1909	Glovo 27SEP BRX1FKV72 Lisbon PR	2022-11-22	8.43	2022-09-29	3	EURO
1910	Glovo 27SEP BRFCNH31X Lisbon PR	2022-11-22	9.15	2022-09-29	3	EURO
1911	LA PORTA REST BRAGA	2022-11-22	22.00	2022-09-28	3	EURO
1912	Glovo 24SEP BRQLJRVFL Lisbon PR	2022-11-22	23.87	2022-09-27	3	EURO
1913	Glovo 23SEP BR21NDVBQ Lisbon PR	2022-11-22	10.49	2022-09-27	3	EURO
1914	LA PORTA REST BRAGA	2022-11-22	23.00	2022-09-26	3	EURO
1915	VANILLADEVOTION BRAGA	2022-11-22	23.00	2022-09-26	3	EURO
1916	IKEA BRAGA LINHA DE CA BRAGA PR	2022-11-22	530.00	2022-09-22	3	EURO
1917	CONTINENTE BRAGA BRAGA	2022-11-22	74.65	2022-09-21	3	EURO
1918	BK BRAGA ARCADA BRAGA	2022-11-22	1.65	2022-09-20	3	EURO
1919	BK BRAGA ARCADA BRAGA	2022-11-22	9.99	2022-09-20	3	EURO
1920	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	60.75	2022-09-20	3	EURO
1921	MARTINS E MARTINS LD BR	2022-11-22	50.00	2022-09-20	3	EURO
1922	Glovo 17SEP BRSXDLWRA Lisbon PR	2022-11-22	26.04	2022-09-20	3	EURO
1923	LA PORTA REST BRAGA	2022-11-22	23.00	2022-09-19	3	EURO
1924	LA PORTA REST BRAGA	2022-11-22	20.00	2022-09-19	3	EURO
1925	CONTINENTE BRAGA BRAGA	2022-11-22	2.49	2022-09-19	3	EURO
1926	CONTINENTE BRAGA BRAGA	2022-11-22	32.28	2022-09-19	3	EURO
1927	LA PORTA REST BRAGA	2022-11-22	26.00	2022-09-19	3	EURO
1928	LEV ATM 6251 BESCL Maximinos     R. Caires,21M	2022-11-22	100.00	2022-09-19	3	EURO
1929	VANILLADEVOTION BRAGA P	2022-11-22	26.00	2022-09-16	3	EURO
1930	LA PORTA BRAGA	2022-11-22	28.00	2022-09-16	3	EURO
1931	QUNJIE ZHOU 4700206 BRAGA	2022-11-22	18.60	2022-09-16	3	EURO
1932	VANILLADEVOTION BRAGA P	2022-11-22	32.00	2022-09-16	3	EURO
1933	Glovo 14SEP BRBVWWS1R Lisbon PR	2022-11-22	13.90	2022-09-16	3	EURO
1934	Glovo 14SEP BRG1RXAK5 Lisbon PR	2022-11-22	24.57	2022-09-16	3	EURO
1935	VANILLADEVOTION BRAGA	2022-11-22	20.00	2022-09-14	3	EURO
1936	AGERE LOJA DO 4700997 BRAGA	2022-11-22	5.28	2022-09-13	3	EURO
1937	MUNDO DO CAFE BRAGA PR	2022-11-22	1.10	2022-09-13	3	EURO
1938	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	80.00	2022-09-13	3	EURO
1939	Vodafone.pt Lisboa PR	2022-11-22	7.50	2022-09-13	3	EURO
1940	LEV ATM 6251 ENPT3164 BRAGA	2022-11-22	100.00	2022-09-13	3	EURO
1941	MARIA AMALIA BATISTAMAX	2022-11-22	12.67	2022-09-12	3	EURO
1942	LA PORTA BRAGA	2022-11-22	23.00	2022-09-12	3	EURO
1943	VANILLADEVOTION BRAGA P	2022-11-22	17.00	2022-09-12	3	EURO
1944	LA PORTA BRAGA	2022-11-22	26.00	2022-09-12	3	EURO
1945	TENTACOES DO NORTE, DUM	2022-11-22	11.55	2022-09-12	3	EURO
1946	IMPOSTO DE SELO 17.3.4	2022-11-22	0.21	2022-09-09	3	EURO
1947	COM. MANUTENCAO CONTA ORDENADO 082022	2022-11-22	5.20	2022-09-09	3	EURO
1948	ATIPICO BRANDAO N142	2022-11-22	15.30	2022-09-09	3	EURO
1949	FELIX TABERNA SE BRAGA	2022-11-22	22.00	2022-09-09	3	EURO
1950	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	370.77	2022-09-09	3	EURO
1951	DONNA PIZZA BRAGA	2022-11-22	8.50	2022-09-08	3	EURO
1952	AS TIBIAS DE JOAO BRAGA	2022-11-22	2.95	2022-09-08	3	EURO
1953	STAPLES LJ 3 BRAGA PR	2022-11-22	89.00	2022-09-08	3	EURO
1954	MEDIA MARKT BRAGA BRAGA	2022-11-22	39.98	2022-09-08	3	EURO
1955	FELIX TABERNA BRAGA PR	2022-11-22	30.00	2022-09-08	3	EURO
1956	LA PORTA BRAGA	2022-11-22	28.00	2022-09-07	3	EURO
1957	AS TIBIAS DE JOAO BRAGA	2022-11-22	2.95	2022-09-07	3	EURO
1958	LEROY MERLIN BRAGA BRAG	2022-11-22	4.68	2022-09-07	3	EURO
1959	Comissao Emissao s/ Ordem Pag.  Ref.20221652474	2022-11-22	1.10	2022-09-06	3	EURO
1960	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20221652474	2022-11-22	0.04	2022-09-06	3	EURO
1961	VANILLADEVOTION BRAGA	2022-11-22	16.00	2022-09-06	3	EURO
1962	FNAC BRAGA 4710427 BRAGA	2022-11-22	180.14	2022-09-06	3	EURO
1963	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	618.00	2022-09-06	3	EURO
1964	PAST BRAGAPARQUE BRAGA	2022-11-22	3.25	2022-09-06	3	EURO
1965	CAMILA PACHECO BRAGA PR	2022-11-22	10.50	2022-09-06	3	EURO
1966	WOK TO WALK N ARCADA BR	2022-11-22	13.25	2022-09-06	3	EURO
1967	SumUp Queijo Coalho Rui	2022-11-22	8.00	2022-09-06	3	EURO
1968	PAST BRAGAPARQUE BRAGA	2022-11-22	3.25	2022-09-06	3	EURO
1969	SUBLIMATUM LOPES BRAGA	2022-11-22	5.00	2022-09-06	3	EURO
1970	IMP.  SELO  COM. TRANSFERENCIA	2022-11-22	0.04	2022-09-06	3	EURO
1971	COMISSAO DE TRANSFERENCIA	2022-11-22	1.10	2022-09-06	3	EURO
1972	LA PORTA BRAGA	2022-11-22	16.10	2022-09-05	3	EURO
1973	DONNA PIZZA BRAGA	2022-11-22	8.50	2022-09-05	3	EURO
1974	LEV ATM 6251 703	2022-11-22	100.00	2022-09-05	3	EURO
1975	DEBATES E CRONICAS LBRAGA	2022-11-22	8.85	2022-09-05	3	EURO
1976	WORTEN BRAGA NOVA BRAGA	2022-11-22	742.48	2022-09-05	3	EURO
1977	TOMATINO NOVA ARCADABRA	2022-11-22	8.15	2022-09-05	3	EURO
1978	TRF P/ Lucinda dona da casa	2022-11-22	9100.00	2022-09-05	3	EURO
1979	DIVINA COIXINHA BRAGA	2022-11-22	3.00	2022-09-05	3	EURO
1980	PAST BRAGAPARQUE S VICENTE BRAGA	2022-11-22	4.25	2022-09-02	3	EURO
1981	RETIRO DE PRIMAVERA BRAGA	2022-11-22	6.60	2022-09-02	3	EURO
1982	GOSTO SUPERIOR BRAGA PR	2022-11-22	6.30	2022-09-02	3	EURO
1983	Glovo 31AUG BRRQNGEFW Lisbon PR	2022-11-22	17.70	2022-09-02	3	EURO
1984	AIRBNB HMBJYNCZH4 LU	2022-11-22	535.15	2022-09-02	3	EURO
1985	SUPER SABORES PARADA DE TIBAES	2022-11-22	7.80	2022-09-01	3	EURO
1986	PAST BRAGAPARQUE BRAGA	2022-11-22	1.70	2022-09-01	3	EURO
1987	TAKEAWAY S VICENTE BRAG	2022-11-22	5.60	2022-09-01	3	EURO
1988	Cobrir Conta	\N	1000.00	2022-09-06	3	EURO
1989	Salario	2022-11-22	3800.00	2022-10-31	3	EURO
1990	EDP COMERCIALCOMERCIA	2022-11-22	29.56	2022-10-31	3	EURO
1991	Glovo 27OCT BRQ11FF5M Lisbon PR	2022-11-22	9.03	2022-10-28	3	EURO
1992	Glovo 26OCT BRW5FRRTP Lisbon PR	2022-11-22	8.77	2022-10-28	3	EURO
1993	Glovo 25OCT BRD9LZAXW Lisbon PR	2022-11-22	30.64	2022-10-26	3	EURO
1994	NOS CINEMAS BRAGA PQ BR CONTACTLESS	2022-11-22	6.75	2022-10-26	3	EURO
1995	PINGO DOCE BRAGA BRAGA	2022-11-22	18.55	2022-10-26	3	EURO
1996	LA PORTA REST BRAGA	2022-11-22	24.00	2022-10-25	3	EURO
1997	PRIMARK BRAGE PARQUE B CONTACTLESS	2022-11-22	14.60	2022-10-25	3	EURO
1998	FNAC BRAGA BRAGA PR	2022-11-22	19.90	2022-10-25	3	EURO
1999	Glovo 22OCT BRCXEBS3Y Lisbon PR	2022-11-22	8.89	2022-10-25	3	EURO
2000	Glovo 21OCT BR4WAUKQP Lisbon PR	2022-11-22	9.67	2022-10-25	3	EURO
2001	Glovo 21OCT BRYSKJX19 Lisbon PR	2022-11-22	9.03	2022-10-25	3	EURO
2002	Vodafone.pt Lisboa PR	2022-11-22	15.00	2022-10-25	3	EURO
2003	BODEGAO BRAGA 4710427	2022-11-22	12.80	2022-10-24	3	EURO
2004	BODEGAO BRAGA 4710427	2022-11-22	12.30	2022-10-24	3	EURO
2005	UBR PENDING.UBER.COM AMSTERDAM NL	2022-11-22	3.00	2022-10-21	3	EURO
2006	AGEREEMP.DE AGUAS,EFL	2022-11-22	21.09	2022-10-21	3	EURO
2007	Glovo 19OCT BRGM74Q2V Lisbon PR	2022-11-22	10.88	2022-10-21	3	EURO
2008	Glovo 19OCT BR1EFCTFP Lisbon PR	2022-11-22	34.97	2022-10-21	3	EURO
2009	LA PORTA REST BRAGA	2022-11-22	24.00	2022-10-20	3	EURO
2010	Glovo 18OCT BREGXZASH Lisbon PR	2022-11-22	15.04	2022-10-19	3	EURO
2011	Glovo 18OCT BRFPQ1J4L Lisbon PR	2022-11-22	11.04	2022-10-19	3	EURO
2012	Glovo 17OCT BRNFSYRKY Lisbon PR	2022-11-22	9.64	2022-10-19	3	EURO
2013	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	12.90	2022-10-19	3	EURO
2014	HOSPITAL DE BRAGA, EPE	2022-11-22	112.07	2022-10-18	3	EURO
2015	Glovo 13OCT BRLG4G1KF Lisbon PR	2022-11-22	29.12	2022-10-17	3	EURO
2016	LA PORTA REST BRAGA	2022-11-22	21.00	2022-10-17	3	EURO
2017	LA ROTISSERIE BRAGA	2022-11-22	9.40	2022-10-17	3	EURO
2018	MARIA AMALIA BATISTAMAXIMINOS	2022-11-22	12.20	2022-10-17	3	EURO
2019	Glovo 12OCT BR7ZJJVZR Lisbon PR	2022-11-22	11.80	2022-10-14	3	EURO
2020	Vodafone.pt Lisboa PR	2022-11-22	15.00	2022-10-13	3	EURO
2021	VODAFONE PORTUGAL COMU	2022-11-22	3.61	2022-10-12	3	EURO
2022	Glovo 10OCT BRT12F7DF Lisbon PR	2022-11-22	9.03	2022-10-12	3	EURO
2023	LA PORTA REST BRAGA	2022-11-22	23.00	2022-10-11	3	EURO
2024	Glovo 08OCT BR1AU9P33 Lisbon PR	2022-11-22	29.98	2022-10-11	3	EURO
2025	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	27.00	2022-10-11	3	EURO
2026	WOK TO WALK N ARCADANIF CONTACTLESS	2022-11-22	12.80	2022-10-10	3	EURO
2027	LA PORTA REST BRAGA	2022-11-22	24.00	2022-10-10	3	EURO
2028	Glovo 06OCT BRGVKKZMB Lisbon PR	2022-11-22	9.15	2022-10-07	3	EURO
2029	IMPOSTO DE SELO 17.3.4	2022-11-22	0.21	2022-10-10	3	EURO
2030	COM. MANUTENCAO CONTA ORDENADO 092022	2022-11-22	5.20	2022-10-10	3	EURO
2031	BK BRAGA ARCADA BRAGA	2022-11-22	9.99	2022-10-07	3	EURO
2032	ALGODAO E COMPANHIA 4700565 MIRE T	2022-11-22	38.25	2022-10-06	3	EURO
2033	Vodafone.pt Lisboa PR	2022-11-22	7.50	2022-10-05	3	EURO
2034	IKEA BRAGA LINHA DE CA BRAGA PR	2022-11-22	338.00	2022-10-05	3	EURO
2035	Glovo 03OCT BRMN3N115 Lisbon PR	2022-11-22	2.69	2022-10-05	3	EURO
2036	Glovo 02OCT BRT3LGEEC Lisbon PR	2022-11-22	17.49	2022-10-05	3	EURO
2037	TENTACOES DO NORTE, BRAGA	2022-11-22	11.55	2022-10-04	3	EURO
2038	Glovo 01OCT BRXWXLDCN Lisbon	2022-11-22	7.26	2022-10-04	3	EURO
2039	Glovo 30SEP BRP6GY1GB Lisbon	2022-11-22	9.15	2022-10-04	3	EURO
2040	Comissao Emissao s/ Ordem Pag.  Ref.20221852243	2022-11-22	1.10	2022-10-03	3	EURO
2041	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20221852243	2022-11-22	0.04	2022-10-03	3	EURO
2042	CONTINENTE BRAGA BRAGA	2022-11-22	23.23	2022-10-03	3	EURO
2043	BK BRAGA ARCADA BRAGA	2022-11-22	7.99	2022-10-03	3	EURO
2044	Cobrir Conta	\N	2000.00	2022-10-03	3	EURO
2045	Glovo 20NOV BRPUQNKVC	2022-11-22	14.56	2022-11-22	3	EURO
2046	CONTINENTE	2022-11-22	62.67	2022-11-22	3	EURO
2047	Glovo 19NOV BRCXBEVVM	2022-11-22	14.55	2022-11-22	3	EURO
2048	Glovo 18NOV BRP9T3GGT	2022-11-22	17.08	2022-11-22	3	EURO
2049	Glovo 18NOV BRNLDZWWS	2022-11-22	9.03	2022-11-22	3	EURO
2050	Glovo 17NOV BR6LBTJLK	2022-11-22	10.54	2022-11-22	3	EURO
2051	Glovo 17NOV BRXY5MLU1	2022-11-22	12.04	2022-11-22	3	EURO
2052	LA ROTISSERIE	2022-11-22	9.40	2022-11-21	3	EURO
2053	Glovo 16NOV BRHCY1WLG	2022-11-22	10.76	2022-11-18	3	EURO
2054	Glovo 16NOV BR1BURQXU	2022-11-22	10.69	2022-11-18	3	EURO
2055	Glovo 15NOV BR1E1FAKU	2022-11-22	10.93	2022-11-17	3	EURO
2056	Glovo 14NOV BRLGKN1S1	2022-11-22	31.90	2022-11-16	3	EURO
2057	Glovo 14NOV BR1CVNCUM	2022-11-22	9.03	2022-11-16	3	EURO
2058	Glovo 13NOV BRNXN14AU	2022-11-22	14.95	2022-11-15	3	EURO
2059	Glovo 12NOV BRS1MD1FL	2022-11-22	10.69	2022-11-15	3	EURO
2060	Glovo 11NOV BRSSEEV3N	2022-11-22	8.77	2022-11-15	3	EURO
2061	Glovo 11NOV BRN1GBBV1	2022-11-22	28.52	2022-11-15	3	EURO
2062	Glovo 11NOV BRBGVJZDD	2022-11-22	9.64	2022-11-15	3	EURO
2063	LEROY MERLIN	2022-11-22	364.98	2022-11-14	3	EURO
2064	Glovo 10NOV BRXFQ7C3A	2022-11-22	9.53	2022-11-11	3	EURO
2065	Glovo 10NOV BRNHLRFH5	2022-11-22	10.03	2022-11-11	3	EURO
2066	IMPOSTO DE SELO 17.3.4	2022-11-22	0.21	2022-11-14	3	EURO
2067	COM. MANUTENCAO CONTA ORDENADO 102022	2022-11-22	5.20	2022-11-14	3	EURO
2068	Glovo 09NOV BRCS1ZXU4	2022-11-22	8.77	2022-11-11	3	EURO
2069	Glovo 09NOV BRTA4LMAM	2022-11-22	9.03	2022-11-11	3	EURO
2070	VODAFONE PORTUGAL COMU	2022-11-22	27.89	2022-11-10	3	EURO
2071	AGEREEMP.DE AGUAS,EFL	2022-11-22	17.31	2022-11-10	3	EURO
2072	EDP COMERCIALCOMERCIA	2022-11-22	34.41	2022-11-10	3	EURO
2073	Glovo 08NOV BRHWBYWCL	2022-11-22	9.51	2022-11-10	3	EURO
2074	Glovo 07NOV BRQDSTWV9	2022-11-22	21.20	2022-11-09	3	EURO
2075	Glovo 06NOV BRHBKFU1D	2022-11-22	12.68	2022-11-08	3	EURO
2076	FNAC PR	2022-11-22	70.13	2022-11-08	3	EURO
2077	BRASA RIO PR	2022-11-22	9.75	2022-11-08	3	EURO
2078	PINGO DOCE	2022-11-22	13.26	2022-11-08	3	EURO
2079	Glovo 04NOV BRGE1Z1GX	2022-11-22	8.77	2022-11-08	3	EURO
2080	LA PORTA REST	2022-11-22	27.00	2022-11-07	3	EURO
2081	Glovo 03NOV BR2N5TFZR	2022-11-22	35.79	2022-11-04	3	EURO
2082	Glovo 03NOV BRHULWPAT	2022-11-22	9.51	2022-11-04	3	EURO
2083	Glovo 02NOV BRKR7UWWL	2022-11-22	9.51	2022-11-04	3	EURO
2084	Glovo 01NOV BRNCM1FSZ	2022-11-22	8.77	2022-11-03	3	EURO
2085	Glovo 01NOV BRLPQHYHK	2022-11-22	9.03	2022-11-03	3	EURO
2086	Glovo 31OCT BRUYNBXWH	2022-11-22	9.03	2022-11-02	3	EURO
2087	Glovo 30OCT BR2WSRKR1	2022-11-22	12.68	2022-11-01	3	EURO
2088	HEBE GYROS	2022-11-22	9.80	2022-11-01	3	EURO
2089	CONTINENTE	2022-11-22	36.33	2022-11-01	3	EURO
2090	Glovo 28OCT BRGJJWZXE	2022-11-22	10.76	2022-11-01	3	EURO
2093	UBER TRIP	2022-11-22	3.00	2022-08-15	4	EURO
2094	AIRBNB  HM2SAEHYRC	2022-11-22	815.60	2022-08-04	4	EURO
2095	ALSA INTERNET	2022-11-22	10.00	2022-08-07	4	EURO
2096	AIRBNB  HMK5A8JCWA	2022-11-22	557.00	2022-08-11	4	EURO
2097	UBER TRIP	2022-11-22	3.24	2022-08-24	4	EURO
2098	UBER TRIP HELP.UBER.C	2022-11-22	3.00	2022-08-29	4	EURO
2099	UBER TRIP	2022-11-22	2.29	2022-09-03	4	EURO
2100	UBER TRIP HELP.UBER.C	2022-11-22	3.17	2022-09-03	4	EURO
2101	UBER TRIP	2022-11-22	2.66	2022-09-05	4	EURO
2102	Vodafone GmbH CallYa	2022-11-22	20.00	2022-09-10	4	EURO
2103	UBER TRIP HELP.UBER.C	2022-11-22	3.00	2022-09-13	4	EURO
2104	HOTEL IBIS BRAGA	2022-11-22	104.00	2022-09-13	4	EURO
2105	Avis RentACar	2022-11-22	592.55	2022-09-14	4	EURO
2106	UBER TRIP	2022-11-22	3.00	2022-09-14	4	EURO
2107	UBER TRIP	2022-11-22	3.00	2022-09-14	4	EURO
2108	UBER TRIP	2022-11-22	3.65	2022-09-15	4	EURO
2109	UBER TRIP	2022-11-22	3.00	2022-09-15	4	EURO
2110	UBER TRIP HELP.UBER.C	2022-11-22	9.22	2022-09-19	4	EURO
2111	UBER TRIP	2022-11-22	3.00	2022-09-19	4	EURO
2112	UBER TRIP	2022-11-22	3.00	2022-09-21	4	EURO
2113	UBER TRIP HELP.UBER.C	2022-11-22	5.92	2022-09-22	4	EURO
2114	UBER TRIP	2022-11-22	6.33	2022-09-22	4	EURO
2115	UBER TRIP	2022-11-22	5.89	2022-09-22	4	EURO
2116	UBER TRIP	2022-11-22	6.57	2022-09-22	4	EURO
2117	UBER TRIP	2022-11-22	3.00	2022-09-28	4	EURO
2118	UBER TRIP	2022-11-22	4.80	2022-09-28	4	EURO
2119	UBER TRIP	2022-11-22	3.00	2022-09-29	4	EURO
2120	UBER TRIP	2022-11-22	3.00	2022-09-30	4	EURO
2121	UBER TRIP	2022-11-22	3.00	2022-09-30	4	EURO
2123	CONTINENTE BRAGA	2022-11-22	19.20	2022-10-02	4	EURO
2124	UBER TRIP	2022-11-22	5.86	2022-10-03	4	EURO
2125	UBER TRIP	2022-11-22	6.37	2022-10-03	4	EURO
2126	UBER TRIP	2022-11-22	6.54	2022-10-04	4	EURO
2127	UBER TRIP	2022-11-22	5.87	2022-10-05	4	EURO
2128	TAP0470004147631	2022-11-22	2082.63	2022-10-05	4	EURO
2129	UBER TRIP	2022-11-22	4.75	2022-10-06	4	EURO
2130	UBER TRIP	2022-11-22	5.50	2022-10-07	4	EURO
2131	UBER TRIP	2022-11-22	6.76	2022-10-10	4	EURO
2132	UBER TRIP	2022-11-22	3.00	2022-10-10	4	EURO
2133	UBER TRIP	2022-11-22	5.92	2022-10-10	4	EURO
2134	UBER TRIP	2022-11-22	5.76	2022-10-11	4	EURO
2135	UBER TRIP	2022-11-22	6.45	2022-10-11	4	EURO
2136	UBER TRIP	2022-11-22	3.00	2022-10-13	4	EURO
2137	UBER TRIP	2022-11-22	3.00	2022-10-15	4	EURO
2091	Salario	\N	5794.00	2022-11-30	3	EURO
2138	UBER TRIP	2022-11-22	6.36	2022-10-17	4	EURO
2139	UBER TRIP	2022-11-22	5.89	2022-10-17	4	EURO
2140	UBER TRIP	2022-11-22	3.00	2022-10-18	4	EURO
2141	UBER TRIP	2022-11-22	4.47	2022-10-24	4	EURO
2142	UBER TRIP	2022-11-22	3.80	2022-10-24	4	EURO
2143	UBER TRIP	2022-11-22	3.92	2022-10-24	4	EURO
2144	UBER TRIP	2022-11-22	4.43	2022-10-25	4	EURO
2145	UBER TRIP	2022-11-22	3.00	2022-10-27	4	EURO
2146	UBER TRIP	2022-11-22	5.90	2022-10-31	4	EURO
2147	UBER TRIP	2022-11-22	11.84	2022-10-31	4	EURO
2148	UBER TRIP	2022-11-22	4.48	2022-11-07	4	EURO
2149	UBER TRIP	2022-11-22	3.92	2022-11-07	4	EURO
2150	UBER TRIP	2022-11-22	3.00	2022-11-08	4	EURO
2151	UBER TRIP	2022-11-22	3.00	2022-11-09	4	EURO
2152	UBER TRIP	2022-11-22	4.70	2022-11-14	4	EURO
2153	UBER TRIP	2022-11-22	4.57	2022-11-14	4	EURO
2154	UBER TRIP HELP.UBER.C	2022-11-22	6.25	2022-11-20	4	EURO
2155	UBER TRIP	2022-11-22	6.95	2022-11-21	4	EURO
2156	EBANX *SPOTIFY	2022-11-23	19.90	2022-06-28	6	REAL
2157	ANUIDADE DIFERENCIADA 09/12	2022-11-23	26.00	2022-06-29	6	REAL
2158	Amazon.com.br Digital	2022-11-23	19.90	2022-07-03	6	REAL
2159	AmazonPrimeBR	2022-11-23	14.90	2022-07-03	6	REAL
2160	DM*HELPHBOMAXCOM	2022-11-23	27.90	2022-07-04	6	REAL
2161	Disney Plus	2022-11-23	27.90	2022-07-06	6	REAL
2162	NETFLIX.COM	2022-11-23	39.90	2022-07-11	6	REAL
2163	APPLE.COM/BILL	2022-11-23	9.90	2022-07-20	6	REAL
2164	Google Niantic Inc	2022-11-23	1.90	2022-07-23	6	REAL
2165	Google Niantic Inc	2022-11-23	1.90	2022-07-27	6	REAL
2167	EBW *SPOTIFY	2022-11-23	19.90	2022-07-28	6	REAL
2168	IOF TRANSACOES INTERNACIONAIS	2022-11-23	1.13	2022-08-01	6	REAL
2169	STEAM PURCHASE SEATTLE DE	2022-11-23	17.85	2022-07-07	6	REAL
2166	Google Niantic Inc 1	2022-11-23	1.90	2022-07-27	6	REAL
2171	ANUIDADE DIFERENCIADA 10/12	2022-11-23	26.00	2022-08-02	6	REAL
2172	AmazonPrimeBR	2022-11-23	14.90	2022-08-03	6	REAL
2173	Amazon.com.br Digital	2022-11-23	19.90	2022-08-03	6	REAL
2174	DM*HELPHBOMAXCOM	2022-11-23	27.90	2022-08-04	6	REAL
2175	Disney Plus	2022-11-23	27.90	2022-08-06	6	REAL
2176	NETFLIX.COM	2022-11-23	39.90	2022-08-11	6	REAL
2177	APPLE.COM/BILL	2022-11-23	9.90	2022-08-20	6	REAL
2178	EBW*SPOTIFY	2022-11-23	19.90	2022-08-28	6	REAL
2179	ANUIDADE DIFERENCIADA 11/12	2022-11-23	26.00	2022-09-02	6	REAL
2180	AmazonPrimeBR	2022-11-23	14.90	2022-09-03	6	REAL
2181	Amazon.com.br Digital	2022-11-23	19.90	2022-09-03	6	REAL
2182	DM*HELPHBOMAXCOM	2022-11-23	27.90	2022-09-04	6	REAL
2183	Amazon.com.br	2022-11-23	88.10	2022-09-05	6	REAL
2184	Disney Plus	2022-11-23	27.90	2022-09-06	6	REAL
2185	Amazon.com.br	2022-11-23	109.90	2022-09-06	6	REAL
2186	NETFLIX.COM	2022-11-23	39.90	2022-09-11	6	REAL
2187	APPLE.COM/BILL	2022-11-23	9.90	2022-09-20	6	REAL
2188	EBW *SPOTIFY	2022-11-23	19.90	2022-09-26	6	REAL
2189	JUROS DE MORA	2022-11-23	0.12	2022-09-26	6	REAL
2190	IOF TRANSACOES INTERNACIONAIS	2022-11-23	3.29	2022-09-26	6	REAL
2191	STEAMGAMES.COM 4259522 Hamburg DE	2022-11-23	51.60	2022-09-15	6	REAL
2192	Encargos	2022-11-23	2.12	2022-09-15	6	REAL
2193	Amazon.com.br Digital.	2022-11-23	19.90	2022-10-03	6	REAL
2194	AmazonPrimeBR.	2022-11-23	14.90	2022-10-03	6	REAL
2195	DM*HELPHBOMAXCOM.	2022-11-23	27.90	2022-10-04	6	REAL
2196	Disney Plus.	2022-11-23	27.90	2022-10-06	6	REAL
2197	NETFLIX.COM.	2022-11-23	39.90	2022-10-11	6	REAL
2198	APPLE.COM/BILL.	2022-11-23	14.90	2022-10-20	6	REAL
2199	EBW *SPOTIFY	2022-11-23	19.90	2022-10-27	6	REAL
2200	IOF TRANSACOES INTERNACIONAIS	2022-11-23	1.78	2022-10-27	6	REAL
2201	STEAMGAMES.COM 4259522 Hamburg DE	2022-11-23	27.99	2022-10-14	6	REAL
2202	TAR PACOTE ITAU   JUN/22	2022-11-23	71.90	2022-07-04	5	REAL
2203	INT TED 237199200267929	2022-11-23	1100.00	2022-07-08	5	REAL
2204	DA  COMGAS 48353698	2022-11-23	9.72	2022-07-14	5	REAL
2205	DA  VIVO FIXO 9324810660	2022-11-23	145.99	2022-07-15	5	REAL
2206	DA  ELETROPAULO 56301179	2022-11-23	20.39	2022-07-29	5	REAL
2207	TAR PACOTE ITAU   JUL/22	2022-11-23	71.90	2022-08-02	5	REAL
2208	INT PAG TIT 109005381830	2022-11-23	664.00	2022-08-11	5	REAL
2209	DA  COMGAS 48353698	2022-11-23	9.72	2022-08-15	5	REAL
2210	DA  VIVO FIXO 9324810660	2022-11-23	145.99	2022-08-15	5	REAL
2211	DA  ELETROPAULO 56301179	2022-11-23	21.57	2022-08-29	5	REAL
2212	TAR PACOTE ITAU   AGO/22	2022-11-23	71.90	2022-09-02	5	REAL
2213	INT TED  fe0dcecd	2022-11-23	1540.00	2022-09-05	5	REAL
2214	INT PAG TIT 109005386201	2022-11-23	664.00	2022-09-13	5	REAL
2215	DA  COMGAS 48353698	2022-11-23	9.72	2022-09-15	5	REAL
2216	DA  VIVO FIXO 9324810660	2022-11-23	145.99	2022-09-15	5	REAL
2217	DA  ELETROPAULO 56301179	2022-11-23	21.85	2022-09-29	5	REAL
2218	TAR PACOTE ITAU   SET/22	2022-11-23	71.90	2022-10-04	5	REAL
2219	INT PAG TIT 109005395830	2022-11-23	664.00	2022-10-11	5	REAL
2220	DA  COMGAS 48353698	2022-11-23	9.72	2022-10-17	5	REAL
2221	DA  VIVO FIXO 9324810660	2022-11-23	139.16	2022-10-17	5	REAL
2222	DA  ELETROPAULO 56301179	2022-11-23	21.79	2022-10-31	5	REAL
2223	INT TED  17ac1d79	2022-11-23	660.00	2022-11-01	5	REAL
2224	TAR PACOTE ITAU   OUT/22	2022-11-23	71.90	2022-11-03	5	REAL
2225	INT PAG TIT 109005402073	2022-11-23	664.00	2022-11-10	5	REAL
2226	INT PM S CAETANO  748609	2022-11-23	8700.00	2022-11-16	5	REAL
2227	DA  COMGAS 48353698	2022-11-23	9.72	2022-11-16	5	REAL
2228	DA  VIVO FIXO 9324810660	2022-11-23	139.16	2022-11-16	5	REAL
2229	Pagamento fatura 08/2022	2022-08-11	230.88	2022-11-23	5	REAL
2230	Pagamento fatura 09/2022	2022-09-13	186.30	2022-11-23	5	REAL
2231	Pagamento fatura 10/2022	2022-10-11	441.43	2022-11-23	5	REAL
2232	Pagamento fatura 11/2022	2022-11-10	195.07	2022-11-23	5	REAL
2233	Valor Eliana	2023-03-24	590.00	2022-11-30	5	REAL
2234	Eletropaulo	2023-03-24	21.70	2022-11-30	5	REAL
2235	TAR PACOTE ITAU   NOV/22	2023-03-24	71.90	2022-12-02	5	REAL
2236	BENHUR PRO	2023-03-24	33.10	2022-12-05	5	REAL
2237	BENHUR PRO	2023-03-24	17.20	2022-12-05	5	REAL
2238	CARREFOUR S	2023-03-24	234.21	2022-12-05	5	REAL
2239	CEA SCS 197	2023-03-24	10.00	2022-12-05	5	REAL
2240	ITALVA PAES	2023-03-24	29.35	2022-12-05	5	REAL
2241	MULTIPLAN A	2023-03-24	13.00	2022-12-03	5	REAL
2242	PAG*Guaruco	2023-03-24	215.14	2022-12-05	5	REAL
2243	XANGAI COM	2023-03-24	59.50	2022-12-05	5	REAL
2244	ON    ifood	2023-03-24	19.98	2022-12-05	5	REAL
2245	ON    ifood	2023-03-24	31.00	2022-12-05	5	REAL
2246	ITALVA PAES	2023-03-24	4.00	2022-12-06	5	REAL
2247	RAIA 280	2023-03-24	119.80	2022-12-07	5	REAL
2248	CDB  CENTR	2023-03-24	240.00	2022-12-08	5	REAL
2249	CENTER CARN	2023-03-24	43.40	2022-12-08	5	REAL
2250	MAC PARK PA	2023-03-24	18.00	2022-12-08	5	REAL
2251	PG *TON CON	2023-03-24	350.00	2022-12-08	5	REAL
2252	MULTIPLAN A	2023-03-24	13.00	2022-12-09	5	REAL
2253	PAG*Descamp	2023-03-24	29.00	2022-12-09	5	REAL
2254	PB ADMINIST	2023-03-24	11.00	2022-12-09	5	REAL
2255	INT PAG TIT 109005415505	2023-03-24	664.00	2022-12-12	5	REAL
2256	ANDIAMO	2023-03-24	150.00	2022-12-12	5	REAL
2257	CINEMARK MO	2023-03-24	56.00	2022-12-12	5	REAL
2258	GC CAFE MOO	2023-03-24	12.50	2022-12-12	5	REAL
2259	GC CAFE MOO	2023-03-24	13.90	2022-12-12	5	REAL
2260	MOOCA PLAZA	2023-03-24	22.00	2022-12-12	5	REAL
2261	MULTIPLAN A	2023-03-24	13.00	2022-12-12	5	REAL
2262	INT TED  09d46220	2023-03-24	32.00	2022-12-12	5	REAL
2263	PARK PLACE	2023-03-24	12.00	2022-12-13	5	REAL
2264	PAG*Descamp	2023-03-24	16.52	2022-12-14	5	REAL
2265	DA  COMGAS 48353698	2023-03-24	9.72	2022-12-14	5	REAL
2266	BR SOUVENIR	2023-03-24	42.99	2022-12-15	5	REAL
2267	DROGARIA SA	2023-03-24	21.80	2022-12-15	5	REAL
2268	EVOLUKIT	2023-03-24	366.83	2022-12-15	5	REAL
2269	PERNAMBUCAN	2023-03-24	89.97	2022-12-15	5	REAL
2270	DA  VIVO FIXO 9324810660	2023-03-24	139.16	2022-12-15	5	REAL
2271	B CATH CAR	2023-03-24	40.00	2022-12-19	5	REAL
2272	BOLOS ANCHI	2023-03-24	9.90	2022-12-19	5	REAL
2273	DEPYL ACTIO	2023-03-24	122.00	2022-12-19	5	REAL
2274	STARCHICKEN	2023-03-24	15.50	2022-12-19	5	REAL
2275	DOCES VO NE	2023-03-24	35.71	2022-12-20	5	REAL
2276	DINAMIC PAR	2023-03-24	21.00	2022-12-21	5	REAL
2277	MINA DE OUR	2023-03-24	14.90	2022-12-21	5	REAL
2278	PAG*Saborde	2023-03-24	10.30	2022-12-21	5	REAL
2279	PAG*Saborde	2023-03-24	20.00	2022-12-21	5	REAL
2280	SKIPARK EST	2023-03-24	18.00	2022-12-21	5	REAL
2281	IVETE TIYOK	2023-03-24	18.00	2022-12-22	5	REAL
2282	LANCHONETE	2023-03-24	18.50	2022-12-22	5	REAL
2283	SKIPARK EST	2023-03-24	10.00	2022-12-22	5	REAL
2284	BUENOS PARK	2023-03-24	50.00	2022-12-23	5	REAL
2285	PAG*Saborde	2023-03-24	6.00	2022-12-23	5	REAL
2286	CARREFOUR S	2023-03-24	278.85	2022-12-26	5	REAL
2287	LEROY MERLI	2023-03-24	29.98	2022-12-26	5	REAL
2288	SACOMA POIN	2023-03-24	16.60	2022-12-27	5	REAL
2289	MAGIC DOMAI	2023-03-24	199.99	2022-12-28	5	REAL
2290	DA  ELETROPAULO 56301179	2023-03-24	52.86	2022-12-29	5	REAL
2291	ITALVA PAES	2023-03-24	29.70	2022-12-30	5	REAL
2292	PARMEGIANO	2023-03-24	90.00	2022-12-30	5	REAL
2293	ANUIDADE DIFERENCIADA 12/12	2023-03-24	26.00	2022-11-02	6	REAL
2294	Amazon.com.br Digital	2023-03-24	19.90	2022-11-03	6	REAL
2295	AmazonPrimeBR	2023-03-24	14.90	2022-11-03	6	REAL
2296	DM *HELPHBOMAXCOM	2023-03-24	27.90	2022-11-04	6	REAL
2297	Disney Plus	2023-03-24	27.90	2022-11-06	6	REAL
2298	NETFLIX.COM	2023-03-24	39.90	2022-11-11	6	REAL
2299	APPLE.COM/BILL	2023-03-24	14.90	2022-11-20	6	REAL
2300	DM*Blizzard	2023-03-24	24.00	2022-11-26	6	REAL
2301	EBW *SPOTIFY	2023-03-24	19.90	2022-11-28	6	REAL
2302	IOF TRANSACOES INTERNACIONAIS	2023-03-24	1.52	2022-12-01	6	REAL
2303	STEAM PURCHASE SEATTLE DE	2023-03-24	23.85	2022-11-01	6	REAL
2304	Pagamento fatura 12/2022	2022-12-12	240.67	2023-03-24	5	REAL
2305	RSHOPAUTO POSTO 01/01	2023-03-24	50.00	2023-01-02	5	REAL
2306	RSHOPCARREFOUR S31/12	2023-03-24	84.76	2023-01-02	5	REAL
2307	RSHOPDROGASIL 1901/01	2023-03-24	15.90	2023-01-02	5	REAL
2308	RSHOPSACOMA POIN01/01	2023-03-24	10.65	2023-01-02	5	REAL
2309	PIX TRANSF  ELIANA 31/12	2023-03-24	14.00	2023-01-02	5	REAL
2310	TAR PACOTE ITAU   DEZ/22	2023-03-24	71.90	2023-01-03	5	REAL
2311	DA  COMGAS 48353698	2023-03-24	13.98	2023-01-16	5	REAL
2312	DA  VIVO FIXO 9324810660	2023-03-24	147.99	2023-01-16	5	REAL
2313	DA  ELETROPAULO 56301179	2023-03-24	96.61	2023-01-30	5	REAL
2314	TAR PACOTE ITAU   JAN/23	2023-03-24	71.90	2023-02-02	5	REAL
2315	INT PAG TIT 109005421578	2023-03-24	664.00	2023-02-08	5	REAL
2316	DA  COMGAS 48353698	2023-03-24	10.95	2023-02-14	5	REAL
2317	DA  VIVO FIXO 9324810660	2023-03-24	134.51	2023-02-15	5	REAL
2318	DA  ELETROPAULO 56301179	2023-03-24	21.96	2023-02-28	5	REAL
2319	INT TED  9e6da7ff	2023-03-24	660.00	2023-03-02	5	REAL
2320	TAR PACOTE ITAU   FEV/23	2023-03-24	71.90	2023-03-02	5	REAL
2321	INT PAG TIT 109005428615	2023-03-24	664.00	2023-03-07	5	REAL
2322	DA  COMGAS 48353698	2023-03-24	10.92	2023-03-15	5	REAL
2323	DA  VIVO FIXO 9324810660	2023-03-24	147.99	2023-03-15	5	REAL
2324	DA  ELETROPAULO 56301179	2023-03-24	21.96	2023-03-29	5	REAL
2325	ANUIDADE DIFERENCIADA 01/12	2023-03-24	30.00	2022-12-02	6	REAL
2326	Amazon.com.br Digital	2023-03-24	19.90	2022-12-03	6	REAL
2327	AmazonPrimeBR	2023-03-24	14.90	2022-12-03	6	REAL
2328	Uber *UBER *TRIP	2023-03-24	5.00	2022-12-03	6	REAL
2329	SERVICOS CLA*119934511	2023-03-24	20.00	2022-12-03	6	REAL
2330	ifood *ifood	2023-03-24	23.49	2022-12-03	6	REAL
2331	LOCALIZA RAC ACCAE0	2023-03-24	4576.99	2022-12-03	6	REAL
2332	ifood *ifood	2023-03-24	36.99	2022-12-06	6	REAL
2333	ifood *ifood	2023-03-24	15.99	2022-12-07	6	REAL
2334	Uber *UBER *TRIP	2023-03-24	34.99	2022-12-07	6	REAL
2335	ifood *ifood	2023-03-24	67.38	2022-12-07	6	REAL
2336	Disney Plus	2023-03-24	27.90	2022-12-08	6	REAL
2337	DM *HELPHBOMAXCOM	2023-03-24	27.90	2022-12-08	6	REAL
2338	ifood *ifood	2023-03-24	27.98	2022-12-08	6	REAL
2339	ifood *ifood	2023-03-24	28.89	2022-12-09	6	REAL
2340	NETFLIX.COM	2023-03-24	39.90	2022-12-11	6	REAL
2341	SERVICOS CLA*119934511	2023-03-24	20.00	2022-12-11	6	REAL
2342	CARREFOUR PAN	2023-03-24	186.64	2022-12-11	6	REAL
2343	ifood *ifood	2023-03-24	61.49	2022-12-12	6	REAL
2344	ifood *ifood	2023-03-24	62.89	2022-12-12	6	REAL
2345	IFOOD *ifood	2023-03-24	152.20	2022-12-12	6	REAL
2346	ifood *ifood	2023-03-24	32.98	2022-12-14	6	REAL
2347	ifood *ifood	2023-03-24	32.98	2022-12-14	6	REAL
2348	ifood *ifood	2023-03-24	31.98	2022-12-15	6	REAL
2349	MFB COMERCIO DE PRO 01/03	2023-03-24	100.00	2022-12-15	6	REAL
2350	ifood *ifood	2023-03-24	46.10	2022-12-16	6	REAL
2351	ifood *ifood	2023-03-24	24.99	2022-12-17	6	REAL
2352	ifood *ifood	2023-03-24	24.99	2022-12-19	6	REAL
2353	ifood *ifood	2023-03-24	37.68	2022-12-20	6	REAL
2354	ifood *ifood	2023-03-24	38.80	2022-12-20	6	REAL
2355	ifood *ifood	2023-03-24	27.99	2022-12-20	6	REAL
2356	APPLE.COM/BILL	2023-03-24	14.90	2022-12-20	6	REAL
2357	PG *ALPDEX FACIL ESTAC JOINVILLE B	2023-03-24	10.00	2022-12-21	6	REAL
2358	TRES JOLIE	2023-03-24	435.00	2022-12-22	6	REAL
2359	CARREFOUR PAN	2023-03-24	223.15	2022-12-22	6	REAL
2360	ifood *IFD*Emporio M	2023-03-24	42.99	2022-12-23	6	REAL
2361	ifood *IFD*La Minute	2023-03-24	33.94	2022-12-26	6	REAL
2362	Uber *UBER *TRIP	2023-03-24	16.95	2022-12-27	6	REAL
2363	Uber *UBER *TRIP	2023-03-24	12.96	2022-12-27	6	REAL
2364	ifood *IFD*Dona Mari	2023-03-24	35.90	2022-12-28	6	REAL
2365	EBW *SPOTIFY RIO DE JANEIR	2023-03-24	19.90	2022-12-28	6	REAL
2366	ifood *IFD*Arte da C	2023-03-24	51.95	2022-12-28	6	REAL
2367	ifood *IFD*Espetos e	2023-03-24	49.19	2022-12-29	6	REAL
2368	LOCALIZA MULTA DE TRAN BELO HORIZO	2023-03-24	124.96	2022-12-29	6	REAL
2369	ifood *IFD*Dona Mari	2023-03-24	34.90	2022-12-29	6	REAL
2370	ifood *Espetinhos Mi Vila Yara Osa	2023-03-24	21.39	2022-12-31	6	REAL
2371	Pagamento fatura 01/2023	2023-01-11	7007.99	2023-03-24	5	REAL
2372	MFB COMERCIO DE PRO 02/03 SANTO AN	2023-03-24	100.00	2023-01-15	6	REAL
2373	LOCALIZA RAC ACCAE0	2023-03-24	356.93	2023-01-02	6	REAL
2374	Uber *UBER *TRIP	2023-03-24	24.99	2023-01-02	6	REAL
2375	Amazon.com.br Digital	2023-03-24	19.90	2023-01-03	6	REAL
2376	AmazonPrimeBR	2023-03-24	14.90	2023-01-03	6	REAL
2377	UBER *TRIP HELP.UBER.C	2023-03-24	94.93	2023-01-03	6	REAL
2378	DM *HELPHBOMAXCOM	2023-03-24	27.90	2023-01-04	6	REAL
2379	LOCALIZA MULTA E PASS	2023-03-24	124.96	2023-01-06	6	REAL
2380	Disney Plus	2023-03-24	27.90	2023-01-06	6	REAL
2381	NETFLIX.COM	2023-03-24	39.90	2023-01-11	6	REAL
2382	APPLE.COM/BILL	2023-03-24	14.90	2023-01-20	6	REAL
2383	LOCALIZA MULTA DE TRAN ALTAMIRA BR	2023-03-24	124.96	2023-01-20	6	REAL
2384	EBW *SPOTIFY	2023-03-24	19.90	2023-01-28	6	REAL
2385	IOF TRANSACOES INTERNACIONAIS	2023-03-24	5.68	2023-02-01	6	REAL
2386	UBER *TRIP HELP.UBER.COM NL 7.00	2023-03-24	39.64	2023-01-03	6	REAL
2387	STEAM PURCHASE SEATTLE DE	2023-03-24	30.00	2023-01-04	6	REAL
2388	STEAM PURCHASE SEATTLE DE	2023-03-24	35.99	2023-01-26	6	REAL
2389	Pagamento fatura 02/2023	2023-02-08	1103.38	2023-03-24	5	REAL
2390	MFB COMERCIO DE PRO 03/03 SANTO AN	2023-03-24	100.00	2023-02-15	6	REAL
2391	AmazonPrimeBR	2023-03-24	14.90	2023-02-03	6	REAL
2392	Amazon.com.br Digital	2023-03-24	19.90	2023-02-03	6	REAL
2393	DM *HELPHBOMAXCOM	2023-03-24	27.90	2023-02-04	6	REAL
2394	Disney Plus	2023-03-24	27.90	2023-02-06	6	REAL
2395	NETFLIX.COM	2023-03-24	39.90	2023-02-11	6	REAL
2396	APPLE.COM/BILL	2023-03-24	14.90	2023-02-20	6	REAL
2397	EBW*SPOTIFY	2023-03-24	19.90	2023-02-25	6	REAL
2398	ANUIDADE DIFERENCIADA 03/12	2023-03-24	30.00	2023-02-02	6	REAL
2399	Pagamento fatura 03/2023	2023-03-07	295.30	2023-03-24	5	REAL
2400	Glovo 28NOV BRVC1QBKA	2023-03-24	12.88	2022-11-30	3	EURO
2401	Glovo 28NOV BRYTWS6SM	2023-03-24	8.70	2022-11-30	3	EURO
2402	Glovo 27NOV BREZ2TCYS	2023-03-24	9.54	2022-11-29	3	EURO
2403	Glovo 25NOV BRSBGC12Y	2023-03-24	10.03	2022-11-29	3	EURO
2404	Glovo 24NOV BR2DTDM3W	2023-03-24	10.86	2022-11-29	3	EURO
2405	Glovo 24NOV BRWERN9UG	2023-03-24	26.85	2022-11-29	3	EURO
2406	Glovo 23NOV BRRWEWXYZ	2023-03-24	8.77	2022-11-28	3	EURO
2407	LA PORTA REST BRAGA	2023-03-24	30.00	2022-11-28	3	EURO
2408	Glovo 22NOV BRAGMED2F	2023-03-24	10.93	2022-11-24	3	EURO
2409	Salário	2023-03-24	3800.00	2022-12-29	3	EURO
2410	VODAFONE PORTUGAL COMU	2023-03-24	27.89	2022-12-27	3	EURO
2412	AGEREEMP.DE AGUAS,EFL	2023-03-24	15.26	2022-12-12	3	EURO
2414	COM. MANUTENCAO CONTA ORDENADO 112022	2023-03-24	5.20	2022-12-12	3	EURO
2417	Vodafone.pt	2023-03-24	7.50	2022-12-06	3	EURO
2418	AREAS PORTUGAL SA MAIA	2023-03-24	6.55	2022-12-06	3	EURO
2420	AREAS PORTUGAL SA PORTO	2023-03-24	4.25	2022-12-06	3	EURO
2427	Glovo 29NOV BRC69RWBF	2023-03-24	8.77	2022-12-02	3	EURO
2431	EDP COMERCIALCOMERCIA	2023-03-24	35.08	2022-12-12	3	EURO
2433	IMPOSTO DE SELO 17.3.4	2023-03-24	0.21	2022-12-12	3	EURO
2435	IMPOSTO DO SELO	2023-03-24	0.13	2022-12-09	3	EURO
2436	MDB DISPONIBILIZACAO CARTAO DEBITO  3490625	2023-03-24	3.25	2022-12-09	3	EURO
2439	AREAS PORTUGAL SA MAIA	2023-03-24	14.50	2022-12-06	3	EURO
2441	RELAY VIRGIN PORTO 4470558 MAIA	2023-03-24	14.39	2022-12-05	3	EURO
2442	Glovo 01DEC BR1S9WYWR	2023-03-24	11.33	2022-12-02	3	EURO
2443	Glovo 01DEC BRWUAYQ1Z	2023-03-24	11.04	2022-12-02	3	EURO
2444	EBA LA BRAGA	2023-03-24	9.00	2022-12-02	3	EURO
2445	Glovo 30NOV BRQ5MS5PQ	2023-03-24	10.93	2022-12-02	3	EURO
2446	Glovo 29NOV BR8CPWKP5	2023-03-24	16.89	2022-12-02	3	EURO
2448	Glovo 29NOV BRCP1GDWA	2023-03-24	9.03	2022-12-02	3	EURO
2450	Saque	2023-03-24	20.00	2022-12-01	3	EURO
2451	Salario	2023-03-24	3800.00	2023-01-31	3	EURO
2452	EUREST A S FIGUEIRA FO	2023-03-24	3.25	2023-01-31	3	EURO
2453	Glovo 29JAN BRUGX77TM	2023-03-24	12.19	2023-01-31	3	EURO
2454	SOL VAGOS SUL VAGOS PR	2023-03-24	6.60	2023-01-31	3	EURO
2455	BRAGA RIO LOJA 306 BRAG	2023-03-24	10.30	2023-01-31	3	EURO
2456	CORTES DE LISBOA BRAGA	2023-03-24	15.00	2023-01-31	3	EURO
2457	Glovo 27JAN BRU1ALY1M	2023-03-24	11.03	2023-01-31	3	EURO
2458	Glovo 27JAN BRK5BLVQH	2023-03-24	7.26	2023-01-31	3	EURO
2459	LEV ATM 6251 BESCL Braga         Rua de Caires	2023-03-24	40.00	2023-01-30	3	EURO
2460	Glovo 26JAN BRGHAWL9K	2023-03-24	12.32	2023-01-30	3	EURO
2461	EST SERVICO POSTO BP SULNORTE PATA	2023-03-24	40.60	2023-01-30	3	EURO
2462	HOTEL MAR BRAVO NAZARE	2023-03-24	24.00	2023-01-30	3	EURO
2463	XIAYU CHEN N 64 E 65	2023-03-24	4.95	2023-01-30	3	EURO
2464	EUREST FIF DA FOZ 3080	2023-03-24	10.20	2023-01-30	3	EURO
2465	BRAGA PARQUE 4710427 BRAGA	2023-03-24	1.90	2023-01-30	3	EURO
2466	RAUL EDGAR UNIP LDA BRA	2023-03-24	12.90	2023-01-27	3	EURO
2467	Glovo 25JAN BR1BMX4VY	2023-03-24	53.54	2023-01-27	3	EURO
2468	Glovo 25JAN BRAXNK7WD	2023-03-24	9.59	2023-01-27	3	EURO
2469	Glovo 24JAN BRMD8EFYP	2023-03-24	12.19	2023-01-27	3	EURO
2470	Vodafone.pt Lisboa PR	2023-03-24	15.00	2023-01-27	3	EURO
2471	Glovo 24JAN BRKKEAVMB	2023-03-24	16.09	2023-01-27	3	EURO
2472	IMPOSTO DO SELO	2023-03-24	0.92	2023-01-27	3	EURO
2473	MDB DISPONIBILIZACAO CARTAO DEBITO  3490625	2023-03-24	23.00	2023-01-27	3	EURO
2474	Glovo 23JAN BRHTH7EUV	2023-03-24	11.09	2023-01-25	3	EURO
2475	Glovo 23JAN BRJFA4TAU	2023-03-24	11.03	2023-01-25	3	EURO
2476	CONTINENTE BRAGA BRAGA	2023-03-24	14.08	2023-01-24	3	EURO
2477	Glovo 20JAN BRXTXPBWJ	2023-03-24	11.29	2023-01-24	3	EURO
2478	Comissao Emissao s/ Ordem Pag.  Ref.20230142586	2023-03-24	1.10	2023-01-23	3	EURO
2479	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20230142586	2023-03-24	0.04	2023-01-23	3	EURO
2480	PINGO DOCE BRAGA BRAGA	2023-03-24	14.80	2023-01-23	3	EURO
2481	LA PORTA REST BRAGA	2023-03-24	33.00	2023-01-23	3	EURO
2482	LA ROTISSERIE BRAGA	2023-03-24	10.45	2023-01-23	3	EURO
2483	Glovo 19JAN BRAA18XHD	2023-03-24	11.88	2023-01-20	3	EURO
2484	Glovo 18JAN BR7YLWQ51	2023-03-24	12.38	2023-01-20	3	EURO
2485	Glovo 18JAN BR6BCFAC9	2023-03-24	14.59	2023-01-20	3	EURO
2486	PRIMARK BRAGE PARQUE B	2023-03-24	11.20	2023-01-19	3	EURO
2487	FNAC BRAGA BRAGA PR	2023-03-24	42.13	2023-01-19	3	EURO
2488	BRAGA RIO LOJA 306 BRAG	2023-03-24	10.30	2023-01-19	3	EURO
2489	PINGO DOCE BRAGA BRAGA	2023-03-24	114.16	2023-01-18	3	EURO
2490	Glovo 16JAN BRCXJ9QSR	2023-03-24	10.74	2023-01-18	3	EURO
2491	MARIA AMALIA BATISTA BR	2023-03-24	2.15	2023-01-18	3	EURO
2492	Glovo 15JAN BRK5WLQDP	2023-03-24	16.09	2023-01-18	3	EURO
2493	Glovo 12JAN BRGULU4LM	2023-03-24	13.10	2023-01-13	3	EURO
2494	LA PORTA REST BRAGA	2023-03-24	30.00	2023-01-13	3	EURO
2495	Glovo 11JAN BRUMQDSSD	2023-03-24	12.29	2023-01-13	3	EURO
2496	Glovo 11JAN BRXTL1P7D	2023-03-24	11.09	2023-01-13	3	EURO
2497	PINGO DOCE BRAGA BRAGA	2023-03-24	49.36	2023-01-12	3	EURO
2498	Glovo 10JAN BRYQQPULM	2023-03-24	11.09	2023-01-12	3	EURO
2499	VODAFONE PORTUGAL COMU	2023-03-24	27.89	2023-01-11	3	EURO
2500	AGEREEMP.DE AGUAS,EFL	2023-03-24	17.32	2023-01-11	3	EURO
2501	EDP COMERCIALCOMERCIA	2023-03-24	16.31	2023-01-11	3	EURO
2502	Glovo 09JAN BRC7EXB6E	2023-03-24	26.80	2023-01-11	3	EURO
2503	Glovo 09JAN BRPU19LJT	2023-03-24	9.08	2023-01-11	3	EURO
2504	MENDES CALDAS E N.213	2023-03-24	14.27	2023-01-10	3	EURO
2505	Glovo 08JAN BRJWAAJNA	2023-03-24	13.68	2023-01-10	3	EURO
2506	Glovo 07JAN BRG4L5VSW	2023-03-24	15.38	2023-01-10	3	EURO
2507	Glovo 07JAN BRJFDLCQL	2023-03-24	16.38	2023-01-10	3	EURO
2508	BODEGAO BRAGA 4710427	2023-03-24	10.50	2023-01-09	3	EURO
2509	FNAC BRAGA 4710427 BRAGA	2023-03-24	31.13	2023-01-09	3	EURO
2510	IMPOSTO DE SELO 17.3.4	2023-03-24	0.21	2023-01-09	3	EURO
2511	COM. MANUTENCAO CONTA ORDENADO 122022	2023-03-24	5.20	2023-01-09	3	EURO
2512	WORTEN BRAGA NOVA BRAGA	2023-03-24	54.99	2023-01-06	3	EURO
2513	Glovo 04JAN BRYFQLDH7	2023-03-24	10.74	2023-01-06	3	EURO
2514	TAXIS PINHEIRO LDA MAIA PR	2023-03-24	87.00	2023-01-06	3	EURO
2515	Glovo 03JAN BRUQSFMN1	2023-03-24	8.85	2023-01-06	3	EURO
2516	LEV ATM 6251 ENPT1233 Maia	2023-03-24	70.00	2023-01-06	3	EURO
2517	LA PORTA REST BRAGA	2023-03-24	22.00	2023-01-05	3	EURO
2518	CONTINENTE BRAGA BRAGA	2023-03-24	47.26	2023-01-03	3	EURO
2519	Cobrir Conta	\N	500.00	2023-01-23	3	EURO
2520	Glovo 26FEB BRJQ15LNJ	2023-03-25	16.50	2023-02-28	3	EURO
2521	Glovo 25FEB BRL11U1P2	2023-03-25	16.09	2023-02-28	3	EURO
2522	Glovo 25FEB BRGWLHJJ1	2023-03-25	10.35	2023-02-28	3	EURO
2523	Glovo 24FEB BR1MBEFTV	2023-03-25	12.46	2023-02-28	3	EURO
2524	Glovo 24FEB BR2ZBLKSN	2023-03-25	10.28	2023-02-28	3	EURO
2525	CONTINENTE BRAGA BRAGA	2023-03-25	72.30	2023-02-27	3	EURO
2526	TACO BELL BRAGA ARCABRAGA	2023-03-25	6.90	2023-02-27	3	EURO
2527	TOMATINO BRAGA PARQUBRA	2023-03-25	8.50	2023-02-27	3	EURO
2528	Glovo 23FEB BRNUDVMWP	2023-03-25	15.59	2023-02-24	3	EURO
2529	Glovo 23FEB BRSKHVMBF	2023-03-25	9.89	2023-02-24	3	EURO
2530	Glovo 22FEB BRK1XJTXH	2023-03-25	15.31	2023-02-24	3	EURO
2531	Glovo 21FEB BRLKY5NXG	2023-03-25	39.50	2023-02-23	3	EURO
2532	Glovo 21FEB BRU11EKTV	2023-03-25	15.31	2023-02-23	3	EURO
2533	Glovo 20FEB BRMQRHEBH	2023-03-25	10.09	2023-02-23	3	EURO
2534	Glovo 20FEB BRYJHVLHG	2023-03-25	10.90	2023-02-23	3	EURO
2535	Glovo 19FEB BR9E5VWJA	2023-03-25	12.89	2023-02-21	3	EURO
2536	Glovo 19FEB BRL9RGAYV	2023-03-25	10.99	2023-02-21	3	EURO
2537	Glovo 18FEB BRD49PXXS	2023-03-25	13.24	2023-02-21	3	EURO
2538	Glovo 17FEB BRSCA3YL7	2023-03-25	12.03	2023-02-21	3	EURO
2539	TOMATINO BRAGA PARQUBRA	2023-03-25	8.50	2023-02-20	3	EURO
2540	FNAC BRAGA 4710427 BRA	2023-03-25	27.13	2023-02-20	3	EURO
2541	Glovo 16FEB BR1WR77KY	2023-03-25	14.10	2023-02-17	3	EURO
2542	Glovo 15FEB BR1QHDGMG	2023-03-25	11.49	2023-02-17	3	EURO
2543	Glovo 15FEB BRACAP3EY	2023-03-25	41.61	2023-02-17	3	EURO
2544	Glovo 14FEB BRBWGBXXQ	2023-03-25	11.49	2023-02-16	3	EURO
2545	Glovo 13FEB BRYJ7LGGT	2023-03-25	11.49	2023-02-15	3	EURO
2546	Glovo 12FEB BRRYZN41Z	2023-03-25	19.59	2023-02-14	3	EURO
2547	Glovo 10FEB BRCHXQS1B	2023-03-25	11.49	2023-02-14	3	EURO
2548	Glovo 09FEB BR6FXXJPC	2023-03-25	11.49	2023-02-14	3	EURO
2549	Glovo 09FEB BRSFC4H11	2023-03-25	31.06	2023-02-14	3	EURO
2550	TOMATINO NOVA ARCADABRA	2023-03-25	8.50	2023-02-13	3	EURO
2551	Glovo 08FEB BRHT1B1KZ	2023-03-25	11.49	2023-02-13	3	EURO
2552	WORTEN BRAGA NOVA BRAGA	2023-03-25	94.99	2023-02-13	3	EURO
2553	LA ROTISSERIE BRAGA	2023-03-25	11.70	2023-02-13	3	EURO
2554	IMPOSTO DE SELO 17.3.4	2023-03-25	0.21	2023-02-10	3	EURO
2555	COM. MANUTENCAO CONTA ORDENADO 012023	2023-03-25	5.20	2023-02-10	3	EURO
2556	Glovo 07FEB BRYLJTJPE	2023-03-25	11.49	2023-02-10	3	EURO
2557	VODAFONE PORTUGAL COMU	2023-03-25	29.39	2023-02-08	3	EURO
2558	EDP COMERCIALCOMERCIA	2023-03-25	112.61	2023-02-08	3	EURO
2559	AGEREEMP.DE AGUAS,EFL	2023-03-25	16.81	2023-02-08	3	EURO
2560	Glovo 06FEB BRLH1WXWK	2023-03-25	15.09	2023-02-08	3	EURO
2561	Glovo 06FEB BR6MAAL1A	2023-03-25	11.49	2023-02-08	3	EURO
2562	IKEA BRAGA CAIXAS ECO B	2023-03-25	30.69	2023-02-07	3	EURO
2563	Glovo 04FEB BRE2J1X1L	2023-03-25	13.59	2023-02-07	3	EURO
2564	Glovo 03FEB BR1KSJBNN	2023-03-25	11.49	2023-02-07	3	EURO
2565	Glovo 02FEB BRX6FAJWK	2023-03-25	11.03	2023-02-06	3	EURO
2566	Glovo 01FEB BRHMR1RPP	2023-03-25	11.49	2023-02-06	3	EURO
2567	LA ROTISSERIE BRAGA	2023-03-25	10.55	2023-02-06	3	EURO
2568	Glovo 31JAN BRE82KXK7	2023-03-25	11.49	2023-02-02	3	EURO
2569	PINGO DOCE BRAGA BRAGA	2023-03-25	76.20	2023-02-01	3	EURO
2570	Glovo 30JAN BRXKRJSM1	2023-03-25	9.49	2023-02-01	3	EURO
2571	Salario	2023-03-25	3800.00	2023-02-28	3	EURO
2572	Glovo 22MAR BRZPHLYNT	2023-03-25	9.98	2023-03-24	3	EURO
2573	CONTINENTE BRAGA BRAGA	2023-03-25	72.87	2023-03-23	3	EURO
2574	Glovo 21MAR BR3NQCBWE	2023-03-25	9.90	2023-03-23	3	EURO
2575	Glovo 20MAR BR19L1P9L	2023-03-25	12.50	2023-03-22	3	EURO
2576	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	4.86	2023-03-21	3	EURO
2577	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	4.43	2023-03-21	3	EURO
2578	Glovo 19MAR BRCNX2JZN	2023-03-25	10.80	2023-03-21	3	EURO
2579	Glovo 19MAR BRSNPKSUM	2023-03-25	9.96	2023-03-21	3	EURO
2580	NOS CINEMAS BRAGA PQ BR	2023-03-25	7.15	2023-03-21	3	EURO
2581	BRAGA RIO LOJA 306 BRAG	2023-03-25	13.40	2023-03-21	3	EURO
2582	CORTES DE LISBOA BRAGA	2023-03-25	15.00	2023-03-21	3	EURO
2583	Glovo 17MAR BRDETJEEL	2023-03-25	9.90	2023-03-21	3	EURO
2584	Glovo 16MAR BREXECCFM	2023-03-25	9.90	2023-03-17	3	EURO
2585	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	4.83	2023-03-17	3	EURO
2586	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	5.26	2023-03-17	3	EURO
2587	Glovo 15MAR BRLUATQQC	2023-03-25	9.90	2023-03-17	3	EURO
2588	Glovo 14MAR BRLT6ZN2C	2023-03-25	10.58	2023-03-16	3	EURO
2589	PINGO DOCE BRAGA BRAGA	2023-03-25	76.59	2023-03-15	3	EURO
2590	Glovo 13MAR BRUJLNSQ1	2023-03-25	8.50	2023-03-15	3	EURO
2591	a.NordVPN Amsterdam NL	2023-03-25	14.75	2023-03-14	3	EURO
2592	Glovo 12MAR BRSNX7BZW	2023-03-25	13.99	2023-03-14	3	EURO
2593	Glovo 11MAR BR4A72P4E	2023-03-25	12.50	2023-03-14	3	EURO
2594	Glovo 11MAR BRUBFEN1D	2023-03-25	11.20	2023-03-14	3	EURO
2595	Glovo 10MAR BRZLGHPU7	2023-03-25	13.99	2023-03-14	3	EURO
2596	Glovo 10MAR BRXF6SBAP	2023-03-25	9.90	2023-03-14	3	EURO
2597	Glovo 09MAR BRHVTLXVC	2023-03-25	12.26	2023-03-13	3	EURO
2598	IMPOSTO DE SELO 17.3.4	2023-03-25	0.21	2023-03-10	3	EURO
2599	COM. MANUTENCAO CONTA ORDENADO 022023	2023-03-25	5.20	2023-03-10	3	EURO
2600	Glovo 07MAR BRPFMHRGX	2023-03-25	9.90	2023-03-09	3	EURO
2601	VODAFONE PORTUGAL COMU	2023-03-25	36.40	2023-03-07	3	EURO
2602	EDP COMERCIALCOMERCIA	2023-03-25	115.96	2023-03-07	3	EURO
2603	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	6.27	2023-03-07	3	EURO
2604	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	6.86	2023-03-07	3	EURO
2605	Glovo 04MAR BRVNCL8GS	2023-03-25	15.00	2023-03-07	3	EURO
2606	Glovo 03MAR BRWXH7JBC	2023-03-25	15.50	2023-03-07	3	EURO
2607	Glovo 03MAR BRVSYXN1E	2023-03-25	13.35	2023-03-07	3	EURO
2608	CONTINENTE BRAGA BRAGA	2023-03-25	51.99	2023-03-06	3	EURO
2609	Glovo 02MAR BRD3FBAHG	2023-03-25	9.89	2023-03-03	3	EURO
2610	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	7.12	2023-03-01	3	EURO
2611	UBR PENDING.UBER.COM AMSTERDAM NL	2023-03-25	6.48	2023-03-01	3	EURO
2613	UBER   *TRIP	2023-03-25	3.50	2022-11-28	4	EURO
2614	UBER   *TRIP	2023-03-25	3.50	2022-11-28	4	EURO
2615	UBER   *TRIP	2023-03-25	3.50	2022-12-02	4	EURO
2616	UBER   *TRIP	2023-03-25	3.50	2022-12-02	4	EURO
2617	Vodafone GmbH CallYa	2023-03-25	50.00	2022-12-04	4	EURO
2618	UBER   *TRIP	2023-03-25	3.50	2022-12-05	4	EURO
2619	UBER   *TRIP	2023-03-25	6.49	2023-01-05	4	EURO
2620	UBER   *TRIP	2023-03-25	3.50	2023-01-06	4	EURO
2621	UBER   *TRIP	2023-03-25	3.50	2023-01-07	4	EURO
2622	UBER   *TRIP	2023-03-25	6.70	2023-01-09	4	EURO
2623	UBER   *TRIP	2023-03-25	6.47	2023-01-09	4	EURO
2624	UBER   *TRIP	2023-03-25	4.19	2023-01-10	4	EURO
2625	UBER   *TRIP	2023-03-25	4.65	2023-01-10	4	EURO
2626	AMZN MKTP ES*1H2P106H4	2023-03-25	44.86	2023-01-11	4	EURO
2627	UBER   *TRIP	2023-03-25	5.09	2023-01-14	4	EURO
2628	UBER   *TRIP	2023-03-25	4.64	2023-01-14	4	EURO
2629	UBER   *TRIP	2023-03-25	3.50	2023-01-16	4	EURO
2630	UBER   *TRIP	2023-03-25	3.29	2023-01-18	4	EURO
2631	UBER *TRIP HELP.UBER.C	2023-03-25	3.19	2023-01-19	4	EURO
2632	UBER   *TRIP	2023-03-25	3.51	2023-01-19	4	EURO
2633	UBER   *TRIP	2023-03-25	3.28	2023-01-20	4	EURO
2634	AMZN MKTP ES*1A3LN76U4	2023-03-25	71.95	2023-01-22	4	EURO
2635	UBER   *TRIP	2023-03-25	4.89	2023-01-23	4	EURO
2636	UBER   *TRIP	2023-03-25	5.16	2023-01-23	4	EURO
2637	UBER   *TRIP	2023-03-25	2.80	2023-01-24	4	EURO
2638	UBER   *TRIP	2023-03-25	4.52	2023-01-25	4	EURO
2639	UBER   *TRIP	2023-03-25	4.74	2023-01-25	4	EURO
2640	UBER   *TRIP	2023-03-25	5.34	2023-01-25	4	EURO
2641	UBER   *TRIP	2023-03-25	5.02	2023-01-26	4	EURO
2642	Avis Rent A Car	2023-03-25	190.83	2023-02-02	4	EURO
2643	UBER   *TRIP	2023-03-25	4.67	2023-02-03	4	EURO
2644	UBER   *TRIP	2023-03-25	5.24	2023-02-03	4	EURO
2645	UBER *TRIP HELP.UBER.C	2023-03-25	11.38	2023-02-06	4	EURO
2646	UBER   *TRIP	2023-03-25	7.14	2023-02-06	4	EURO
2647	UBER   *TRIP	2023-03-25	5.18	2023-02-13	4	EURO
2648	UBER   *TRIP	2023-03-25	4.36	2023-02-13	4	EURO
2649	UBER   *TRIP	2023-03-25	6.85	2023-02-13	4	EURO
2650	UBER   *TRIP	2023-03-25	6.95	2023-02-15	4	EURO
2651	UBER   *TRIP	2023-03-25	6.80	2023-02-15	4	EURO
2652	UBER   *TRIP	2023-03-25	4.85	2023-02-22	4	EURO
2653	UBER   *TRIP	2023-03-25	4.24	2023-02-22	4	EURO
2654	UBER   *TRIP	2023-03-25	4.50	2023-02-28	4	EURO
2655	UBER   *TRIP	2023-03-25	4.23	2023-02-28	4	EURO
2656	AMZN MKTP ES*1L0SE9YP4	2023-03-25	38.60	2023-03-05	4	EURO
2657	Glovo 08MAR BR9LS4THQ	2023-03-25	9.90	2023-03-08	4	EURO
2658	Glovo 09MAR BRB9CVX2Y	2023-03-25	9.90	2023-03-09	4	EURO
2659	Glovo 10MAR BRNKLBZXG	2023-03-25	14.31	2023-03-11	4	EURO
2660	Glovo 13MAR BRXMVTUUB	2023-03-25	12.53	2023-03-14	4	EURO
2661	Glovo 21MAR BRTEAWLLH	2023-03-25	7.17	2023-03-22	4	EURO
2662	Glovo 22MAR BRZLBFLFR	2023-03-25	9.90	2023-03-23	4	EURO
2612	Salario	\N	3800.00	2023-03-31	3	EURO
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
28	301	200.00	2021-11-01 00:00:00	2021-11-30 23:59:59.999
29	301	200.00	2022-01-01 00:00:00	2022-01-31 23:59:59.999
30	301	200.00	2022-02-01 00:00:00	2022-02-28 23:59:59.999
31	301	200.00	2022-03-01 00:00:00	2022-03-31 23:59:59.999
32	301	250.00	2022-04-01 00:00:00	2022-04-30 23:59:59.999
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
t	986	109	\N
t	1080	109	\N
t	1120	109	\N
t	1177	109	\N
t	1235	111	\N
t	1183	109	\N
t	1360	109	\N
t	1415	109	\N
t	1524	109	\N
t	1610	109	\N
t	1716	111	\N
t	1717	109	\N
t	1795	109	\N
t	1797	111	\N
t	1798	111	\N
t	1904	109	\N
t	1906	109	\N
t	1989	109	\N
t	2091	109	\N
t	2409	109	\N
t	2451	109	\N
t	2571	109	\N
f	2612	109	\N
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
D	3	#00ffc2	Casa
D	4	#8f5151	Contas
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
1067	4	200.00
1078	4	4000.00
1079	4	300.00
1163	4	500.00
1298	6	3232.78
1370	6	4646.55
1407	4	200.00
1428	6	171.42
1535	4	200.00
1618	6	153.40
1680	4	1000.00
1681	4	1000.00
1682	4	200.00
1710	6	153.40
1755	6	153.40
1796	4	2000.00
1905	4	200.00
1988	4	1000.00
2044	4	2000.00
2229	6	230.88
2230	6	186.30
2231	6	441.43
2232	6	195.07
2304	6	240.67
2371	6	7007.99
2389	6	1103.38
2399	6	295.30
2519	4	500.00
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

SELECT pg_catalog.setval('despesas_db.fatura_id_seq', 56, true);


--
-- Name: meta_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.meta_id_seq', 32, true);


--
-- Name: movimentacao_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.movimentacao_id_seq', 2662, true);


--
-- Name: orcamento_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.orcamento_id_seq', 32, true);


--
-- Name: servico_transferencia_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.servico_transferencia_id_seq', 2, true);


--
-- Name: tipo_movimentacao_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.tipo_movimentacao_id_seq', 4, true);


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

