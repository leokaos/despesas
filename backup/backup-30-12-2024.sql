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
48470.30	5
50007.77	3
508.48	4
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
t	107	1	\N
t	108	1	\N
t	111	1	\N
t	100	302	\N
t	102	108	\N
t	104	302	\N
t	105	301	\N
t	106	201	\N
t	109	108	\N
t	110	301	\N
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
t	114	302	\N
t	116	108	\N
t	117	302	\N
t	118	302	\N
t	119	102	\N
t	120	108	\N
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
t	2664	104	\N
t	2665	107	\N
t	2666	107	\N
t	2667	107	\N
t	2668	107	\N
t	2669	102	\N
t	2670	102	\N
t	2671	102	\N
t	2672	102	\N
t	2673	108	\N
t	2674	108	\N
t	2675	301	\N
t	2676	102	\N
t	2677	102	\N
t	2678	102	\N
t	2679	102	\N
t	2680	102	\N
t	2681	107	\N
t	2682	102	\N
t	2683	107	\N
t	2684	107	\N
t	2685	107	\N
t	2686	104	\N
t	2687	104	\N
t	2688	102	\N
t	2689	107	\N
t	2690	107	\N
t	2691	102	\N
t	2693	102	\N
t	2694	102	\N
t	2696	201	\N
t	2697	102	\N
t	2698	102	\N
t	2699	102	\N
t	2700	108	\N
t	2703	201	57
t	2704	201	57
t	2705	201	57
t	2706	201	57
t	2707	201	57
t	2708	108	57
t	2709	201	57
t	2710	201	57
t	2712	108	\N
t	2713	107	\N
t	2714	1	\N
t	2715	3	\N
t	2716	102	\N
t	2717	102	\N
t	2718	4	\N
t	2719	102	\N
t	2720	102	\N
t	2721	301	\N
t	2722	102	\N
t	2723	102	\N
t	2724	102	\N
t	2725	102	\N
t	2726	102	\N
t	2727	107	\N
t	2728	107	\N
t	2729	107	\N
t	2730	107	\N
t	2731	301	\N
t	2732	104	\N
t	2733	102	\N
t	2734	102	\N
t	2735	102	\N
t	2736	102	\N
t	2737	102	\N
t	2738	102	\N
t	2739	102	\N
t	2740	102	\N
t	2741	4	\N
t	2742	4	\N
t	2743	107	\N
t	2744	107	\N
t	2745	107	\N
t	2746	107	\N
t	2747	102	\N
t	2748	102	\N
t	2749	102	\N
t	2750	301	\N
t	2751	102	\N
t	2752	102	\N
t	2753	102	\N
t	2754	102	\N
t	2755	108	\N
t	2756	108	\N
t	2757	201	\N
t	2758	102	\N
t	2759	102	\N
t	2760	102	\N
t	2761	102	\N
t	2762	108	\N
t	2763	108	\N
t	2764	108	\N
t	2765	108	58
t	2766	201	58
t	2767	201	58
t	2768	201	58
t	2769	201	58
t	2770	201	58
t	2771	201	58
t	2772	201	58
t	2773	201	58
t	2775	4	\N
t	2776	4	\N
t	2777	4	\N
t	2778	107	\N
t	2779	107	\N
t	2780	102	\N
t	2781	301	\N
t	2782	107	\N
t	2783	107	\N
t	2784	107	\N
t	2785	107	\N
t	2786	107	\N
t	2787	107	\N
t	2788	107	\N
t	2789	107	\N
t	2790	3	\N
t	2791	102	\N
t	2792	107	\N
t	2793	107	\N
t	2794	301	\N
t	2795	102	\N
t	2796	102	\N
t	2797	107	\N
t	2798	107	\N
t	2799	102	\N
t	2800	108	\N
t	2801	108	\N
t	2802	108	\N
t	2803	108	\N
t	2804	201	58
t	2805	108	58
t	2807	102	\N
t	2808	102	\N
t	2809	102	\N
t	2810	102	\N
t	2811	102	\N
t	2812	102	\N
t	2813	102	\N
t	2814	107	\N
t	2815	102	\N
t	2816	102	\N
t	2818	107	\N
t	2819	107	\N
t	2820	301	\N
t	2821	102	\N
t	2822	102	\N
t	2823	102	\N
t	2824	102	\N
t	2825	102	\N
t	2826	102	\N
t	2827	102	\N
t	2828	108	\N
t	2829	108	\N
t	2830	108	\N
t	2831	108	\N
t	2832	108	\N
t	2833	108	\N
t	2834	107	\N
t	2835	107	\N
t	2836	102	\N
t	2837	102	\N
t	2838	102	\N
t	2839	107	\N
t	2840	107	\N
t	2841	107	\N
t	2842	107	\N
t	2843	301	\N
t	2844	102	\N
t	2845	104	\N
t	2846	102	\N
t	2847	102	\N
t	2848	102	\N
t	2849	102	\N
t	2850	102	\N
t	2851	107	\N
t	2852	102	\N
t	2853	102	\N
t	2854	107	\N
t	2855	107	\N
t	2856	102	\N
t	2857	107	\N
t	2858	107	\N
t	2859	107	\N
t	2860	107	\N
t	2861	103	\N
t	2862	102	\N
t	2863	301	\N
t	2864	102	\N
t	2865	107	\N
t	2866	107	\N
t	2867	102	\N
t	2868	301	\N
t	2869	102	\N
t	2870	102	\N
t	2871	108	\N
t	2872	108	\N
t	2873	103	\N
t	2874	102	\N
t	2875	107	\N
t	2876	107	\N
t	2877	102	\N
t	2878	108	\N
t	2879	108	\N
t	2880	102	\N
t	2881	107	\N
t	2882	107	\N
t	2883	301	\N
t	2884	102	\N
t	2885	107	\N
t	2886	103	\N
t	2887	102	\N
t	2888	107	\N
t	2890	4	\N
t	2891	108	\N
t	2892	4	\N
t	2893	102	\N
t	2894	102	\N
t	2895	102	\N
t	2897	201	59
t	2898	201	59
t	2899	108	59
t	2900	201	59
t	2901	201	59
t	2902	201	59
t	2903	201	59
t	2904	201	59
t	2905	102	\N
t	2906	102	\N
t	2907	102	\N
t	2908	107	\N
t	2909	107	\N
t	2910	102	\N
t	2911	102	\N
t	2912	102	\N
t	2913	102	\N
t	2914	107	\N
t	2915	107	\N
t	2916	107	\N
t	2917	107	\N
t	2918	301	\N
t	2919	102	\N
t	2920	102	\N
t	2921	102	\N
t	2922	102	\N
t	2923	107	\N
t	2924	107	\N
t	2925	102	\N
t	2926	102	\N
t	2927	102	\N
t	2928	107	\N
t	2929	107	\N
t	2930	107	\N
t	2931	107	\N
t	2932	102	\N
t	2933	301	\N
t	2934	104	\N
t	2935	3	\N
t	2936	102	\N
t	2937	102	\N
t	2938	102	\N
t	2939	102	\N
t	2940	102	\N
t	2941	102	\N
t	2942	107	\N
t	2943	107	\N
t	2944	102	\N
t	2945	107	\N
t	2946	107	\N
t	2947	102	\N
t	2948	102	\N
t	2949	107	\N
t	2950	107	\N
t	2951	4	\N
t	2952	301	\N
t	2953	102	\N
t	2954	102	\N
t	2955	102	\N
t	2956	4	\N
t	2957	4	\N
t	2958	1	\N
t	2959	108	\N
t	2960	108	\N
t	2961	107	\N
t	2962	107	\N
t	2963	102	\N
t	2964	107	\N
t	2965	107	\N
t	2966	102	\N
t	2967	301	\N
t	2968	102	\N
t	2969	107	\N
t	2970	301	\N
t	2971	102	\N
t	2972	107	\N
t	2973	4	\N
t	2975	4	\N
t	2976	4	\N
t	2977	4	\N
t	2979	4	\N
t	2980	4	\N
t	2981	108	60
t	2982	201	60
t	2983	201	60
t	2984	201	60
t	2985	201	60
t	2986	201	60
t	2987	201	60
t	2988	201	60
t	2990	102	\N
t	2991	102	\N
t	2992	107	\N
t	2993	107	\N
t	2994	102	\N
t	2995	102	\N
t	2996	102	\N
t	2997	1	\N
t	2998	102	\N
t	2999	102	\N
t	3000	102	\N
t	3001	108	\N
t	3002	4	\N
t	3004	108	\N
t	3005	108	\N
t	3007	102	\N
t	3008	102	\N
t	3009	107	\N
t	3010	107	\N
t	3011	102	\N
t	3012	107	\N
t	3013	107	\N
t	3014	102	\N
t	3015	107	\N
t	3016	107	\N
t	3017	102	\N
t	3018	104	\N
t	3019	102	\N
t	3020	301	\N
t	3021	107	\N
t	3022	107	\N
t	3023	301	\N
t	3024	102	\N
t	3025	102	\N
t	3026	102	\N
t	3027	102	\N
t	3028	102	\N
t	3029	107	\N
t	3030	107	\N
t	3031	4	\N
t	3032	107	\N
t	3033	107	\N
t	3034	102	\N
t	3035	301	\N
t	3036	2	\N
t	3037	108	\N
t	3038	108	\N
t	3039	107	\N
t	3040	107	\N
t	3041	107	\N
t	3042	107	\N
t	3043	301	\N
t	3044	102	\N
t	3045	108	\N
t	3046	4	\N
t	3047	4	\N
t	3048	102	\N
t	3049	102	\N
t	3050	102	\N
t	3051	102	\N
t	3052	102	\N
t	3053	102	\N
t	3054	102	\N
t	3055	102	\N
t	3056	102	\N
t	3057	107	\N
t	3058	107	\N
t	3059	107	\N
t	3060	107	\N
t	3061	301	\N
t	3062	102	\N
t	3063	102	\N
t	3064	102	\N
t	3065	107	\N
t	3066	107	\N
t	3067	102	\N
t	3068	102	\N
t	3069	301	\N
t	3070	107	\N
t	3071	107	\N
t	3072	102	\N
t	3073	102	\N
t	3074	102	\N
t	3075	107	\N
t	3076	301	\N
t	3077	107	\N
t	3078	102	\N
t	3079	102	\N
t	3080	102	\N
t	3082	108	\N
t	3083	4	\N
t	3084	4	\N
t	3085	4	\N
t	3086	201	61
t	3087	108	61
t	3088	201	61
t	3089	201	61
t	3090	201	61
t	3091	201	61
t	3092	201	61
t	3093	201	61
t	3094	201	61
t	3097	102	\N
t	3098	108	\N
t	3099	108	\N
t	3100	108	\N
t	3101	108	\N
t	3102	4	\N
t	3103	107	\N
t	3104	107	\N
t	3105	102	\N
t	3106	102	\N
t	3107	1	\N
t	3108	107	\N
t	3109	107	\N
t	3110	102	\N
t	3111	301	\N
t	3112	102	\N
t	3113	102	\N
t	3114	102	\N
t	3115	102	\N
t	3116	102	\N
t	3117	107	\N
t	3118	107	\N
t	3119	107	\N
t	3120	107	\N
t	3121	102	\N
t	3122	301	\N
t	3123	102	\N
t	3124	102	\N
t	3125	108	\N
t	3126	108	\N
t	3127	102	\N
t	3128	102	\N
t	3129	104	\N
t	3130	104	\N
t	3131	102	\N
t	3132	102	\N
t	3133	4	\N
t	3134	107	\N
t	3135	107	\N
t	3136	107	\N
t	3137	107	\N
t	3138	104	\N
t	3139	102	\N
t	3140	102	\N
t	3141	102	\N
t	3142	107	\N
t	3143	107	\N
t	3144	301	\N
t	3145	102	\N
t	3146	102	\N
t	3147	301	\N
t	3148	107	\N
t	3149	107	\N
t	3150	102	\N
t	3151	102	\N
t	3152	107	\N
t	3153	107	\N
t	3154	107	\N
t	3155	107	\N
t	3156	102	\N
t	3157	3	\N
t	3158	102	\N
t	3159	301	\N
t	3160	102	\N
t	3161	102	\N
t	3162	108	\N
t	3163	108	\N
t	3164	102	\N
t	3165	102	\N
t	3166	4	\N
t	3167	4	\N
t	3168	102	\N
t	3169	107	\N
t	3170	301	\N
t	3171	102	\N
t	3172	107	\N
t	3173	102	\N
t	3174	102	\N
t	3176	102	\N
t	3177	102	\N
t	3178	103	\N
t	3179	108	\N
t	3180	102	\N
t	3181	102	\N
t	3182	201	62
t	3183	201	62
t	3184	108	62
t	3185	201	62
t	3186	201	62
t	3187	201	62
t	3188	108	62
t	3189	201	62
t	3190	201	62
t	3192	108	\N
t	3193	108	\N
t	3194	4	\N
t	3195	4	\N
t	3196	4	\N
t	3198	102	\N
t	3199	102	\N
t	3201	4	\N
t	3202	107	\N
t	3203	107	\N
t	3204	102	\N
t	3205	102	\N
t	3206	102	\N
t	3207	107	\N
t	3208	107	\N
t	3209	301	\N
t	3210	102	\N
t	3211	102	\N
t	3212	102	\N
t	3213	108	\N
t	3214	201	\N
t	3215	102	\N
t	3216	102	\N
t	3217	102	\N
t	3218	107	\N
t	3219	107	\N
t	3220	102	\N
t	3221	102	\N
t	3222	107	\N
t	3223	107	\N
t	3224	301	\N
t	3225	102	\N
t	3226	102	\N
t	3227	102	\N
t	3228	102	\N
t	3229	4	\N
t	3230	4	\N
t	3231	107	\N
t	3232	107	\N
t	3233	102	\N
t	3234	102	\N
t	3235	102	\N
t	3236	107	\N
t	3237	107	\N
t	3238	301	\N
t	3239	102	\N
t	3240	102	\N
t	3241	102	\N
t	3242	102	\N
t	3243	102	\N
t	3244	107	\N
t	3245	107	\N
t	3246	102	\N
t	3247	4	\N
t	3250	102	\N
t	3251	102	\N
t	3252	102	\N
t	3253	102	\N
t	3254	102	\N
t	3255	102	\N
t	3256	102	\N
t	3257	102	\N
t	3258	102	\N
t	3259	4	\N
t	3260	4	\N
t	3261	108	\N
t	3262	4	\N
t	3263	4	\N
t	3264	4	\N
t	3265	201	63
t	3266	108	63
t	3267	201	63
t	3268	201	63
t	3269	201	63
t	3270	201	63
t	3271	201	63
t	3272	201	63
t	3273	201	63
t	3274	3	63
t	3275	201	63
t	3277	4	\N
t	3278	107	\N
t	3279	107	\N
t	3280	107	\N
t	3281	301	\N
t	3282	102	\N
t	3283	102	\N
t	3284	102	\N
t	3285	107	\N
t	3286	107	\N
t	3287	107	\N
t	3288	107	\N
t	3289	107	\N
t	3290	102	\N
t	3291	102	\N
t	3292	102	\N
t	3293	102	\N
t	3294	102	\N
t	3295	2	\N
t	3296	102	\N
t	3297	102	\N
t	3298	107	\N
t	3299	107	\N
t	3300	102	\N
t	3301	102	\N
t	3302	4	\N
t	3303	102	\N
t	3304	107	\N
t	3305	107	\N
t	3306	107	\N
t	3307	107	\N
t	3308	103	\N
t	3309	103	\N
t	3310	201	\N
t	3311	102	\N
t	3312	301	\N
t	3313	102	\N
t	3314	102	\N
t	3315	102	\N
t	3316	102	\N
t	3317	108	\N
t	3318	108	\N
t	3319	102	\N
t	3320	108	\N
t	3321	108	\N
t	3322	102	\N
t	3323	102	\N
t	3324	103	\N
t	3325	102	\N
t	3326	102	\N
t	3327	102	\N
t	3328	102	\N
t	3329	102	\N
t	3330	102	\N
t	3331	102	\N
t	3332	102	\N
t	3333	102	\N
t	3334	102	\N
t	3338	201	\N
t	3339	201	\N
t	3340	4	\N
t	3341	4	\N
t	3342	102	\N
t	3343	102	\N
t	3344	102	\N
t	3345	102	\N
t	3346	102	\N
t	3347	108	\N
t	3348	108	\N
t	3349	108	\N
t	3350	108	\N
t	3351	108	\N
t	3352	108	\N
t	3353	102	\N
t	3354	102	\N
t	3355	107	\N
t	3356	107	\N
t	3357	301	\N
t	3358	102	\N
t	3359	102	\N
t	3360	102	\N
t	3361	102	\N
t	3362	1	\N
t	3363	108	\N
t	3364	108	\N
t	3365	201	\N
t	3366	102	\N
t	3367	102	\N
t	3368	4	\N
t	3369	102	\N
t	3370	4	\N
t	3371	102	\N
t	3372	107	\N
t	3373	107	\N
t	3374	102	\N
t	3375	301	\N
t	3376	102	\N
t	3377	102	\N
t	3378	102	\N
t	3379	102	\N
t	3380	102	\N
t	3383	102	\N
t	3384	201	\N
t	3387	201	\N
t	3388	102	\N
t	3389	4	\N
t	3390	108	\N
t	3391	108	64
t	3392	201	64
t	3394	201	64
t	3395	201	64
t	3396	108	64
t	3397	201	64
t	3398	201	64
t	3399	201	64
t	3400	201	64
t	3401	201	64
t	3403	108	\N
t	3404	108	\N
t	3405	102	\N
t	3406	102	\N
t	3407	102	\N
t	3408	107	\N
t	3409	107	\N
t	3410	102	\N
t	3411	107	\N
t	3412	107	\N
t	3413	107	\N
t	3414	107	\N
t	3415	104	\N
t	3416	102	\N
t	3417	108	\N
t	3418	108	\N
t	3419	301	\N
t	3420	102	\N
t	3421	102	\N
t	3422	102	\N
t	3423	4	\N
t	3424	2	\N
t	3425	2	\N
t	3426	102	\N
t	3427	107	\N
t	3428	107	\N
t	3429	102	\N
t	3430	201	\N
t	3431	108	\N
t	3433	108	\N
t	3434	108	\N
t	3435	103	\N
t	3436	4	\N
t	3437	4	\N
t	3438	108	\N
t	3439	108	\N
t	3440	108	\N
t	3441	108	\N
t	3442	4	\N
t	3443	107	\N
t	3444	107	\N
t	3445	102	\N
t	3446	102	\N
t	3447	102	\N
t	3448	103	\N
t	3449	102	\N
t	3450	107	\N
t	3451	102	\N
t	3452	4	\N
t	3453	102	\N
t	3454	4	\N
t	3455	102	\N
t	3456	102	\N
t	3457	107	\N
t	3458	107	\N
t	3459	102	\N
t	3393	3	64
t	3460	301	\N
t	3461	102	\N
t	3462	107	\N
t	3463	107	\N
t	3464	102	\N
t	3465	201	\N
t	3466	107	\N
t	3467	107	\N
t	3468	102	\N
t	3469	108	\N
t	3470	108	\N
t	3471	2	\N
t	3472	102	\N
t	3473	107	\N
t	3474	107	\N
t	3475	107	\N
t	3476	107	\N
t	3477	301	\N
t	3478	201	\N
t	3479	201	\N
t	3480	102	\N
t	3481	4	\N
t	3482	102	\N
t	3483	102	\N
t	3484	102	\N
t	3485	102	\N
t	3486	102	\N
t	3487	102	\N
t	3488	4	\N
t	3490	102	\N
t	3491	103	\N
t	3492	201	\N
t	3493	108	\N
t	3495	4	\N
t	3496	4	\N
t	3497	4	\N
t	3498	102	\N
t	3499	301	\N
t	3500	102	\N
t	3501	102	\N
t	3502	103	\N
t	3503	301	\N
t	3504	301	\N
t	3505	103	\N
t	3506	102	\N
t	3507	3	\N
t	3508	102	\N
t	3509	102	\N
t	3510	102	\N
t	3511	102	\N
t	3512	4	\N
t	3513	102	\N
t	3514	102	\N
t	3515	102	\N
t	3516	102	\N
t	3517	103	\N
t	3518	102	\N
t	3519	102	\N
t	3520	102	\N
t	3521	108	\N
t	3522	102	\N
t	3523	102	\N
t	3524	108	\N
t	3525	108	\N
t	3526	102	\N
t	3527	102	\N
t	3528	301	\N
t	3529	102	\N
t	3530	102	\N
t	3531	102	\N
t	3532	102	\N
t	3533	102	\N
t	3534	102	\N
t	3535	102	\N
t	3536	102	\N
t	3537	1	\N
t	3538	301	\N
t	3539	102	\N
t	3540	102	\N
t	3541	102	\N
t	3542	102	\N
t	3543	4	\N
t	3544	301	\N
t	3545	102	\N
t	3546	4	\N
t	3547	108	\N
t	3548	103	\N
t	3549	102	\N
t	3550	4	\N
t	3551	102	\N
t	3552	102	\N
t	3553	102	\N
t	3554	102	\N
t	3555	102	\N
t	3556	103	\N
t	3557	102	\N
t	3558	102	\N
t	3559	2	\N
t	3560	102	\N
t	3561	102	\N
t	3562	102	\N
t	3563	108	\N
t	3564	102	\N
t	3565	102	\N
t	3566	102	\N
t	3567	102	\N
t	3568	301	\N
t	3569	301	\N
t	3570	102	\N
t	3571	103	\N
t	3572	301	\N
t	3573	102	\N
t	3574	102	\N
t	3575	102	\N
t	3576	102	\N
t	3577	102	\N
t	3578	102	\N
t	3579	102	\N
t	3580	102	\N
t	3581	102	\N
t	3582	4	\N
t	3584	201	65
t	3585	201	65
t	3587	108	65
t	3588	201	65
t	3589	201	65
t	3590	201	65
t	3591	103	65
t	3592	103	65
t	3593	201	65
t	3594	201	65
t	3595	201	65
t	3596	107	65
t	3597	102	65
t	3598	107	65
t	3599	107	65
t	3600	201	65
t	3601	103	65
t	3603	102	\N
t	3605	108	\N
t	3606	102	\N
t	3609	201	66
t	3610	201	66
t	3612	103	66
t	3613	108	66
t	3614	107	66
t	3615	102	66
t	3616	107	66
t	3586	3	65
t	3611	3	66
t	3617	103	66
t	3618	102	66
t	3619	107	66
t	3620	201	66
t	3621	201	66
t	3622	102	66
t	3623	107	66
t	3624	301	66
t	3625	201	66
t	3626	201	66
t	3627	107	66
t	3628	201	66
t	3629	107	66
t	3630	201	66
t	3631	301	66
t	3632	201	66
t	3633	201	66
t	3634	107	66
t	3635	201	66
t	3636	107	66
t	3637	201	66
t	3638	107	66
t	3643	108	\N
t	3644	102	\N
t	3645	108	\N
t	3646	4	\N
t	3647	108	\N
t	3648	4	\N
t	3649	4	\N
t	3651	102	\N
t	3652	102	\N
t	3653	102	\N
t	3654	108	\N
t	3655	102	\N
t	3656	107	\N
t	3657	107	\N
t	3658	107	\N
t	3659	107	\N
t	3660	102	\N
t	3661	108	\N
t	3662	102	\N
t	3663	301	\N
t	3664	107	\N
t	3665	107	\N
t	3666	102	\N
t	3667	4	\N
t	3668	102	\N
t	3669	108	\N
t	3670	108	\N
t	3671	102	\N
t	3672	102	\N
t	3673	102	\N
t	3674	107	\N
t	3675	107	\N
t	3676	102	\N
t	3677	102	\N
t	3678	4	\N
t	3679	102	\N
t	3680	107	\N
t	3681	107	\N
t	3682	102	\N
t	3683	301	\N
t	3684	107	\N
t	3685	107	\N
t	3686	102	\N
t	3687	102	\N
t	3688	102	\N
t	3689	102	\N
t	3690	102	\N
t	3691	102	\N
t	3692	108	\N
t	3693	108	\N
t	3694	102	\N
t	3695	107	\N
t	3696	107	\N
t	3697	102	\N
t	3698	301	\N
t	3699	301	\N
t	3700	102	\N
t	3701	102	\N
t	3702	102	\N
t	3703	102	\N
t	3704	4	\N
t	3705	107	\N
t	3706	107	\N
t	3707	3	\N
t	3708	102	\N
t	3709	102	\N
t	3710	108	\N
t	3711	108	\N
t	3712	102	\N
t	3713	201	\N
t	3714	107	\N
t	3715	107	\N
t	3716	102	\N
t	3717	102	\N
t	3718	108	\N
t	3719	108	\N
t	3720	301	\N
t	3721	107	\N
t	3722	107	\N
t	3723	107	\N
t	3724	102	\N
t	3725	102	\N
t	3726	301	\N
t	3727	102	\N
t	3728	102	\N
t	3729	102	\N
t	3730	102	\N
t	3731	4	\N
t	3736	1	\N
t	3737	102	\N
t	3738	102	\N
t	3739	102	\N
t	3740	102	\N
t	3741	102	\N
t	3742	3	\N
t	3743	107	\N
t	3744	107	\N
t	3745	107	\N
t	3746	107	\N
t	3747	301	\N
t	3748	102	\N
t	3749	102	\N
t	3750	4	\N
t	3751	108	\N
t	3752	108	\N
t	3753	102	\N
t	3754	107	\N
t	3755	107	\N
t	3756	102	\N
t	3757	107	\N
t	3758	107	\N
t	3759	102	\N
t	3760	102	\N
t	3761	102	\N
t	3762	102	\N
t	3763	107	\N
t	3764	107	\N
t	3765	301	\N
t	3766	102	\N
t	3767	102	\N
t	3768	107	\N
t	3769	107	\N
t	3770	201	\N
t	3771	102	\N
t	3772	102	\N
t	3773	102	\N
t	3774	107	\N
t	3775	107	\N
t	3776	102	\N
t	3777	4	\N
t	3778	107	\N
t	3779	107	\N
t	3780	102	\N
t	3781	301	\N
t	3782	102	\N
t	3783	102	\N
t	3784	102	\N
t	3785	4	\N
t	3786	108	\N
t	3787	108	\N
t	3788	107	\N
t	3789	107	\N
t	3790	102	\N
t	3791	102	\N
t	3792	107	\N
t	3793	107	\N
t	3794	102	\N
t	3795	102	\N
t	3796	102	\N
t	3797	108	\N
t	3798	108	\N
t	3799	107	\N
t	3800	107	\N
t	3801	102	\N
t	3802	301	\N
t	3803	102	\N
t	3804	107	\N
t	3805	107	\N
t	3806	102	\N
t	3807	102	\N
t	3808	4	\N
t	3809	102	\N
t	3810	102	\N
t	3811	102	\N
t	3812	102	\N
t	3813	102	\N
t	3814	107	\N
t	3815	107	\N
t	3816	102	\N
t	3817	102	\N
t	3819	102	\N
t	3820	102	\N
t	3821	102	\N
t	3822	102	\N
t	3823	102	\N
t	3824	107	\N
t	3825	107	\N
t	3826	102	\N
t	3827	301	\N
t	3828	102	\N
t	3829	102	\N
t	3830	102	\N
t	3831	102	\N
t	3832	107	\N
t	3833	102	\N
t	3834	102	\N
t	3835	102	\N
t	3836	4	\N
t	3837	107	\N
t	3838	107	\N
t	3839	102	\N
t	3840	102	\N
t	3841	107	\N
t	3842	107	\N
t	3843	102	\N
t	3844	3	\N
t	3845	102	\N
t	3846	201	\N
t	3847	107	\N
t	3848	107	\N
t	3849	301	\N
t	3850	102	\N
t	3851	102	\N
t	3852	102	\N
t	3853	107	\N
t	3854	107	\N
t	3855	102	\N
t	3856	301	\N
t	3857	107	\N
t	3858	107	\N
t	3859	102	\N
t	3860	4	\N
t	3861	107	\N
t	3862	107	\N
t	3863	301	\N
t	3864	102	\N
t	3865	102	\N
t	3866	102	\N
t	3867	102	\N
t	3868	102	\N
t	3869	108	\N
t	3870	108	\N
t	3871	102	\N
t	3872	102	\N
t	3873	102	\N
t	3874	108	\N
t	3875	108	\N
t	3876	102	\N
t	3877	1	\N
t	3878	4	\N
t	3879	102	\N
t	3880	102	\N
t	3881	102	\N
t	3882	301	\N
t	3883	102	\N
t	3884	102	\N
t	3885	102	\N
t	3886	1	\N
t	3887	102	\N
t	3888	102	\N
t	3891	102	\N
t	3892	102	\N
t	3893	102	\N
t	3894	201	\N
t	3895	107	\N
t	3896	107	\N
t	3897	102	\N
t	3898	102	\N
t	3899	107	\N
t	3900	107	\N
t	3901	102	\N
t	3902	4	\N
t	3903	107	\N
t	3904	107	\N
t	3905	107	\N
t	3906	107	\N
t	3907	102	\N
t	3908	102	\N
t	3909	301	\N
t	3910	108	\N
t	3911	107	\N
t	3912	107	\N
t	3913	102	\N
t	3914	102	\N
t	3915	102	\N
t	3916	107	\N
t	3917	107	\N
t	3918	102	\N
t	3919	102	\N
t	3920	102	\N
t	3921	201	\N
t	3922	107	\N
t	3923	107	\N
t	3924	102	\N
t	3925	102	\N
t	3926	107	\N
t	3927	107	\N
t	3928	102	\N
t	3929	3	\N
t	3930	107	\N
t	3931	107	\N
t	3932	102	\N
t	3933	102	\N
t	3934	102	\N
t	3935	102	\N
t	3936	301	\N
t	3937	102	\N
t	3938	102	\N
t	3939	4	\N
t	3940	107	\N
t	3941	107	\N
t	3942	102	\N
t	3943	102	\N
t	3944	1	\N
t	3945	102	\N
t	3946	108	\N
t	3947	108	\N
t	3948	107	\N
t	3949	107	\N
t	3950	107	\N
t	3951	107	\N
t	3952	301	\N
t	3953	102	\N
t	3954	102	\N
t	3955	102	\N
t	3956	4	\N
t	3957	4	\N
t	3958	102	\N
t	3959	108	\N
t	3960	108	\N
t	3961	107	\N
t	3962	102	\N
t	3963	102	\N
t	3964	102	\N
t	3965	103	\N
t	3966	102	\N
t	3967	102	\N
t	3968	301	\N
t	3969	107	\N
t	3970	201	\N
t	3971	102	\N
t	3972	108	\N
t	3973	108	\N
t	3974	107	\N
t	3975	201	\N
t	3976	201	\N
t	3977	201	\N
t	3978	107	\N
t	3979	108	\N
t	3980	107	\N
t	3981	107	\N
t	3982	3	67
t	3983	201	67
t	3984	3	67
t	3985	103	67
t	3986	201	67
t	3987	107	67
t	3988	107	67
t	3989	107	67
t	3990	201	67
t	3991	201	67
t	3992	107	67
t	3993	201	67
t	3994	201	67
t	3995	201	67
t	3996	201	67
t	3999	107	67
t	4000	107	67
t	4001	201	67
t	3997	201	67
t	3998	108	67
t	4002	108	\N
t	4003	4	\N
t	4004	4	\N
t	4005	4	\N
t	4006	4	\N
t	4007	108	\N
t	4008	4	\N
t	4009	4	\N
t	4010	4	\N
t	4011	4	\N
t	4012	108	\N
t	4013	4	\N
t	4014	2	\N
t	4015	4	\N
t	4016	4	\N
t	4017	4	\N
t	4019	3	69
t	4020	201	69
t	4021	3	69
t	4022	103	69
t	4023	201	69
t	4024	201	69
t	4025	201	69
t	4026	108	69
t	4027	201	69
t	4028	201	69
t	4029	201	69
t	4030	201	69
t	4031	201	69
t	4033	3	70
t	4034	201	70
t	4035	103	70
t	4036	201	70
t	4037	108	70
t	4038	201	70
t	4039	201	70
t	4040	201	70
t	4041	201	70
t	4042	201	70
t	4043	201	70
t	4044	201	70
t	4047	201	71
t	4048	201	71
t	4049	108	71
t	4050	201	71
t	4051	201	71
t	4052	201	71
t	4053	201	71
t	4054	201	71
t	4055	201	71
t	4056	201	71
t	4057	102	\N
t	4058	107	\N
t	4059	107	\N
t	4060	301	\N
t	4061	102	\N
t	4062	102	\N
t	4063	102	\N
t	4064	107	\N
t	4065	107	\N
t	4066	102	\N
t	4067	4	\N
t	4068	102	\N
t	4069	102	\N
t	4070	102	\N
t	4071	107	\N
t	4072	102	\N
t	4073	102	\N
t	4074	107	\N
t	4075	102	\N
t	4076	102	\N
t	4077	102	\N
t	4078	107	\N
t	4079	107	\N
t	4080	107	\N
t	4081	107	\N
t	4082	107	\N
t	4083	102	\N
t	4084	104	\N
t	4085	301	\N
t	4086	102	\N
t	4087	102	\N
t	4088	102	\N
t	4089	102	\N
t	4090	4	\N
t	4091	2	\N
t	4092	107	\N
t	4093	107	\N
t	4094	102	\N
t	4095	107	\N
t	4096	107	\N
t	4097	102	\N
t	4098	102	\N
t	4099	102	\N
t	4100	102	\N
t	4101	107	\N
t	4102	107	\N
t	4103	102	\N
t	4104	107	\N
t	4105	107	\N
t	4106	102	\N
t	4107	301	\N
t	4108	102	\N
t	4109	102	\N
t	4110	102	\N
t	4111	1	\N
t	4112	102	\N
t	4113	102	\N
t	4114	102	\N
t	4115	4	\N
t	4116	102	\N
t	4117	107	\N
t	4118	107	\N
t	4119	102	\N
t	4120	102	\N
t	4121	107	\N
t	4122	107	\N
t	4123	107	\N
t	4124	107	\N
t	4125	102	\N
t	4126	301	\N
t	4127	102	\N
t	4128	4	\N
t	4129	108	\N
t	4130	108	\N
t	4131	102	\N
t	4132	107	\N
t	4133	107	\N
t	4134	102	\N
t	4135	102	\N
t	4136	102	\N
t	4137	108	\N
t	4138	108	\N
t	4139	107	\N
t	4140	107	\N
t	4141	102	\N
t	4142	102	\N
t	4143	301	\N
t	4144	102	\N
t	4145	102	\N
t	4146	4	\N
t	4147	102	\N
t	4148	103	\N
t	4149	107	\N
t	4150	107	\N
t	4151	107	\N
t	4152	102	\N
t	4153	107	\N
t	4154	107	\N
t	4155	102	\N
t	4156	102	\N
t	4157	107	\N
t	4158	301	\N
t	4159	102	\N
t	4160	107	\N
t	4162	201	72
t	4163	201	72
t	4164	108	72
t	4165	201	72
t	4166	201	72
t	4168	201	72
t	4169	201	72
t	4167	201	72
t	4170	108	72
t	4171	201	72
t	4263	102	\N
t	4174	108	\N
t	4175	4	\N
t	4176	4	\N
t	4177	4	\N
t	4178	4	\N
t	4179	4	\N
t	4180	201	\N
t	4181	102	\N
t	4182	103	\N
t	4183	201	\N
t	4184	103	\N
t	4185	102	\N
t	4186	102	\N
t	4187	102	\N
t	4188	102	\N
t	4189	102	\N
t	4190	102	\N
t	4192	108	\N
t	4193	4	\N
t	4194	107	\N
t	4195	107	\N
t	4196	102	\N
t	4197	301	\N
t	4198	108	\N
t	4199	108	\N
t	4200	102	\N
t	4201	107	\N
t	4202	107	\N
t	4203	108	\N
t	4204	107	\N
t	4205	107	\N
t	4206	107	\N
t	4207	107	\N
t	4208	108	\N
t	4209	108	\N
t	4210	1	\N
t	4213	102	\N
t	4214	102	\N
t	4215	102	\N
t	4216	102	\N
t	4217	102	\N
t	4218	102	\N
t	4219	102	\N
t	4220	102	\N
t	4221	102	\N
t	4222	102	\N
t	4223	102	\N
t	4225	2	\N
t	4226	107	\N
t	4227	107	\N
t	4228	102	\N
t	4229	102	\N
t	4230	108	\N
t	4231	108	\N
t	4232	102	\N
t	4233	102	\N
t	4234	102	\N
t	4235	2	\N
t	4236	102	\N
t	4237	107	\N
t	4238	107	\N
t	4239	107	\N
t	4240	107	\N
t	4241	104	\N
t	4242	102	\N
t	4243	301	\N
t	4244	102	\N
t	4245	102	\N
t	4246	107	\N
t	4247	107	\N
t	4248	102	\N
t	4249	107	\N
t	4250	107	\N
t	4251	301	\N
t	4252	102	\N
t	4253	104	\N
t	4254	104	\N
t	4255	107	\N
t	4256	107	\N
t	4257	107	\N
t	4258	102	\N
t	4259	107	\N
t	4260	107	\N
t	4261	4	\N
t	4262	102	\N
t	4264	201	\N
t	4265	201	\N
t	4266	102	\N
t	4267	102	\N
t	4268	102	\N
t	4269	102	\N
t	4270	107	\N
t	4271	107	\N
t	4272	102	\N
t	4273	102	\N
t	4274	2	\N
t	4275	107	\N
t	4276	107	\N
t	4277	102	\N
t	4278	102	\N
t	4279	108	\N
t	4280	108	\N
t	4281	108	\N
t	4282	108	\N
t	4283	108	\N
t	4284	108	\N
t	4285	107	\N
t	4286	107	\N
t	4287	102	\N
t	4288	102	\N
t	4289	301	\N
t	4290	102	\N
t	4291	102	\N
t	4292	102	\N
t	4293	1	\N
t	4294	102	\N
t	4295	102	\N
t	4296	102	\N
t	4297	102	\N
t	4298	102	\N
t	4299	102	\N
t	4300	102	\N
t	4301	107	\N
t	4302	107	\N
t	4303	107	\N
t	4304	107	\N
t	4305	102	\N
t	4306	102	\N
t	4307	301	\N
t	4308	102	\N
t	4309	301	\N
t	4310	102	\N
t	4311	102	\N
t	4312	102	\N
t	4313	4	\N
t	4314	102	\N
t	4316	4	\N
t	4317	4	\N
t	4318	4	\N
t	4319	108	\N
t	4320	108	\N
t	4322	108	\N
t	4323	201	76
t	4324	201	76
t	4325	108	76
t	4329	201	76
t	4330	201	76
t	4332	201	76
t	4333	201	76
t	4334	201	76
t	4335	201	76
t	4328	201	76
t	4331	108	76
t	4336	4	\N
t	4337	4	\N
t	4343	201	76
t	4344	201	76
t	4350	108	76
t	4351	201	76
t	4355	107	\N
t	4356	107	\N
t	4357	102	\N
t	4358	102	\N
t	4359	102	\N
t	4360	102	\N
t	4361	4	\N
t	4362	107	\N
t	4363	107	\N
t	4364	107	\N
t	4365	107	\N
t	4366	301	\N
t	4367	102	\N
t	4368	102	\N
t	4369	102	\N
t	4370	107	\N
t	4371	107	\N
t	4372	102	\N
t	4373	102	\N
t	4374	104	\N
t	4375	107	\N
t	4376	107	\N
t	4377	102	\N
t	4378	107	\N
t	4379	107	\N
t	4380	102	\N
t	4381	102	\N
t	4382	102	\N
t	4383	103	\N
t	4384	102	\N
t	4385	107	\N
t	4386	107	\N
t	4387	107	\N
t	4388	107	\N
t	4389	102	\N
t	4390	102	\N
t	4391	301	\N
t	4392	102	\N
t	4393	102	\N
t	4394	102	\N
t	4395	102	\N
t	4396	102	\N
t	4397	108	\N
t	4398	108	\N
t	4399	201	\N
t	4400	102	\N
t	4401	102	\N
t	4402	4	\N
t	4403	108	\N
t	4404	107	\N
t	4405	107	\N
t	4406	102	\N
t	4407	102	\N
t	4408	108	\N
t	4409	102	\N
t	4410	108	\N
t	4411	108	\N
t	4412	107	\N
t	4413	107	\N
t	4414	107	\N
t	4415	107	\N
t	4416	301	\N
t	4417	102	\N
t	4418	108	\N
t	4419	102	\N
t	4420	102	\N
t	4421	102	\N
t	4422	102	\N
t	4423	102	\N
t	4424	102	\N
t	4425	108	\N
t	4426	108	\N
t	4427	108	\N
t	4428	102	\N
t	4429	102	\N
t	101	1	\N
t	113	401	\N
t	115	1	\N
t	103	302	\N
t	4430	201	\N
t	4431	201	\N
t	4432	201	\N
t	4433	201	\N
t	4434	4	\N
t	4435	4	\N
t	4437	102	\N
t	4438	107	\N
t	4439	107	\N
t	4440	102	\N
t	4441	102	\N
t	4442	201	\N
t	4443	102	\N
t	4444	1	\N
t	4445	102	\N
t	4446	107	\N
t	4447	107	\N
t	4448	107	\N
t	4449	107	\N
t	4450	102	\N
t	4451	102	\N
t	4452	301	\N
t	4453	102	\N
t	4454	102	\N
t	4455	102	\N
t	4456	102	\N
t	4457	102	\N
t	4458	102	\N
t	4470	201	79
t	4471	201	79
t	4472	108	79
t	4473	201	79
t	4474	201	79
t	4475	201	79
t	4476	201	79
t	4477	201	79
t	4478	201	79
t	4479	201	79
t	4480	201	79
t	4482	4	\N
t	4483	108	\N
t	4484	4	\N
t	4485	4	\N
t	4486	4	\N
t	4487	4	\N
t	4489	103	\N
t	4490	108	\N
t	4491	201	\N
t	4492	103	\N
t	4493	103	\N
t	4495	1	\N
t	4496	201	\N
t	4497	107	\N
t	4498	107	\N
t	4499	107	\N
t	4500	107	\N
t	4501	102	\N
t	4502	301	\N
t	4503	102	\N
t	4504	102	\N
t	4505	102	\N
t	4506	102	\N
t	4507	4	\N
t	4508	102	\N
t	4509	301	\N
t	4510	102	\N
t	4511	102	\N
t	4512	102	\N
t	4513	102	\N
t	4514	108	\N
t	4515	108	\N
t	4516	107	\N
t	4517	107	\N
t	4518	102	\N
t	4519	301	\N
t	4520	102	\N
t	4521	102	\N
t	4522	102	\N
t	4523	102	\N
t	4524	102	\N
t	4525	102	\N
t	4526	102	\N
t	4527	102	\N
t	4528	107	\N
t	4529	107	\N
t	4530	107	\N
t	4531	107	\N
t	4532	107	\N
t	4533	107	\N
t	4534	102	\N
t	4535	3	\N
t	4536	301	\N
t	4537	102	\N
t	4538	102	\N
t	4539	102	\N
t	4540	4	\N
t	4541	102	\N
t	4542	4	\N
t	4543	108	\N
t	4544	108	\N
t	4545	102	\N
t	4546	102	\N
t	4547	108	\N
t	4548	108	\N
t	4549	102	\N
t	4550	401	\N
t	4551	102	\N
t	4552	108	\N
t	4553	108	\N
t	4554	4	\N
t	4555	107	\N
t	4556	107	\N
t	4557	107	\N
t	4558	102	\N
t	4559	102	\N
t	4560	3	\N
t	4561	301	\N
t	4562	102	\N
t	4563	102	\N
t	4564	102	\N
t	4565	102	\N
t	4566	102	\N
t	4567	102	\N
t	4568	102	\N
t	4570	107	\N
t	4571	107	\N
t	4572	102	\N
t	4573	2	\N
t	4574	102	\N
t	4575	1	\N
t	4576	2	\N
t	4577	107	\N
t	4578	107	\N
t	4579	107	\N
t	4580	107	\N
t	4581	107	\N
t	4582	102	\N
t	4583	102	\N
t	4584	108	\N
t	4585	102	\N
t	4586	102	\N
t	4587	301	\N
t	4588	102	\N
t	4589	107	\N
t	4590	107	\N
t	4591	102	\N
t	4592	107	\N
t	4593	107	\N
t	4594	102	\N
t	4595	102	\N
t	4596	107	\N
t	4597	107	\N
t	4598	102	\N
t	4599	108	\N
t	4600	108	\N
t	4601	102	\N
t	4603	102	\N
t	4604	201	81
t	4605	201	81
t	4606	201	81
t	4607	108	81
t	4608	201	81
t	4609	201	81
t	4610	201	81
t	4611	201	81
t	4612	201	81
t	4613	107	\N
t	4614	107	\N
t	4615	301	\N
t	4616	102	\N
t	4617	108	\N
t	4618	201	\N
t	4619	401	\N
t	4620	102	\N
t	4621	102	\N
t	4622	102	\N
t	4623	108	\N
t	4624	108	\N
t	4625	102	\N
t	4627	108	\N
t	4628	108	\N
t	4629	4	\N
t	4631	4	\N
t	4633	4	\N
t	4634	108	\N
t	4635	401	\N
t	4636	2	\N
t	4637	103	\N
t	4638	102	\N
t	4639	102	\N
t	4640	107	\N
t	4641	107	\N
t	4642	107	\N
t	4643	102	\N
t	4644	102	\N
t	4645	107	\N
t	4646	107	\N
t	4647	107	\N
t	4648	107	\N
t	4649	107	\N
t	4650	301	\N
t	4651	102	\N
t	4652	102	\N
t	4653	102	\N
t	4654	102	\N
t	4655	102	\N
t	4656	102	\N
t	4657	2	\N
t	4658	107	\N
t	4659	107	\N
t	4660	102	\N
t	4661	107	\N
t	4662	107	\N
t	4663	102	\N
t	4664	102	\N
t	4665	107	\N
t	4666	107	\N
t	4667	102	\N
t	4668	102	\N
t	4669	301	\N
t	4670	107	\N
t	4671	107	\N
t	4672	102	\N
t	4673	102	\N
t	4674	4	\N
t	4675	107	\N
t	4676	107	\N
t	4677	102	\N
t	4678	102	\N
t	4679	2	\N
t	4680	107	\N
t	4681	107	\N
t	4682	102	\N
t	4683	102	\N
t	4684	107	\N
t	4685	107	\N
t	4686	102	\N
t	4687	301	\N
t	4688	102	\N
t	4689	102	\N
t	4690	102	\N
t	4691	201	\N
t	4692	102	\N
t	4693	2	\N
t	4694	107	\N
t	4695	107	\N
t	4696	102	\N
t	4697	201	\N
t	4698	102	\N
t	4699	102	\N
t	4700	4	\N
t	4701	102	\N
t	4702	107	\N
t	4703	301	\N
t	4704	107	\N
t	4705	102	\N
t	4706	102	\N
t	4707	107	\N
t	4708	102	\N
t	4709	107	\N
t	4710	107	\N
t	4711	107	\N
t	4712	102	\N
t	4713	108	\N
t	4714	4	\N
t	4715	4	\N
t	4716	4	\N
t	4717	4	\N
t	4719	108	\N
t	4720	201	\N
t	4721	4	\N
t	4722	201	82
t	4723	108	82
t	4724	108	82
t	4725	201	82
t	4726	3	82
t	4727	201	82
t	4728	201	82
t	4729	201	82
t	4730	201	82
t	4732	2	\N
t	4733	102	\N
t	4734	301	\N
t	4735	2	\N
t	4736	107	\N
t	4737	107	\N
t	4738	107	\N
t	4739	107	\N
t	4740	102	\N
t	4741	108	\N
t	4742	108	\N
t	4743	1	\N
t	4744	108	\N
t	4745	108	\N
t	4746	201	\N
t	4747	102	\N
t	4749	108	\N
t	4750	107	\N
t	4751	107	\N
t	4752	102	\N
t	4753	2	\N
t	4754	107	\N
t	4755	107	\N
t	4756	107	\N
t	4757	107	\N
t	4758	107	\N
t	4759	102	\N
t	4760	102	\N
t	4761	102	\N
t	4762	301	\N
t	4763	107	\N
t	4764	107	\N
t	4765	102	\N
t	4766	102	\N
t	4767	102	\N
t	4768	108	\N
t	4769	107	\N
t	4770	107	\N
t	4771	102	\N
t	4772	102	\N
t	4773	2	\N
t	4774	102	\N
t	4775	107	\N
t	4776	107	\N
t	4777	102	\N
t	4778	102	\N
t	4779	4	\N
t	4780	2	\N
t	4781	107	\N
t	4782	107	\N
t	4783	102	\N
t	4784	102	\N
t	4785	301	\N
t	4786	107	\N
t	4787	107	\N
t	4788	108	\N
t	4789	107	\N
t	4790	107	\N
t	4791	102	\N
t	4792	102	\N
t	4793	2	\N
t	4794	2	\N
t	4795	102	\N
t	4796	102	\N
t	4797	107	\N
t	4798	107	\N
t	4799	102	\N
t	4800	102	\N
t	4801	102	\N
t	4802	102	\N
t	4803	107	\N
t	4804	107	\N
t	4805	107	\N
t	4806	107	\N
t	4807	102	\N
t	4808	102	\N
t	4809	301	\N
t	4810	102	\N
t	4811	107	\N
t	4812	107	\N
t	4813	102	\N
t	4814	108	\N
t	4815	108	\N
t	4816	108	\N
t	4817	108	\N
t	4818	107	\N
t	4819	107	\N
t	4820	102	\N
t	4821	102	\N
t	4822	102	\N
t	4823	108	\N
t	4824	108	\N
t	4825	4	\N
t	4826	107	\N
t	4827	107	\N
t	4828	102	\N
t	4829	4	\N
t	4831	102	\N
t	4832	108	\N
t	4833	108	\N
t	4834	4	\N
t	4835	102	\N
t	4836	102	\N
t	4837	107	\N
t	4838	107	\N
t	4839	301	\N
t	4840	102	\N
t	4841	103	\N
t	4842	107	\N
t	4843	107	\N
t	4844	102	\N
t	4845	102	\N
t	4847	201	\N
t	4848	102	\N
t	4849	102	\N
t	4850	201	\N
t	4851	102	\N
t	4852	102	\N
t	4853	102	\N
t	4854	102	\N
t	4855	108	\N
t	4856	4	\N
t	4857	4	\N
t	4858	103	\N
t	4859	4	\N
t	4860	108	\N
t	4861	4	\N
t	4862	4	\N
t	4864	201	85
t	4865	201	85
t	4866	201	85
t	4867	4	85
t	4868	103	85
t	4869	201	85
t	4870	201	85
t	4871	201	85
t	4872	108	85
t	4863	108	85
t	4874	102	\N
t	4875	4	\N
t	4876	108	\N
t	4877	108	\N
t	4878	102	\N
t	4879	301	\N
t	4880	107	\N
t	4881	107	\N
t	4882	2	\N
t	4883	107	\N
t	4884	107	\N
t	4885	102	\N
t	4886	102	\N
t	4887	102	\N
t	4888	4	\N
t	4889	4	\N
t	4890	102	\N
t	4891	102	\N
t	4892	108	\N
t	4893	108	\N
t	4894	102	\N
t	4895	102	\N
t	4896	102	\N
t	4897	102	\N
t	4898	4	\N
t	4899	108	\N
t	4900	108	\N
t	4901	108	\N
t	4902	108	\N
t	4903	103	\N
t	4904	108	\N
t	4905	108	\N
t	4906	4	\N
t	4907	4	\N
t	4909	102	\N
t	4910	103	\N
t	4911	102	\N
t	4912	4	\N
t	4913	102	\N
t	4914	102	\N
t	4915	102	\N
t	4916	102	\N
t	4917	107	\N
t	4918	107	\N
t	4919	102	\N
t	4920	102	\N
t	4921	102	\N
t	4922	2	\N
t	4923	2	\N
t	4924	107	\N
t	4925	107	\N
t	4926	107	\N
t	4927	107	\N
t	4928	107	\N
t	4929	102	\N
t	4930	104	\N
t	4931	107	\N
t	4932	107	\N
t	4933	301	\N
t	4934	102	\N
t	4935	102	\N
t	4936	102	\N
t	4937	1	\N
t	4938	2	\N
t	4939	102	\N
t	4940	102	\N
t	4941	102	\N
t	4942	102	\N
t	4943	2	\N
t	4944	107	\N
t	4945	107	\N
t	4946	107	\N
t	4947	107	\N
t	4948	102	\N
t	4950	108	88
t	4951	201	88
t	4952	201	88
t	4953	201	88
t	4954	201	88
t	4955	201	88
t	4956	107	88
t	4957	201	88
t	4958	107	88
t	4959	107	88
t	4960	107	88
t	4961	201	88
t	4949	108	88
t	4963	4	\N
t	4964	102	\N
t	4965	102	\N
t	4966	107	\N
t	4967	103	\N
t	4968	107	\N
t	4969	102	\N
t	4970	107	\N
t	4971	107	\N
t	4972	3	\N
t	4973	301	\N
t	4974	107	\N
t	4975	102	\N
t	4976	401	\N
t	4977	107	\N
t	4978	103	\N
t	4979	107	\N
t	4980	102	\N
t	4981	103	\N
t	4982	107	\N
t	4983	102	\N
t	4984	102	\N
t	4985	102	\N
t	4986	102	\N
t	4987	103	\N
t	4988	102	\N
t	4989	108	\N
t	4990	4	\N
t	4991	103	\N
t	4992	103	\N
t	4993	103	\N
t	4994	102	\N
t	4995	102	\N
t	4996	108	\N
t	4997	108	\N
t	4998	102	\N
t	4999	108	\N
t	5000	107	\N
t	5001	301	\N
t	5002	102	\N
t	5003	108	\N
t	5004	108	\N
t	5005	201	\N
t	5006	102	\N
t	5007	102	\N
t	5008	301	\N
t	5009	3	\N
t	5010	107	\N
t	5011	102	\N
t	5012	102	\N
t	5013	301	\N
t	5014	102	\N
t	5015	102	\N
t	5016	102	\N
t	5017	102	\N
t	5018	102	\N
t	5019	102	\N
t	5020	102	\N
t	5021	102	\N
t	5022	2	\N
t	5023	102	\N
t	5024	108	\N
t	5025	102	\N
t	5026	301	\N
t	5027	102	\N
t	5028	301	\N
t	5029	102	\N
t	5030	102	\N
t	5031	108	\N
t	5032	102	\N
t	5033	103	\N
t	5034	102	\N
t	5035	4	\N
t	5036	4	\N
t	5037	3	\N
t	5038	301	\N
t	5039	102	\N
t	5040	102	\N
t	5041	4	\N
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
57	6	2023-04-11 00:00:00	2023-03-28 00:00:00	t
58	6	2023-05-11 00:00:00	2023-04-28 00:00:00	t
59	6	2023-06-11 00:00:00	2023-05-28 00:00:00	t
60	6	2023-07-11 00:00:00	2023-06-28 00:00:00	t
61	6	2023-08-11 00:00:00	2023-07-28 00:00:00	t
62	6	2023-09-11 00:00:00	2023-08-28 00:00:00	t
63	6	2023-10-11 00:00:00	2023-09-28 00:00:00	t
64	6	2023-11-11 00:00:00	2023-10-28 00:00:00	t
65	6	2023-12-11 00:00:00	2023-11-28 00:00:00	t
66	6	2024-01-11 00:00:00	2023-12-28 00:00:00	t
67	6	2024-02-11 00:00:00	2024-01-28 00:00:00	t
69	6	2024-03-11 00:00:00	2024-02-28 00:00:00	t
70	6	2024-04-11 00:00:00	2024-03-28 00:00:00	t
71	6	2024-05-11 00:00:00	2024-04-28 00:00:00	t
72	6	2024-06-11 00:00:00	2024-05-28 00:00:00	t
76	6	2024-07-11 00:00:00	2024-06-28 00:00:00	t
79	6	2024-08-11 00:00:00	2024-07-28 00:00:00	t
81	6	2024-09-11 00:00:00	2024-08-28 00:00:00	t
82	6	2024-10-11 00:00:00	2024-09-28 00:00:00	t
85	6	2024-11-11 00:00:00	2024-10-28 00:00:00	t
88	6	2024-12-11 00:00:00	2024-11-28 00:00:00	t
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
33	5	2024	1700.00
34	6	2024	1700.00
35	7	2024	1800.00
36	8	2024	2500.00
37	10	2024	2100.00
\.


--
-- Data for Name: movimentacao; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.movimentacao (id, descricao, pagamento, valor, vencimento, debitavel_id, moeda) FROM stdin;
30	LEV ATM 3613 DEU 22201292 Muenchen	2020-03-19	100.00	2020-03-10	3	EURO
31	DD NL08502057 STG MOLLIE PAYM MD17-0000-5033-27	2020-03-19	22.00	2020-03-04	3	EURO
32	DD NL08502057 STG MOLLIE PAYM MD66-0000-2516-37	2020-03-19	2.00	2020-03-04	3	EURO
33	DD NL08502057 STG MOLLIE PAYM MD71-0000-0406-26	2020-03-19	2.00	2020-03-04	3	EURO
35	LEV ATM 3613 DEU 22201637 Muenchen	2020-03-19	100.00	2020-03-03	3	EURO
37	Almoco	2020-03-19	5.90	2020-03-18	3	EURO
38	AMZN MKTP DE*2Z7NA2BY5	2020-03-19	75.65	2020-03-03	4	EURO
39	Vodafone GmbH CallYa	2020-03-19	50.00	2020-03-04	4	EURO
40	MVG AUTOMATEN	2020-03-19	88.90	2020-03-09	4	EURO
41	IC CASH 01011446	2020-03-19	90.00	2020-03-11	4	EURO
42	EDEKA M ERIKA MANN 880	2020-03-19	4.98	2020-03-12	4	EURO
43	IZ *SOEREN RABE	2020-03-19	10.00	2020-03-17	4	EURO
46	LEV ATM 3613 DEU 49001770 DB MUENCHEN D MUENCHE	2020-02-25	105.49	2020-02-25	3	EURO
49	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE FL 142	2020-02-14	100.00	2020-02-14	3	EURO
53	LEV ATM 3613 DEU 49001770 DB MUENCHEN D MUENCHE	2020-02-11	105.49	2020-02-11	3	EURO
56	EDEKA M ERIKA MANN 880	2020-02-04	7.67	2020-02-04	4	EURO
57	EDEKA M ERIKA MANN 880	2020-02-05	3.58	2020-02-05	4	EURO
58	Mollie *WeWash GmbH	2020-02-05	13.00	2020-02-05	4	EURO
59	Ind. Rest. Bollywood	2020-02-06	10.00	2020-02-06	4	EURO
60	body + soul group AG & Co. KG	2020-02-28	94.00	2020-02-28	4	EURO
62	IMPOSTO DO SELO	2020-01-29	0.72	2020-01-29	3	EURO
63	MMD DISPONIBILIZACAO CARTAO DEBITO  7869361	2020-01-29	18.00	2020-01-29	3	EURO
65	LEV ATM 3613 DEU IC CASH 01011446 MUENCHEN DE	2020-01-23	72.95	2020-01-23	3	EURO
71	LEV ATM 3613 DEU IC CASH 01011446 MUENCHEN DE	2020-01-10	102.95	2020-01-10	3	EURO
74	LEV ATM 3613 DEU REISEBANK FRANKFURT AT FRANKFU	2020-01-07	100.00	2020-01-07	3	EURO
76	Mollie *WeWash GmbH	2020-01-05	7.00	2020-01-05	4	EURO
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
101	LEV ATM 3613 DEU 22201637 Muenchen	2019-12-17	103.95	2019-12-17	3	EURO
77	KFC	2020-01-06	6.99	2020-01-06	4	EURO
78	KFC	2020-01-06	1.99	2020-01-06	4	EURO
107	LEV ATM 3613 DEU MUENCHEN MUENCHEN DE	2019-12-10	100.00	2019-12-10	3	EURO
108	LEV ATM 3613 DEU IC CASH 01011446 MUENCHEN DE	2019-12-06	72.95	2019-12-06	3	EURO
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
840	LEV ATM 3613 DEU 22201850 Muenchen	2021-04-30	100.00	2021-04-21	3	EURO
845	Eletropaulo	2021-04-30	167.26	2021-04-29	5	REAL
846	Vivo	2021-04-30	134.08	2021-04-15	5	REAL
849	EDEKA M ERIKA MANN 880	2021-04-30	7.35	2021-04-14	4	EURO
850	UBER   *TRIP	2021-04-30	11.04	2021-04-14	4	EURO
851	BAECKEREI ZIEGLER	2021-04-30	7.80	2021-04-15	4	EURO
853	BAECKEREI ZIEGLER	2021-04-30	2.80	2021-04-17	4	EURO
854	EDEKA M ERIKA MANN 880	2021-04-30	6.95	2021-04-19	4	EURO
855	EDEKA M ERIKA MANN 880	2021-04-30	6.39	2021-04-20	4	EURO
856	Mollie *WeWash GmbH	2021-04-30	22.00	2021-04-27	4	EURO
847	KFC	2021-04-30	7.99	2021-04-09	4	EURO
848	KFC	2021-04-30	9.49	2021-04-11	4	EURO
852	KFC	2021-04-30	7.79	2021-04-15	4	EURO
857	Academia	2021-05-01	94.00	2021-04-30	4	EURO
858	Almoço	2021-05-01	12.90	2021-05-01	4	EURO
859	We Wash	2021-05-01	2.00	2021-05-01	4	EURO
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
906	Salario	\N	3471.00	2021-06-28	3	EURO
916	IR Reembolso	2021-06-30	635.00	2021-06-29	3	EURO
917	Cobrir Conta	\N	200.00	2021-06-22	3	EURO
918	LEV ATM 3613 DEU 22201850 Muenchen	2021-06-30	100.00	2021-06-24	3	EURO
926	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLYEIN	2021-06-30	100.00	2021-06-17	3	EURO
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
958	LEV ATM 3613 DEU REISEBANK FRANKFURT AT MUENCHE	2021-09-04	104.90	2021-08-27	3	EURO
959	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLY-EIN	2021-09-04	100.00	2021-08-25	3	EURO
960	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	47.99	2021-08-24	3	EURO
962	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE OLY.EKZ	2021-09-04	100.00	2021-08-18	3	EURO
963	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-09-04	57.00	2021-08-17	3	EURO
964	KAMILIA PEREIRA MUENCHEN DE	2021-09-04	200.00	2021-08-17	3	EURO
966	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	31.24	2021-08-17	3	EURO
968	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	47.83	2021-08-10	3	EURO
969	SumUp Dr. Ebner Munchen DE	2021-09-04	76.53	2021-08-05	3	EURO
970	LEV ATM 3613 DEU 22201850 Muenchen	2021-09-04	100.00	2021-08-05	3	EURO
971	SumUp Dr. Ebner Munchen DE	2021-09-04	91.05	2021-08-03	3	EURO
972	EDEKA CENTER OEZ MUENCHEN DE	2021-09-04	38.33	2021-08-03	3	EURO
973	Saturn Electro Muenchen DE	2021-09-04	12.49	2021-08-03	3	EURO
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
993	SANI PLUS-APOTHEKE	2021-09-04	2.00	2021-07-13	4	EURO
994	UBER   *TRIP	2021-09-04	12.18	2021-07-14	4	EURO
996	EDEKA M ERIKA MANN 880	2021-09-04	7.05	2021-07-20	4	EURO
997	EDEKA M ERIKA MANN 880	2021-09-04	7.90	2021-07-21	4	EURO
998	EDEKA M ERIKA MANN 880	2021-09-04	6.95	2021-07-22	4	EURO
1001	BAECKEREI ZIEGLER	2021-09-04	6.55	2021-07-28	4	EURO
1002	EDEKA M ERIKA MANN 880	2021-09-04	8.80	2021-07-28	4	EURO
1004	body + soul group AG & Co. KG	2021-09-04	94.00	2021-07-30	4	EURO
1005	Mollie *WeWash GmbH	2021-09-04	17.00	2021-08-01	4	EURO
1006	EDEKA M ERIKA MANN 880	2021-09-04	6.95	2021-08-03	4	EURO
1010	Vodafone GmbH CallYa	2021-09-04	80.00	2021-08-19	4	EURO
1011	UBER *TRIP HELP.UBER.C	2021-09-04	10.12	2021-08-22	4	EURO
1012	UBER *TRIP HELP.UBER.C	2021-09-04	19.65	2021-08-22	4	EURO
1013	Mollie *WeWash GmbH	2021-09-04	20.00	2021-08-24	4	EURO
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
989	KFC	2021-09-04	9.29	2021-07-02	4	EURO
990	KFC	2021-09-04	9.29	2021-07-05	4	EURO
991	KFC	2021-09-04	9.29	2021-07-07	4	EURO
992	KFC	2021-09-04	9.29	2021-07-12	4	EURO
995	KFC	2021-09-04	9.29	2021-07-19	4	EURO
999	KFC	2021-09-04	9.29	2021-07-22	4	EURO
1000	KFC	2021-09-04	9.29	2021-07-27	4	EURO
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
1096	BAECKEREI ZIEGLER MUENC	2021-10-31	8.00	2021-10-13	3	EURO
1097	EDEKA M ERIKA MANN 880	2021-10-31	4.25	2021-10-13	3	EURO
1098	DMDrogerie Markt Muenc	2021-10-31	22.40	2021-10-12	3	EURO
1099	EDEKA CENTER OEZ MUENCHEN DE	2021-10-31	44.58	2021-10-12	3	EURO
1100	BAECKEREI ZIEGLER MUENC	2021-10-31	10.15	2021-10-08	3	EURO
1101	EDEKA M ERIKA MANN 880	2021-10-31	7.90	2021-10-08	3	EURO
1102	EDEKA M ERIKA MANN 880	2021-10-31	8.80	2021-10-07	3	EURO
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
1095	KFC  MUNCHEN DE	2021-10-31	9.29	2021-10-13	3	EURO
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
1169	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-11-30	17.80	2021-11-24	3	EURO
1170	LEV ATM 3613 DEU STADTSPARKASSE MUENCHE UNI.UB	2021-11-30	100.00	2021-11-24	3	EURO
1171	EDEKA CENTER OEZ MUENCHEN DE	2021-11-30	41.20	2021-11-23	3	EURO
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
1168	EDEKA M ERIKA MANN 880	2021-11-30	6.95	2021-11-25	3	EURO
1152	KFC  MUNCHEN DE	2021-11-11	9.49	2021-11-05	3	EURO
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
1674	KFC  MUNCHEN DE	2022-06-19	8.49	2022-05-25	3	EURO
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
1939	Vodafone.pt	2022-11-22	7.50	2022-09-13	3	EURO
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
1995	PINGO DOCE BRAGA BRAGA	2022-11-22	18.55	2022-10-26	3	EURO
1996	LA PORTA REST BRAGA	2022-11-22	24.00	2022-10-25	3	EURO
1998	FNAC BRAGA BRAGA PR	2022-11-22	19.90	2022-10-25	3	EURO
1999	Glovo 22OCT BRCXEBS3Y Lisbon PR	2022-11-22	8.89	2022-10-25	3	EURO
2000	Glovo 21OCT BR4WAUKQP Lisbon PR	2022-11-22	9.67	2022-10-25	3	EURO
2001	Glovo 21OCT BRYSKJX19 Lisbon PR	2022-11-22	9.03	2022-10-25	3	EURO
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
2021	VODAFONE PORTUGAL COMU	2022-11-22	3.61	2022-10-12	3	EURO
2022	Glovo 10OCT BRT12F7DF Lisbon PR	2022-11-22	9.03	2022-10-12	3	EURO
2023	LA PORTA REST BRAGA	2022-11-22	23.00	2022-10-11	3	EURO
2024	Glovo 08OCT BR1AU9P33 Lisbon PR	2022-11-22	29.98	2022-10-11	3	EURO
2025	IKEA BRAGA CAIXAS ECO BRAGA PR	2022-11-22	27.00	2022-10-11	3	EURO
2027	LA PORTA REST BRAGA	2022-11-22	24.00	2022-10-10	3	EURO
2028	Glovo 06OCT BRGVKKZMB Lisbon PR	2022-11-22	9.15	2022-10-07	3	EURO
2029	IMPOSTO DE SELO 17.3.4	2022-11-22	0.21	2022-10-10	3	EURO
2030	COM. MANUTENCAO CONTA ORDENADO 092022	2022-11-22	5.20	2022-10-10	3	EURO
2031	BK BRAGA ARCADA BRAGA	2022-11-22	9.99	2022-10-07	3	EURO
2032	ALGODAO E COMPANHIA 4700565 MIRE T	2022-11-22	38.25	2022-10-06	3	EURO
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
1994	NOS CINEMAS BRAGA PQ BR	2022-11-22	6.75	2022-10-26	3	EURO
1997	PRIMARK BRAGE PARQUE B	2022-11-22	14.60	2022-10-25	3	EURO
2026	WOK TO WALK N ARCADANIF	2022-11-22	12.80	2022-10-10	3	EURO
2020	Vodafone.pt	2022-11-22	15.00	2022-10-13	3	EURO
2033	Vodafone.pt	2022-11-22	7.50	2022-10-05	3	EURO
2002	Vodafone.pt	2022-11-22	15.00	2022-10-25	3	EURO
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
2663	Cobrir Conta para o Carro	\N	1000.00	2023-04-03	3	EURO
2664	BRAGA RIO LOJA 306 BRAG	2023-04-05	13.40	2023-04-05	3	EURO
2665	UBR PENDING.UBER.COM	2023-04-05	4.48	2023-04-05	3	EURO
2666	UBR PENDING.UBER.COM	2023-04-05	5.16	2023-04-05	3	EURO
2667	UBR PENDING.UBER.COM	2023-04-05	5.86	2023-04-04	3	EURO
2668	UBR PENDING.UBER.COM	2023-04-05	6.35	2023-04-04	3	EURO
2669	Glovo 01APR BR2LPUX71	2023-04-05	9.80	2023-04-04	3	EURO
2670	Glovo 01APR BRWMAFVTH	2023-04-05	13.00	2023-04-04	3	EURO
2671	Glovo 31MAR BRYCN1S1M	2023-04-05	10.10	2023-04-04	3	EURO
2672	Glovo 31MAR BRLDPR6HN	2023-04-05	9.90	2023-04-04	3	EURO
2673	Comissao Transferencia a credito SEPA+ Em Linha	2023-04-05	1.10	2023-04-03	3	EURO
2674	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20230640259	2023-04-05	0.04	2023-04-03	3	EURO
2675	CONTINENTE BRAGA BRAGA	2023-04-05	77.71	2023-04-03	3	EURO
2676	Glovo 30MAR BRMQTMZQB	2023-04-05	9.25	2023-03-31	3	EURO
2677	Glovo 29MAR BRQ17Q61G	2023-04-05	9.90	2023-03-31	3	EURO
2678	Glovo 28MAR BRPWLF1CL	2023-04-05	15.00	2023-03-30	3	EURO
2679	Glovo 28MAR BRGL1CFNW	2023-04-05	9.90	2023-03-30	3	EURO
2680	LA PORTA REST BRAGA PR	2023-04-05	25.00	2023-03-29	3	EURO
2681	UBR PENDING.UBER.COM	2023-04-05	3.50	2023-03-29	3	EURO
2682	LA PORTA REST BRAGA PR	2023-04-05	25.00	2023-03-28	3	EURO
2683	UBR PENDING.UBER.COM	2023-04-05	4.43	2023-03-28	3	EURO
2684	UBR PENDING.UBER.COM	2023-04-05	4.77	2023-03-28	3	EURO
2685	UBR PENDING.UBER.COM	2023-04-05	3.50	2023-03-28	3	EURO
2686	BRASA RIO BRAGA PR	2023-04-05	13.40	2023-03-28	3	EURO
2687	ARCADIA BRAGA PARQUE BR	2023-04-05	4.80	2023-03-28	3	EURO
2688	GLOVO24MAR BRDNELJDK none	2023-04-05	10.40	2023-03-28	3	EURO
2689	UBR PENDING.UBER.COM	2023-04-05	7.17	2023-03-27	3	EURO
2690	UBR PENDING.UBER.COM	2023-04-05	6.71	2023-03-27	3	EURO
2691	Glovo 23MAR BRBC1Z1MP	2023-04-05	9.90	2023-03-27	3	EURO
2693	Glovo1	2023-04-05	12.53	2023-04-05	3	EURO
2694	Glovo2	2023-04-05	9.90	2023-04-04	3	EURO
2696	AmazonPrimeBR	2023-04-05	2.72	2023-04-03	4	EURO
2697	Glovo1	2023-04-05	5.99	2023-04-03	4	EURO
2698	Glovo2	2023-04-05	15.00	2023-03-30	4	EURO
2699	Glovo3	2023-04-05	9.98	2023-03-29	4	EURO
2700	tar pacote itau	2023-04-05	71.90	2023-04-04	5	REAL
2703	AmazonPrimeBR	2023-04-05	14.90	2023-03-03	6	REAL
2704	Amazon Kindle Unltd	2023-04-05	19.90	2023-03-03	6	REAL
2705	DM *HELPHBOMAXCOM	2023-04-05	27.90	2023-03-04	6	REAL
2706	Disney Plus	2023-04-05	27.90	2023-03-06	6	REAL
2707	NETFLIX.COM	2023-04-05	39.90	2023-03-11	6	REAL
2708	ANUIDADE DIFERENCIADA 04/12	2023-04-05	30.00	2023-03-02	6	REAL
2709	APPLE.COM/BILL	2023-04-05	14.90	2023-03-20	6	REAL
2710	EBN*SPOTIFY	2023-04-05	19.90	2023-03-28	6	REAL
2711	Pagamento fatura 04/2023	2023-04-10	195.30	2023-04-10	5	REAL
2712	Condominio	2023-04-10	664.00	2023-04-10	5	REAL
2713	Avis	2023-04-10	698.74	2023-04-06	4	EURO
2714	Saque	2023-04-10	50.00	2023-04-06	4	EURO
2715	IKEA BRAGA CAIXAS ECO BRAGA PR	2023-04-11	55.00	2023-04-11	3	EURO
2716	TOMATINO NOVA ARCADA BR	2023-04-11	8.50	2023-04-11	3	EURO
2717	ARCADIA BRAGA PARQUE BR	2023-04-11	6.20	2023-04-11	3	EURO
2718	EDP COMERCIALCOMERCIA	2023-04-11	121.12	2023-04-10	3	EURO
2701	Salario	\N	4200.00	2023-04-30	3	EURO
2719	LA PORTA REST BRAGA 1	2023-04-11	33.00	2023-04-10	3	EURO
2720	LA PORTA REST BRAGA 2	2023-04-11	25.00	2023-04-10	3	EURO
2721	CONTINENTE BRAGA BRAGA	2023-04-11	28.59	2023-04-10	3	EURO
2722	Glovo	2023-04-11	13.30	2023-04-11	3	EURO
2724	Almoco	2023-04-11	13.40	2023-04-10	3	EURO
2725	Sorverte	2023-04-11	5.40	2023-04-10	3	EURO
2794	CONTINENTE BRAGA BRAGA	2023-05-06	48.19	2023-05-02	3	EURO
2795	LA ROTISSERIE BRAGA	2023-05-06	11.70	2023-05-02	3	EURO
2723	Glovo 12	2023-04-11	8.90	2023-04-11	3	EURO
2726	GLOVO24APR BR5GTAKL5 none	2023-04-27	9.45	2023-04-26	3	EURO
2731	CONTINENTE BRAGA BRAGA	2023-04-27	35.60	2023-04-25	3	EURO
2732	JEAN LOUIS DAVID BRAGA	2023-04-27	17.50	2023-04-25	3	EURO
2733	Glovo 22APR BRCVMDVME	2023-04-27	16.50	2023-04-25	3	EURO
2734	Glovo 22APR BRD8ZJE7X	2023-04-27	13.00	2023-04-25	3	EURO
2735	Glovo 21APR BRYLJQ11R	2023-04-27	9.25	2023-04-25	3	EURO
2736	GLOVO21APR BRKAPVW4H none	2023-04-27	9.45	2023-04-25	3	EURO
2737	LA ROTISSERIE BRAGA	2023-04-27	11.70	2023-04-24	3	EURO
2738	Glovo 20APR BR2MBEF8J	2023-04-27	9.40	2023-04-21	3	EURO
2739	Glovo 20APR BRL7HQ1PE	2023-04-27	10.40	2023-04-21	3	EURO
2740	Glovo 18APR BRCTJNXFF	2023-04-27	11.20	2023-04-20	3	EURO
2741	VODAFONE PORTUGAL COMU	2023-04-27	59.10	2023-04-19	3	EURO
2742	AGEREEMP.DE AGUAS,EFL	2023-04-27	47.69	2023-04-19	3	EURO
2743	UBR PENDING.UBER.COM AMSTERDAM	2023-04-27	4.23	2023-04-18	3	EURO
2744	UBR PENDING.UBER.COM AMSTERDAM	2023-04-27	5.03	2023-04-18	3	EURO
2745	UBR PENDING.UBER.COM AMSTERDAM	2023-04-27	6.88	2023-04-18	3	EURO
2746	UBR PENDING.UBER.COM AMSTERDAM	2023-04-27	6.30	2023-04-18	3	EURO
2747	BRAGA RIO LOJA 306 BRAG	2023-04-27	10.30	2023-04-18	3	EURO
2748	ARCADIA BRAGA PARQUE BR	2023-04-27	3.90	2023-04-18	3	EURO
2749	TOMATINO NOVA ARCADA BR	2023-04-27	8.50	2023-04-18	3	EURO
2750	CONTINENTE BRAGA BRAGA	2023-04-27	35.01	2023-04-18	3	EURO
2751	Glovo 14APR BREV1CABM	2023-04-27	12.53	2023-04-18	3	EURO
2752	Glovo 13APR BR1Q11YCH	2023-04-27	11.25	2023-04-14	3	EURO
2753	Glovo 13APR BR1CUKLTZ	2023-04-27	8.19	2023-04-14	3	EURO
2754	Glovo 13APR BRQTNRCM1	2023-04-27	11.00	2023-04-14	3	EURO
2755	IMPOSTO DE SELO 17.3.4	2023-04-27	0.21	2023-04-14	3	EURO
2756	COM. MANUTENCAO CONTA ORDENADO 032023	2023-04-27	5.20	2023-04-14	3	EURO
2757	a.NordVPN Amsterdam NL	2023-04-27	14.75	2023-04-14	3	EURO
2758	Glovo 12APR BRNHNGLWY	2023-04-27	13.35	2023-04-14	3	EURO
2759	Glovo 1	2023-04-27	9.45	2023-04-27	4	EURO
2760	Glovo 2	2023-04-27	11.69	2023-04-26	4	EURO
2761	Glovo 3	2023-04-27	31.81	2023-04-14	4	EURO
2762	INT PAG TIT	2023-04-27	774.22	2023-04-17	5	REAL
2763	DA COMGAS	2023-04-27	10.92	2023-04-17	5	REAL
2764	DA VIVO FIXO	2023-04-27	147.99	2023-04-17	5	REAL
2765	ANUIDADE DIFERENCIADA 05/12	2023-04-27	30.00	2023-03-31	6	REAL
2766	AMAZON KINDLE UNLTD SAO PAULO BR	2023-04-27	19.90	2023-04-03	6	REAL
2767	4259522985 BELLEVUE WA	2023-04-27	14.75	2023-04-03	6	REAL
2768	4259522985 912-1844160 WA	2023-04-27	14.75	2023-04-03	6	REAL
2769	DISNEY PLUS SAO PAULO BR	2023-04-27	27.90	2023-04-06	6	REAL
2770	NETFLIX.COM SAO PAULO BR	2023-04-27	39.90	2023-04-11	6	REAL
2771	APPLE.COM/BILL SAO PAULO BR	2023-04-27	14.90	2023-04-20	6	REAL
2772	DM *HELPHBOMAXCOM SAO PAULO BR	2023-04-27	34.90	2023-04-21	6	REAL
2773	4259522985	2023-04-27	31.80	2023-04-25	6	REAL
2774	Salario	\N	3500.00	2023-05-31	3	EURO
2775	VODAFONE PORTUGAL COMU	2023-05-06	62.71	2023-05-08	3	EURO
2776	EDP COMERCIALCOMERCIA	2023-05-06	66.76	2023-05-08	3	EURO
2777	AGEREEMP.DE AGUAS,EFL	2023-05-06	24.60	2023-05-08	3	EURO
2796	Glovo 25APR BRZ13AWMW Lisbon PR	2023-05-06	11.20	2023-04-28	3	EURO
2797	Uber1	2023-05-06	4.87	2023-05-06	3	EURO
2798	Uber2	2023-05-06	4.42	2023-05-06	3	EURO
2799	Rio Loja	2023-05-06	13.40	2023-05-06	3	EURO
2800	DA  ELETROPAULO 56301179	2023-05-06	21.95	2023-05-02	5	REAL
2801	TAR PACOTE ITAU   ABR/23	2023-05-06	71.90	2023-05-03	5	REAL
2802	INT PAG TIT 109005442012	2023-05-06	664.00	2023-05-08	5	REAL
2803	DA  VIVO FIXO 9324810660	2023-05-06	153.99	2023-05-15	5	REAL
2793	UBR PENDING.UBER.COM	2023-05-06	4.72	2023-05-03	3	EURO
2727	UBR PENDING.UBER.COM	2023-04-27	6.64	2023-04-25	3	EURO
2728	UBR PENDING.UBER.COM	2023-04-27	4.75	2023-04-25	3	EURO
2729	UBR PENDING.UBER.COM	2023-04-27	4.34	2023-04-25	3	EURO
2730	UBR PENDING.UBER.COM	2023-04-27	6.57	2023-04-25	3	EURO
2804	EBN*SPOTIFY	2023-05-06	19.90	2023-04-27	6	REAL
2805	IOF TRANSACOES INTERNACIONAIS	2023-05-06	3.29	2023-04-27	6	REAL
2806	Pagamento fatura 05/2023	2023-05-06	251.99	2023-05-06	5	REAL
2807	Glovo 27APR BR6CWQ8UH	2023-05-06	13.60	2023-04-28	4	EURO
2808	Glovo 28APR BR7LYCACC	2023-05-06	19.50	2023-04-29	4	EURO
2809	Glovo 02MAY BRJ4XF2AD	2023-05-06	9.45	2023-05-03	4	EURO
2810	Glovo 02MAY BRS32NMHY	2023-05-06	11.14	2023-05-03	4	EURO
2811	Glovo GLOVO PRIME	2023-05-06	5.99	2023-05-03	4	EURO
2812	Glovo 03MAY BRZ6SYVVA	2023-05-06	9.45	2023-05-03	4	EURO
2813	Glovo 04MAY BRLNJ9KAD	2023-05-06	9.45	2023-05-05	4	EURO
2814	Avis	2023-05-06	20.89	2023-05-06	4	EURO
2815	Glovo 05MAY BRZCWN1LN	2023-05-06	9.45	2023-05-06	4	EURO
2816	Glovo 05MAY BREK7W8XP	2023-05-06	8.70	2023-05-06	4	EURO
2817	Cobrir Conta	\N	500.00	2023-05-10	3	EURO
2820	CONTINENTE BRAGA BRAGA	2023-05-30	32.89	2023-05-30	3	EURO
2821	Glovo 28MAY BR3VUV9VG Lisbon PR	2023-05-30	10.10	2023-05-30	3	EURO
2822	Glovo 27MAY BRZQDJ7FV Lisbon PR	2023-05-30	12.35	2023-05-30	3	EURO
2823	GLOVO26MAY BR4P71MNR none	2023-05-30	15.90	2023-05-30	3	EURO
2824	Glovo 26MAY BR1FB1CRU Lisbon PR	2023-05-30	9.45	2023-05-30	3	EURO
2825	Glovo 25MAY BREN1LDXD Lisbon PR	2023-05-30	8.90	2023-05-26	3	EURO
2826	Glovo 25MAY BR5G19ULP Lisbon PR	2023-05-30	9.45	2023-05-26	3	EURO
2827	Glovo 24MAY BRLHMA1UC Lisbon PR	2023-05-30	9.45	2023-05-26	3	EURO
2828	Com.Transf.credito nao SEPA+ Em Linha(desp.OUR)	2023-05-30	25.00	2023-05-25	3	EURO
2829	Comissão Transf. a crédito não SEPA+ Em Linha	2023-05-30	17.50	2023-05-25	3	EURO
2830	Com. Transf. crédito não SEPA+ Em Linha (SWIFT)	2023-05-30	12.50	2023-05-25	3	EURO
2831	IVA  23%   s/Desp.SWIFT Ord.Pag.Ref.20231011423	2023-05-30	2.88	2023-05-25	3	EURO
2832	I.S.   4%  s/Com. OUR Ord. Pag. Ref.20231011423	2023-05-30	1.00	2023-05-25	3	EURO
2833	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20231011423	2023-05-30	0.70	2023-05-25	3	EURO
2836	Glovo 23MAY BRPQFXPZR Lisbon PR	2023-05-30	9.95	2023-05-25	3	EURO
2837	Glovo 23MAY BR21L7GN1 Lisbon PR	2023-05-30	9.45	2023-05-25	3	EURO
2838	Glovo 22MAY BRATKUHYW Lisbon PR	2023-05-30	9.45	2023-05-24	3	EURO
2843	CONTINENTE BRAGA BRAGA	2023-05-30	56.91	2023-05-24	3	EURO
2844	Glovo 21MAY BR1DE61EF Lisbon PR	2023-05-30	9.14	2023-05-24	3	EURO
2845	JEAN LOUIS DAVID BRAGA	2023-05-30	17.50	2023-05-23	3	EURO
2846	Glovo 20MAY BRLFJ6L7V Lisbon PR	2023-05-30	13.79	2023-05-23	3	EURO
2847	Glovo 19MAY BRZRUKLM4 Lisbon PR	2023-05-30	8.90	2023-05-23	3	EURO
2848	Glovo 19MAY BRZNJ3MLF Lisbon PR	2023-05-30	9.25	2023-05-23	3	EURO
2849	Glovo 19MAY BRGQKWPPB Lisbon PR	2023-05-30	10.90	2023-05-23	3	EURO
2850	TRF MB WAY P/ *****4651	2023-05-30	4.00	2023-05-22	3	EURO
2852	Glovo 17MAY BR91SP7XP Lisbon PR	2023-05-30	12.50	2023-05-19	3	EURO
2853	FELIX TABERNA SE	2023-05-30	30.00	2023-05-18	3	EURO
2856	Glovo 16MAY BRV1S3QLS Lisbon PR	2023-05-30	9.50	2023-05-18	3	EURO
2861	SPORT ZONE BRAGA PARQU	2023-05-30	23.19	2023-05-16	3	EURO
2862	POKE HOUSE BRAGA LISBOA	2023-05-30	9.90	2023-05-16	3	EURO
2863	PINGO DOCE BRAGA BRAGA	2023-05-30	11.91	2023-05-16	3	EURO
2864	Glovo 13MAY BRVPP1TL7 Lisbon PR	2023-05-30	10.95	2023-05-16	3	EURO
2867	GLOVO12MAY BR7Z3W6VL none	2023-05-30	9.45	2023-05-16	3	EURO
2868	CONTINENTE BRAGA BRAGA	2023-05-30	66.18	2023-05-15	3	EURO
2869	GLOVO11MAY BR45TWGCY none	2023-05-30	9.90	2023-05-12	3	EURO
2870	Glovo 11MAY BRLJVBKP7 Lisbon PR	2023-05-30	9.45	2023-05-12	3	EURO
2871	IMPOSTO DE SELO 17.3.4	2023-05-30	0.21	2023-05-12	3	EURO
2872	COM. MANUTENCAO CONTA ORDENADO 042023	2023-05-30	5.20	2023-05-12	3	EURO
2873	PLAYMORETENNIS COM SAO VITOR	2023-05-30	270.80	2023-05-12	3	EURO
2874	Glovo 10MAY BRXAB9VKE Lisbon PR	2023-05-30	9.45	2023-05-12	3	EURO
2877	Glovo 09MAY BRWL3PC7W Lisbon PR	2023-05-30	12.53	2023-05-12	3	EURO
2878	Comissao Transferencia a credito SEPA+ Em Linha	2023-05-30	1.10	2023-05-10	3	EURO
2879	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20230903980	2023-05-30	0.04	2023-05-10	3	EURO
2880	WOK TO WALK N ARCADA BR	2023-05-30	13.40	2023-05-09	3	EURO
2883	CONTINENTE BRAGA BRAGA	2023-05-30	41.70	2023-05-09	3	EURO
2884	GLOVO1	2023-05-30	9.45	2023-05-30	3	EURO
2885	Uber1	2023-05-30	4.88	2023-05-29	3	EURO
2886	Cinema	2023-05-30	8.90	2023-05-29	3	EURO
2887	Almoco	2023-05-30	13.40	2023-05-29	3	EURO
2888	Uber2	2023-05-30	4.41	2023-05-29	3	EURO
2889	Remessa Internacional	2023-05-30	7000.00	2023-05-30	3	REAL
2890	Eletropaulo	2023-05-30	21.97	2023-05-29	5	REAL
2891	IOF	2023-05-30	137.37	2023-05-30	5	REAL
2892	ComGas	2023-05-30	10.92	2023-05-15	5	REAL
2893	Glovo 1	2023-05-30	14.60	2023-05-08	4	EURO
2894	Glovo 2	2023-05-30	9.45	2023-05-08	4	EURO
2895	Glovo	2023-06-02	10.10	2023-06-01	3	EURO
2896	Salario	\N	3500.00	2023-06-30	3	EURO
2897	AmazonPrimeBR SAO PAULO BR	2023-06-02	14.90	2023-05-03	6	REAL
2898	Amazon Kindle Unltd SAO PAULO BR	2023-06-02	19.90	2023-05-03	6	REAL
2899	ANUIDADE DIFERENCIADA 06/12	2023-06-02	30.00	2023-05-03	6	REAL
2900	Disney Plus SAO PAULO BR	2023-06-02	27.90	2023-05-06	6	REAL
2901	NETFLIX.COM SAO PAULO BR	2023-06-02	39.90	2023-05-11	6	REAL
2902	APPLE.COM/BILL SAO PAULO BR	2023-06-02	14.90	2023-05-20	6	REAL
2903	DM*HELPHBOMAXCOM SAO PAULO BR	2023-06-02	34.90	2023-05-21	6	REAL
2904	EBN*SPOTIFY CURITIBA BR	2023-06-02	19.90	2023-05-28	6	REAL
2905	Glovo 29JUN BRPNY1JAG Lisbon PR	2023-07-01	9.45	2023-06-30	3	EURO
2906	Glovo 28JUN BRKSCR8KA Lisbon PR	2023-07-01	8.00	2023-06-30	3	EURO
2907	Glovo 28JUN BREDPNJLZ Lisbon PR	2023-07-01	9.45	2023-06-30	3	EURO
2910	Glovo 27JUN BRQ7QF3SX Lisbon PR	2023-07-01	11.20	2023-06-29	3	EURO
2911	Glovo 26JUN BRVJZGASL Lisbon PR	2023-07-01	8.90	2023-06-28	3	EURO
2912	Glovo 26JUN BRD2F5L68 Lisbon PR	2023-07-01	9.45	2023-06-28	3	EURO
2913	BRAGA RIO LOJA 306 BRAG	2023-07-01	13.40	2023-06-27	3	EURO
2918	CONTINENTE BRAGA BRAGA	2023-07-01	47.11	2023-06-27	3	EURO
2919	Glovo 23JUN BR26SHXBB Lisbon PR	2023-07-01	11.64	2023-06-27	3	EURO
2920	Glovo 23JUN BRAVLYFPJ Lisbon PR	2023-07-01	9.45	2023-06-27	3	EURO
2921	TACO BELL BRAGA ARCABRAGA	2023-07-01	6.95	2023-06-26	3	EURO
2922	Glovo 21JUN BRX9SJLMH Lisbon PR	2023-07-01	9.45	2023-06-23	3	EURO
2925	Glovo 20JUN BR9CSVSEK Lisbon PR	2023-07-01	9.45	2023-06-23	3	EURO
2926	Glovo 20JUN BRU1R7VB8 Lisbon PR	2023-07-01	8.69	2023-06-23	3	EURO
2927	GLOVO19JUN BRM544NW1 none	2023-07-01	8.76	2023-06-21	3	EURO
2932	WOK TO WALK N ARCADA BR	2023-07-01	13.40	2023-06-20	3	EURO
2933	CONTINENTE BRAGA BRAGA	2023-07-01	75.15	2023-06-20	3	EURO
2934	JEAN LOUIS DAVID BRAGA	2023-07-01	17.50	2023-06-20	3	EURO
2935	FNAC BRAGA BRAGA PR	2023-07-01	59.99	2023-06-20	3	EURO
2936	BRAGA RIO LOJA 306 BRAG	2023-07-01	13.40	2023-06-20	3	EURO
2937	Glovo 17JUN BR1UUM1XL Lisbon PR	2023-07-01	8.90	2023-06-20	3	EURO
2938	Glovo 17JUN BRD8LPFKJ Lisbon PR	2023-07-01	12.86	2023-06-20	3	EURO
2939	Glovo 16JUN BRXH4RWDL Lisbon PR	2023-07-01	10.90	2023-06-20	3	EURO
2940	Glovo 16JUN BRWD1FE41 Lisbon PR	2023-07-01	9.45	2023-06-20	3	EURO
2941	Glovo 15JUN BRZJ7METC Lisbon PR	2023-07-01	10.18	2023-06-16	3	EURO
2944	Glovo 14JUN BRQZYYGSG Lisbon PR	2023-07-01	8.90	2023-06-16	3	EURO
2947	Glovo 13JUN BR4UX4ZEL Lisbon PR	2023-07-01	14.70	2023-06-16	3	EURO
2948	Glovo 12JUN BRTENGGYL Lisbon PR	2023-07-01	13.80	2023-06-14	3	EURO
2951	DD PT10100825 VODAFONE PORTUG 07335462122	2023-07-01	62.68	2023-06-14	3	EURO
2952	CONTINENTE BRAGA BRAGA	2023-07-01	85.95	2023-06-13	3	EURO
2953	Glovo 10JUN BRALDWNQ1 Lisbon PR	2023-07-01	13.62	2023-06-13	3	EURO
2954	Glovo 10JUN BRLA3DEXS Lisbon PR	2023-07-01	18.90	2023-06-13	3	EURO
2955	Glovo 09JUN BRVRMH2AK Lisbon PR	2023-07-01	15.09	2023-06-13	3	EURO
2956	PAG SERV 21796/233028442 AGEREEMP.DE AGUAS,EFL	2023-07-01	19.67	2023-06-12	3	EURO
2957	PAG SERV 20174/241924599 EDP COMERCIALCOMERCIA	2023-07-01	55.42	2023-06-12	3	EURO
2958	LEV ATM 6251 CGD   Braga         C Com Nova Arc	2023-07-01	60.00	2023-06-12	3	EURO
2959	IMPOSTO DE SELO 17.3.4	2023-07-01	0.21	2023-06-09	3	EURO
2960	COM. MANUTENCAO CONTA ORDENADO 052023	2023-07-01	5.20	2023-06-09	3	EURO
2963	Glovo 05JUN BRVFPJ7U7 Lisbon PR	2023-07-01	9.30	2023-06-08	3	EURO
2966	Glovo 04JUN BRA8CLTSE Lisbon PR	2023-07-01	10.10	2023-06-06	3	EURO
2967	CONTINENTE BRAGA BRAGA	2023-07-01	64.48	2023-06-06	3	EURO
2968	Glovo 03JUN BRW6LDH7L Lisbon PR	2023-07-01	11.55	2023-06-06	3	EURO
2969	Uber	2023-07-01	5.90	2023-07-01	3	EURO
2970	Continente	2023-07-01	74.60	2023-07-01	3	EURO
2971	Almoco	2023-07-01	9.20	2023-07-01	3	EURO
2972	uber2	2023-07-01	6.91	2023-07-01	3	EURO
2973	Glovo Prime	2023-07-01	5.99	2023-06-03	4	EURO
2908	UBR PENDING.UBER.COM	2023-07-01	4.11	2023-06-29	3	EURO
2974	Valor de volta	2023-07-01	8700.00	2023-06-30	5	REAL
2975	Eletropaulo	2023-07-01	82.35	2023-06-29	5	REAL
2976	Vivo	2023-07-01	152.49	2023-06-15	5	REAL
2977	Condominio	2023-07-01	664.00	2023-06-12	5	REAL
2978	Pagamento fatura 06/2023	2023-06-12	202.30	2023-07-01	5	REAL
2979	Pacote Itau	2023-07-01	71.90	2023-06-02	5	REAL
2980	Comgas	2023-07-01	10.92	2023-06-19	5	REAL
2981	ANUIDADE DIFERENCIADA 07/12	2023-07-01	30.00	2023-05-31	6	REAL
2982	AmazonPrimeBR	2023-07-01	14.90	2023-06-03	6	REAL
2983	Amazon Kindle Unltd	2023-07-01	19.90	2023-06-03	6	REAL
2984	Disney Plus	2023-07-01	33.90	2023-06-06	6	REAL
2985	NETFLIX.COM	2023-07-01	39.90	2023-06-11	6	REAL
2986	APPLE.COM/BILL	2023-07-01	14.90	2023-06-20	6	REAL
2987	DM*HELPHBOMAXCOM	2023-07-01	34.90	2023-06-21	6	REAL
2988	EBN *SPOTIFY	2023-07-01	19.90	2023-06-28	6	REAL
2989	Salario	\N	3500.00	2023-07-31	3	EURO
2990	Glovo 05JUL BRLFFKRNN Lisbon PR	2023-07-07	9.45	2023-07-07	3	EURO
2991	Glovo 05JUL BRHGGBUPL Lisbon PR	2023-07-07	8.90	2023-07-07	3	EURO
2994	Glovo 04JUL BRZSBBG12 Lisbon PR	2023-07-07	9.45	2023-07-06	3	EURO
2995	Glovo 04JUL BRAB19JGE Lisbon PR	2023-07-07	9.95	2023-07-06	3	EURO
2996	Glovo 03JUL BR38MEUM1 Lisbon PR	2023-07-07	13.79	2023-07-05	3	EURO
2997	LEV ATM 6251 CGD   Braga         R Fr DuarteSa	2023-07-07	60.00	2023-07-04	3	EURO
2998	Glovo 02JUL BR91ELXR1 Lisbon PR	2023-07-07	12.90	2023-07-04	3	EURO
2999	glovo 1	2023-07-07	9.45	2023-07-06	3	EURO
3000	glovo 2	2023-07-07	9.45	2023-07-07	3	EURO
3001	Glovo Prime	2023-07-07	5.99	2023-07-03	4	EURO
3002	EDP	2023-07-07	54.44	2023-07-07	3	EURO
3003	Pagamento fatura 07/2023	2023-07-07	208.30	2023-07-07	5	REAL
3004	Solange	2023-07-07	660.00	2023-07-06	5	REAL
3005	pacote itau	2023-07-07	71.90	2023-07-04	5	REAL
3006	TRF. P/O  REEMBOLSOS   IRS            AT - REEM	2023-07-22	1011.75	2023-07-21	3	EURO
3007	Glovo 20JUL BRYJ6RJFR Lisbon PR	2023-07-22	9.45	2023-07-21	3	EURO
3008	Glovo 19JUL BR1NGBQXY Lisbon PR	2023-07-22	11.50	2023-07-21	3	EURO
3011	Glovo 18JUL BRF3BLX14 Lisbon PR	2023-07-22	18.20	2023-07-21	3	EURO
3014	Glovo 17JUL BRTY4LFNG Lisbon PR	2023-07-22	9.45	2023-07-19	3	EURO
3017	Glovo 16JUL BRTXCBYTE Lisbon PR	2023-07-22	15.20	2023-07-18	3	EURO
3024	Glovo 14JUL BRP1TBGJH Lisbon PR	2023-07-22	10.89	2023-07-18	3	EURO
3025	Glovo 14JUL BRH48UGRP Lisbon PR	2023-07-22	19.59	2023-07-18	3	EURO
3026	Glovo 13JUL BRZWVBYXK Lisbon PR	2023-07-22	9.45	2023-07-14	3	EURO
3027	Glovo 12JUL BRF8BNPKE Lisbon PR	2023-07-22	9.45	2023-07-14	3	EURO
3028	Glovo Lisbon PR	2023-07-22	11.50	2023-07-13	3	EURO
3031	DD PT10100825 VODAFONE PORTUG 07335462122	2023-07-22	62.00	2023-07-12	3	EURO
3034	Glovo 09JUL BR26YFHK4 Lisbon PR	2023-07-22	11.40	2023-07-11	3	EURO
3036	FARMACIA MADALENA 4700207 BRAGA	2023-07-22	10.22	2023-07-10	3	EURO
3037	IMPOSTO DE SELO 17.3.4	2023-07-22	0.21	2023-07-07	3	EURO
3038	COM. MANUTENCAO CONTA ORDENADO 062023	2023-07-22	5.20	2023-07-07	3	EURO
3039	Uber 1	2023-07-22	3.50	2023-07-21	3	EURO
3040	Uber 2	2023-07-22	3.50	2023-07-21	3	EURO
3041	Uber 3	2023-07-22	6.87	2023-07-21	3	EURO
3042	Uber 4	2023-07-22	6.67	2023-07-21	3	EURO
3043	Continente	2023-07-22	52.78	2023-07-21	3	EURO
3044	Glovo	2023-07-22	9.45	2023-07-21	3	EURO
3045	Condominio	2023-07-22	677.28	2023-07-20	5	REAL
3046	Congas	2023-07-22	10.92	2023-07-17	5	REAL
3047	Vivo	\N	148.99	2023-07-17	5	REAL
3048	Glovo 1	2023-07-22	11.34	2023-07-07	4	EURO
3049	Glovo 2	2023-07-22	16.38	2023-07-15	4	EURO
3050	Glovo 3	2023-07-22	18.20	2023-07-20	4	EURO
3051	Glovo 02AUG BR1LFUABZ Lisbon PR	2023-08-06	13.65	2023-08-04	3	EURO
3052	Glovo 02AUG BRJ1AXZ8G Lisbon PR	2023-08-06	9.45	2023-08-04	3	EURO
3053	Glovo 01AUG BRNQ9FZWB Lisbon PR	2023-08-06	9.45	2023-08-03	3	EURO
3054	Glovo 01AUG BRKNX4ZA4 Lisbon PR	2023-08-06	10.34	2023-08-03	3	EURO
3055	Glovo 31JUL BRJMM9J1C Lisbon PR	2023-08-06	9.45	2023-08-02	3	EURO
3056	TOMATINO BRAGA PQ BRAGA	2023-08-06	7.95	2023-08-01	3	EURO
3061	CONTINENTE BRAGA BRAGA	2023-08-06	36.33	2023-08-01	3	EURO
3062	Glovo 28JUL BRGNN3YYZ Lisbon PR	2023-08-06	9.45	2023-08-01	3	EURO
3063	LA ROTISSERIE BRAGA	2023-08-06	10.45	2023-07-31	3	EURO
3064	Glovo 26JUL BRG83C1ZF Lisbon PR	2023-08-06	11.40	2023-07-28	3	EURO
3153	UBR PENDING.UBER.COM	2023-09-10	3.97	2023-08-15	3	EURO
2992	UBR PENDING.UBER.COM	2023-07-07	4.00	2023-07-06	3	EURO
2993	UBR PENDING.UBER.COM	2023-07-07	5.47	2023-07-06	3	EURO
3009	UBR PENDING.UBER.COM	2023-07-22	4.05	2023-07-21	3	EURO
3010	UBR PENDING.UBER.COM	2023-07-22	3.84	2023-07-21	3	EURO
3012	UBR PENDING.UBER.COM	2023-07-22	3.62	2023-07-19	3	EURO
3067	Glovo 25JUL BR11BGJZX Lisbon PR	2023-08-06	9.45	2023-07-27	3	EURO
3068	BRASA RIO BRAGA PR	2023-08-06	13.40	2023-07-26	3	EURO
3069	PINGO DOCE BRAGA BRAGA	2023-08-06	7.32	2023-07-26	3	EURO
3072	Glovo 23JUL BRSN95LPL Lisbon PR	2023-08-06	10.34	2023-07-25	3	EURO
3073	Glovo 23JUL BRBYH1DKA Lisbon PR	2023-08-06	10.34	2023-07-25	3	EURO
3074	Glovo 22JUL BRWRTZK4L Lisbon PR	2023-08-06	13.59	2023-07-25	3	EURO
3075	Uber 1	2023-08-06	6.72	2023-08-05	3	EURO
3076	Continente	2023-08-06	71.07	2023-08-05	3	EURO
3077	Uber 2	2023-08-06	5.72	2023-08-05	3	EURO
3080	Glovo 3	2023-08-06	19.40	2023-08-03	3	EURO
3081	Salario	\N	3500.00	2023-08-31	3	EURO
3082	Valor Mae	2023-08-06	200000.00	2023-07-31	5	REAL
3083	Eletropaulo	2023-08-06	20.07	2023-07-31	5	REAL
3084	Pacote Itau	2023-08-06	71.90	2023-08-02	5	REAL
3085	Glovo Prime	2023-08-06	5.99	2023-08-03	4	EURO
3086	Blizzard	2023-08-06	89.00	2023-06-29	6	REAL
3087	ANUIDADE DIFERENCIADA 08/12	2023-08-06	30.00	2023-06-30	6	REAL
3088	AmazonPrimeBR	2023-08-06	14.90	2023-07-03	6	REAL
3089	Amazon Kindle Unltd	2023-08-06	19.90	2023-07-03	6	REAL
3090	Disney Plus	2023-08-06	33.90	2023-07-06	6	REAL
3091	NETFLIX.COM	2023-08-06	39.90	2023-07-11	6	REAL
3092	APPLE.COM/BILL	2023-08-06	14.90	2023-07-20	6	REAL
3093	HELPHBOMAXCOM	2023-08-06	34.90	2023-07-21	6	REAL
3094	Spotify	2023-08-06	19.90	2023-07-28	6	REAL
3095	Pagamento fatura 08/2023	2023-08-07	297.30	2023-08-06	5	REAL
3079	Glovo 2	2023-08-06	11.50	2023-08-04	3	EURO
3142	UBR PENDING.UBER.COM	2023-09-10	5.92	2023-08-22	3	EURO
3078	Glovo 1	2023-08-06	19.60	2023-08-04	3	EURO
3096	Cobrir Conta	\N	2000.00	2023-08-28	3	EURO
3097	Glovo 07SEP BRVJ1DJTV	2023-09-10	10.95	2023-09-08	3	EURO
3098	IMPOSTO DE SELO 17.3.4	2023-09-10	0.21	2023-09-11	3	EURO
3099	COM. MANUTENCAO CONTA ORDENADO 082023	2023-09-10	5.20	2023-09-11	3	EURO
3100	IMP.  SELO  COM. TRANSFERENCIA	2023-09-10	0.04	2023-09-07	3	EURO
3101	Comissao Transferencia a credito SEPA+ Em Linha	2023-09-10	1.10	2023-09-07	3	EURO
3102	TRF P/ Lucinda dona da casa	2023-09-10	650.00	2023-09-07	3	EURO
3103	UBR PENDING.UBER.COM	2023-09-10	3.93	2023-09-07	3	EURO
3104	UBR PENDING.UBER.COM	2023-09-10	3.50	2023-09-07	3	EURO
3105	Glovo 05SEP BRKNES9VH	2023-09-10	12.53	2023-09-07	3	EURO
3106	Glovo 04SEP BRXJNJ1LY	2023-09-10	9.45	2023-09-06	3	EURO
3107	LEV ATM 6251 BPI   BRAGA         R Cidade do Po	2023-09-10	100.00	2023-09-05	3	EURO
3108	UBR PENDING.UBER.COM	2023-09-10	4.86	2023-09-05	3	EURO
3109	UBR PENDING.UBER.COM	2023-09-10	4.13	2023-09-05	3	EURO
3110	HEBE GYROS BRAGA BRAGA	2023-09-10	9.20	2023-09-05	3	EURO
3111	CONTINENTE BRAGA BRAGA	2023-09-10	32.58	2023-09-05	3	EURO
3112	Glovo 01SEP BRQGB7BLL	2023-09-10	9.45	2023-09-05	3	EURO
3113	Glovo 30AUG BRVFD1VXS	2023-09-10	15.92	2023-09-01	3	EURO
3114	Glovo 30AUG BR5Y1WYXK	2023-09-10	9.45	2023-09-01	3	EURO
3115	Glovo 29AUG BRX1UYMY4	2023-09-10	15.92	2023-08-31	3	EURO
3116	Glovo 28AUG BRPPU33AC	2023-09-10	9.45	2023-08-30	3	EURO
3117	UBR PENDING.UBER.COM	2023-09-10	5.63	2023-08-29	3	EURO
3118	UBR PENDING.UBER.COM	2023-09-10	5.75	2023-08-29	3	EURO
3119	UBR PENDING.UBER.COM	2023-09-10	4.19	2023-08-29	3	EURO
3120	UBR PENDING.UBER.COM	2023-09-10	3.66	2023-08-29	3	EURO
3121	TOMATINO NOVA ARCADA BR	2023-09-10	7.95	2023-08-29	3	EURO
3122	CONTINENTE BRAGA BRAGA	2023-09-10	59.10	2023-08-29	3	EURO
3123	BRAGA RIO LOJA 306 BRAG	2023-09-10	13.40	2023-08-29	3	EURO
3124	Glovo 25AUG BR5Q6FYDM	2023-09-10	9.45	2023-08-29	3	EURO
3125	Comissao Transferencia a credito SEPA+ Em Linha	2023-09-10	1.10	2023-08-28	3	EURO
3126	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20231684975	2023-09-10	0.04	2023-08-28	3	EURO
3127	STM BRAGA	2023-09-10	4.10	2023-08-28	3	EURO
3128	Glovo 24AUG BRKMLLUL3	2023-09-10	11.50	2023-08-25	3	EURO
3129	SPORT ZONE NOVA ARCA BR	2023-09-10	64.18	2023-08-25	3	EURO
3130	SEASIDE BRAGA PR	2023-09-10	20.95	2023-08-25	3	EURO
3131	VITAMINAS N ARCADA BRAG	2023-09-10	11.25	2023-08-25	3	EURO
3132	Glovo 23AUG BRWNLLAMD	2023-09-10	9.45	2023-08-25	3	EURO
3133	DD PT34100781 EDP COMERCIALC 16010011942146	2023-09-10	61.16	2023-08-25	3	EURO
3134	UBR PENDING.UBER.COM	2023-09-10	5.96	2023-08-24	3	EURO
3135	UBR PENDING.UBER.COM	2023-09-10	5.69	2023-08-24	3	EURO
3136	UBR PENDING.UBER.COM	2023-09-10	3.63	2023-08-22	3	EURO
3137	UBR PENDING.UBER.COM	2023-09-10	4.19	2023-08-22	3	EURO
3138	JEAN LOUIS DAVID BRAGA	2023-09-10	17.50	2023-08-22	3	EURO
3139	BODEGAO BRAGA BRAGA PR	2023-09-10	11.50	2023-08-22	3	EURO
3140	Glovo 19AUG BRW1FZJER	2023-09-10	18.89	2023-08-22	3	EURO
3141	TOMATINO NOVA ARCADA BR	2023-09-10	7.95	2023-08-22	3	EURO
3143	UBR PENDING.UBER.COM	2023-09-10	5.80	2023-08-22	3	EURO
3144	CONTINENTE BRAGA BRAGA	2023-09-10	48.72	2023-08-22	3	EURO
3145	Glovo 18AUG BRUVR2LU4	2023-09-10	9.45	2023-08-22	3	EURO
3146	WOK TO WALK BRAGA BRAGA	2023-09-10	15.25	2023-08-17	3	EURO
3147	PINGO DOCE BRAGA BRAGA	2023-09-10	5.28	2023-08-17	3	EURO
3148	UBR PENDING.UBER.COM	2023-09-10	3.72	2023-08-17	3	EURO
3149	UBR PENDING.UBER.COM	2023-09-10	3.96	2023-08-17	3	EURO
3150	Glovo 14AUG BRHFNLMA3	2023-09-10	9.81	2023-08-16	3	EURO
3151	Glovo 14AUG BRR11MZNQ	2023-09-10	9.00	2023-08-16	3	EURO
3152	UBR PENDING.UBER.COM	2023-09-10	3.25	2023-08-15	3	EURO
3154	UBR PENDING.UBER.COM	2023-09-10	3.14	2023-08-15	3	EURO
3155	UBER TRIP	2023-09-10	4.07	2023-08-15	3	EURO
3156	COMPANHIA SANDES BRG BR	2023-09-10	8.10	2023-08-15	3	EURO
3157	IKEA BRAGA CAIXAS ECO B	2023-09-10	8.90	2023-08-15	3	EURO
3158	Glovo 12AUG BREQRA5ZS	2023-09-10	10.30	2023-08-15	3	EURO
3159	CONTINENTE BRAGA BRAGA	2023-09-10	83.75	2023-08-15	3	EURO
3160	Glovo 11AUG BRBQDXTY7	2023-09-10	9.45	2023-08-15	3	EURO
3161	Glovo 10AUG BR61DV7LD	2023-09-10	9.45	2023-08-14	3	EURO
3162	IMPOSTO DE SELO 17.3.4	2023-09-10	0.21	2023-08-14	3	EURO
3163	COM. MANUTENCAO CONTA ORDENADO 072023	2023-09-10	5.20	2023-08-14	3	EURO
3164	Glovo 09AUG BRHQS8DD7	2023-09-10	18.20	2023-08-11	3	EURO
3165	Glovo 09AUG BRB8UN5TA	2023-09-10	9.45	2023-08-11	3	EURO
3166	PAG SERV 21796/246412542 AGEREEMP.DE AGUAS,EFL	2023-09-10	45.62	2023-08-11	3	EURO
3167	DD PT10100825 VODAFONE PORTUG 07335462122	2023-09-10	61.07	2023-08-10	3	EURO
3168	Glovo 07AUG BR96E9K3T	2023-09-10	9.45	2023-08-09	3	EURO
3169	Uber 1	2023-09-10	5.82	2023-09-09	3	EURO
3170	Continente	2023-09-10	43.35	2023-09-09	3	EURO
3171	Vitamina	2023-09-10	11.25	2023-09-09	3	EURO
3172	Uber 2	2023-09-10	7.41	2023-09-09	3	EURO
3173	Glovo 1	2023-09-10	16.29	2023-09-08	3	EURO
3174	Glovo 2	2023-09-10	10.95	2023-09-08	3	EURO
3175	Salario Setembro	\N	3500.00	2023-09-30	3	EURO
3176	Glovo 1	2023-09-10	26.38	2023-09-09	4	EURO
3177	Glovo 2	2023-09-10	22.75	2023-09-06	4	EURO
3178	Passagem Brasil	2023-09-10	1685.95	2023-09-04	4	EURO
3179	Glovo Prime	2023-09-10	5.99	2023-09-03	4	EURO
3180	Glovo 3	2023-09-10	15.92	2023-08-31	4	EURO
3181	Glovo 4	2023-09-10	16.70	2023-08-21	4	EURO
3182	AmazonPrimeBR	2023-09-10	14.90	2023-08-03	6	REAL
3183	Amazon Kindle Unltd	2023-09-10	19.90	2023-08-03	6	REAL
3184	ANUIDADE DIFERENCIADA 09/12	2023-09-10	30.00	2023-08-03	6	REAL
3185	Disney Plus	2023-09-10	33.90	2023-08-06	6	REAL
3186	NETFLIX.COM	2023-09-10	39.90	2023-08-11	6	REAL
3187	APPLE.COM/BILL	2023-09-10	14.90	2023-08-20	6	REAL
3188	AMERICANAS *FIT IN 01/08 MONTEIRO	2023-09-10	137.83	2023-08-21	6	REAL
3189	DM*HELPHBOMAXCOM	2023-09-10	34.90	2023-08-21	6	REAL
3190	EBN*SPOTIFY	2023-09-10	21.90	2023-08-28	6	REAL
3191	Pagamento fatura 09/2023	2023-09-11	348.13	2023-09-10	5	REAL
3192	pacote iatu	2023-09-10	71.90	2023-09-04	5	REAL
3193	Condominio	2023-09-10	677.28	2023-08-30	5	REAL
3194	Eletropaulo	2023-09-10	21.44	2023-08-29	5	REAL
3195	Vivo	2023-09-10	148.99	2023-08-15	5	REAL
3196	Gas	2023-09-10	10.92	2023-08-14	5	REAL
3197	Ferias	2023-09-11	1994.00	2023-09-11	3	EURO
3198	Glovo 1	2023-09-11	14.00	2023-09-11	3	EURO
3199	Glovo	2023-09-11	9.00	2023-09-10	3	EURO
3200	Salario	\N	3500.00	2023-10-31	3	EURO
3201	TRF P/ Lucinda dona da casa	2023-10-05	650.00	2023-10-05	3	EURO
3202	UBR PENDING.UBER.COM	2023-10-05	4.01	2023-10-05	3	EURO
3203	UBR PENDING.UBER.COM	2023-10-05	4.19	2023-10-05	3	EURO
3204	Glovo 03OCT BRZ8JVQLT	2023-10-05	18.30	2023-10-05	3	EURO
3205	Glovo 03OCT BRXXGFURA	2023-10-05	10.95	2023-10-05	3	EURO
3206	Glovo 02OCT BRLVTL2PP	2023-10-05	10.95	2023-10-04	3	EURO
3207	UBR PENDING.UBER.COM	2023-10-05	5.74	2023-10-03	3	EURO
3208	UBR PENDING.UBER.COM	2023-10-05	4.89	2023-10-03	3	EURO
3209	CONTINENTE BRAGA BRAGA	2023-10-05	49.95	2023-10-03	3	EURO
3210	Glovo 01OCT BRH1L1EES	2023-10-05	9.00	2023-10-03	3	EURO
3211	Glovo 30SEP BRLELHEEZ	2023-10-05	15.79	2023-10-03	3	EURO
3212	Glovo 30SEP BRPG9G7AG	2023-10-05	13.00	2023-10-03	3	EURO
3213	CUSTO DE SERVICO INTERNACIONAL	2023-10-05	0.05	2023-10-03	3	EURO
3214	Google Niantic I BRL TC   0.1907356	2023-10-05	1.40	2023-10-03	3	EURO
3215	Glovo 29SEP BR51L94NU	2023-10-05	18.30	2023-10-03	3	EURO
3216	Glovo 27SEP BR58VF9SN	2023-10-05	16.09	2023-09-29	3	EURO
3217	Glovo 27SEP BRX8CNRXD	2023-10-05	10.95	2023-09-29	3	EURO
3218	UBR PENDING.UBER.COM	2023-10-05	3.50	2023-09-29	3	EURO
3219	UBR PENDING.UBER.COM	2023-10-05	3.50	2023-09-29	3	EURO
3220	Glovo 26SEP BRH7XDGTU	2023-10-05	13.75	2023-09-29	3	EURO
3221	Glovo 25SEP BR5KKDFC8	2023-10-05	9.00	2023-09-27	3	EURO
3222	UBR PENDING.UBER.COM	2023-10-05	5.87	2023-09-27	3	EURO
3223	UBR PENDING.UBER.COM	2023-10-05	5.72	2023-09-27	3	EURO
3224	CONTINENTE BRAGA BRAGA	2023-10-05	70.98	2023-09-26	3	EURO
3225	Glovo 22SEP BR8J4SRTQ	2023-10-05	15.79	2023-09-26	3	EURO
3226	Glovo 22SEP BRUNC8MAB	2023-10-05	10.95	2023-09-26	3	EURO
3227	Glovo 21SEP BR7GMD1RL	2023-10-05	10.95	2023-09-25	3	EURO
3228	Glovo 20SEP BR1ZPGLX9	2023-10-05	10.95	2023-09-22	3	EURO
3229	DD PT34100781 EDP COMERCIAL C 16010011942146	2023-10-05	61.05	2023-09-22	3	EURO
3230	PAG SERV 21796/252990342 AGEREEMP.DE AGUAS,EFL	2023-10-05	25.79	2023-09-21	3	EURO
3231	UBR PENDING.UBER.COM	2023-10-05	3.50	2023-09-21	3	EURO
3232	UBR PENDING.UBER.COM	2023-10-05	7.07	2023-09-21	3	EURO
3233	Glovo 19SEP BRNQSJBWA	2023-10-05	13.30	2023-09-21	3	EURO
3234	Glovo 19SEP BR19DK1PY	2023-10-05	10.95	2023-09-21	3	EURO
3235	Glovo 18SEP BRAAPRDWJ	2023-10-05	10.95	2023-09-20	3	EURO
3236	UBR PENDING.UBER.COM	2023-10-05	5.65	2023-09-19	3	EURO
3237	UBR PENDING.UBER.COM	2023-10-05	5.79	2023-09-19	3	EURO
3238	CONTINENTE BRAGA BRAGA	2023-10-05	58.36	2023-09-19	3	EURO
3239	Glovo 16SEP BRSLLFHCU	2023-10-05	9.00	2023-09-19	3	EURO
3240	GlovoApp Portugal LISBOA PR	2023-10-05	12.55	2023-09-19	3	EURO
3241	Glovo 15SEP BRWMDDXM1	2023-10-05	10.95	2023-09-19	3	EURO
3242	Glovo 14SEP BRBLYLJWZ	2023-10-05	10.95	2023-09-18	3	EURO
3243	Glovo 13SEP BRZLJH1FL	2023-10-05	10.95	2023-09-15	3	EURO
3244	UBR PENDING.UBER.COM	2023-10-05	3.50	2023-09-14	3	EURO
3245	UBR PENDING.UBER.COM	2023-10-05	3.50	2023-09-14	3	EURO
3246	Glovo 12SEP BRRWTE75N	2023-10-05	10.95	2023-09-14	3	EURO
3247	DD PT10100825 VODAFONE PORTUG 07335462122	2023-10-05	62.94	2023-09-12	3	EURO
3250	Glovo 12SEP BRDXC77ZZ	2023-10-05	13.65	2023-09-13	4	EURO
3251	Glovo 15SEP BRYHLBNDM	2023-10-05	18.20	2023-09-16	4	EURO
3252	GlovoApp Portugal	2023-10-05	9.00	2023-09-17	4	EURO
3253	Glovo 23SEP BRPAWHLPF	2023-10-05	11.48	2023-09-24	4	EURO
3254	Glovo 23SEP BR8UH1HXX	2023-10-05	11.64	2023-09-24	4	EURO
3255	Glovo 25SEP BRKJYXB8Y	2023-10-05	10.95	2023-09-26	4	EURO
3256	Glovo 28SEP BRTPMPGVW	2023-10-05	10.95	2023-09-28	4	EURO
3257	Glovo 29SEP BRK1Y9CWT	2023-10-05	10.95	2023-09-30	4	EURO
3258	Glovo GLOVO PRIME	2023-10-05	5.99	2023-10-03	4	EURO
3259	DA  VIVO FIXO 9324810660	2023-10-05	148.99	2023-09-15	5	REAL
3260	DA  COMGAS 48353698	2023-10-05	10.92	2023-09-18	5	REAL
3261	INT TED  3c49f4de	2023-10-05	660.00	2023-09-26	5	REAL
3262	DA  ELETROPAULO 56301179	2023-10-05	21.70	2023-09-29	5	REAL
3263	TAR PACOTE ITAU   SET/23	2023-10-05	71.90	2023-10-03	5	REAL
3264	Condominio	2023-10-05	664.00	2023-10-05	5	REAL
3265	AMERICANAS *FIT IN 02/08 MONTEIRO	2023-10-05	137.78	2023-08-30	6	REAL
3266	ANUIDADE DIFERENCIADA 10/12	2023-10-05	30.00	2023-08-31	6	REAL
3267	Amazon Kindle Unltd	2023-10-05	19.90	2023-09-03	6	REAL
3268	AmazonPrimeBR	2023-10-05	14.90	2023-09-03	6	REAL
3269	Disney Plus	2023-10-05	33.90	2023-09-06	6	REAL
3270	NETFLIX.COM	2023-10-05	39.90	2023-09-11	6	REAL
3271	APPLE.COM/BILL	2023-10-05	14.90	2023-09-20	6	REAL
3272	DEMERGE BRAS*HELPHBOMA SAO PAULO B	2023-10-05	34.90	2023-09-21	6	REAL
3273	ALURA 01/12	2023-10-05	92.65	2023-09-26	6	REAL
3274	BLOX COBRANC*DESM 01/06 COLOMBO BR	2023-10-05	342.37	2023-09-28	6	REAL
3275	EBN*SPOTIFY	2023-10-05	21.90	2023-09-28	6	REAL
3276	Pagamento fatura 10/2023	2023-10-05	783.10	2023-10-05	5	REAL
3277	Condominio setembro	2023-10-06	683.92	2023-10-06	5	REAL
3278	UBR PENDING.UBER.COM	2023-10-21	15.18	2023-10-20	3	EURO
3279	UBR PENDING.UBER.COM	2023-10-21	5.93	2023-10-20	3	EURO
3280	UBER TRIP	2023-10-21	5.00	2023-10-20	3	EURO
3281	CONTINENTE BRAGA BRAGA	2023-10-21	53.03	2023-10-20	3	EURO
3282	Glovo 18OCT BRYLHJL81	2023-10-21	10.95	2023-10-20	3	EURO
3283	Glovo 17OCT BRSC1XH1Y	2023-10-21	10.95	2023-10-19	3	EURO
3284	Glovo 16OCT BRZCRFRH1	2023-10-21	10.95	2023-10-18	3	EURO
3285	UBR PENDING.UBER.COM	2023-10-21	3.60	2023-10-18	3	EURO
3286	UBR PENDING.UBER.COM	2023-10-21	3.50	2023-10-18	3	EURO
3287	UBR PENDING.UBER.COM	2023-10-21	5.31	2023-10-18	3	EURO
3288	UBR PENDING.UBER.COM	2023-10-21	3.94	2023-10-17	3	EURO
3289	UBR PENDING.UBER.COM	2023-10-21	3.51	2023-10-17	3	EURO
3290	BRASA RIO BRAGA PR	2023-10-21	13.40	2023-10-17	3	EURO
3291	Glovo 15OCT BRLRP49QJ	2023-10-21	10.05	2023-10-17	3	EURO
3292	Glovo 14OCT BRDFLVSDU	2023-10-21	9.00	2023-10-17	3	EURO
3293	Glovo 14OCT BRBP9KPSA	2023-10-21	10.95	2023-10-17	3	EURO
3294	Glovo 13OCT BRBJU3A3M	2023-10-21	10.95	2023-10-17	3	EURO
3295	HOSPITAL PRIV BRAGA 4715196 BRAGA	2023-10-21	40.00	2023-10-16	3	EURO
3296	Glovo 12OCT BR1YSP3CT	2023-10-21	10.95	2023-10-13	3	EURO
3297	Glovo 11OCT BR5W4P1LP	2023-10-21	10.95	2023-10-13	3	EURO
3298	UBR PENDING.UBER.COM	2023-10-21	3.50	2023-10-12	3	EURO
3299	UBR PENDING.UBER.COM	2023-10-21	3.93	2023-10-12	3	EURO
3300	Glovo 10OCT BRBYC1BK7	2023-10-21	10.95	2023-10-12	3	EURO
3301	Glovo 10OCT BRAQETLBJ	2023-10-21	13.75	2023-10-12	3	EURO
3302	DD PT10100825 VODAFONE PORTUG 07335462122	2023-10-21	63.86	2023-10-12	3	EURO
3303	Glovo 09OCT BRWYJUREL	2023-10-21	10.95	2023-10-11	3	EURO
3304	UBR PENDING.UBER.COM	2023-10-21	5.74	2023-10-10	3	EURO
3305	UBR PENDING.UBER.COM	2023-10-21	5.76	2023-10-10	3	EURO
3306	UBR PENDING.UBER.COM	2023-10-21	4.05	2023-10-10	3	EURO
3307	UBR PENDING.UBER.COM	2023-10-21	3.60	2023-10-10	3	EURO
3308	NOS CINEMAS BRAGA PQ BR	2023-10-21	6.60	2023-10-10	3	EURO
3309	NOS CINEMAS BRAGA PQ BR	2023-10-21	7.15	2023-10-10	3	EURO
3310	FNAC BRAGA BRAGA PR	2023-10-21	25.14	2023-10-10	3	EURO
3311	TOMATINO NOVA ARCADA BR	2023-10-21	7.95	2023-10-10	3	EURO
3312	CONTINENTE BRAGA BRAGA	2023-10-21	50.92	2023-10-10	3	EURO
3313	Glovo 07OCT BRYRDG5PK	2023-10-21	10.10	2023-10-10	3	EURO
3314	Glovo 06OCT BRU638LBL	2023-10-21	10.10	2023-10-10	3	EURO
3315	Glovo 06OCT BRFHLFYFJ	2023-10-21	10.95	2023-10-10	3	EURO
3316	Glovo 05OCT BRV1LNEYG	2023-10-21	10.95	2023-10-09	3	EURO
3317	IMPOSTO DE SELO 17.3.4	2023-10-21	0.21	2023-10-06	3	EURO
3318	COM. MANUTENCAO CONTA ORDENADO 092023	2023-10-21	5.20	2023-10-06	3	EURO
3319	Glovo 04OCT BR1DDWKLX	2023-10-21	10.95	2023-10-06	3	EURO
3322	Glovo 31AUG BRACZFGDZ	2023-10-21	15.92	2023-09-01	4	EURO
3323	Glovo GLOVO PRIME	2023-10-21	5.99	2023-09-03	4	EURO
3324	IBERIA 075142125194	2023-10-21	1685.95	2023-09-06	4	EURO
3325	Glovo 06SEP BRTH1PMZG	2023-10-21	22.75	2023-09-07	4	EURO
3326	Glovo 09SEP BRANKF2Q9	2023-10-21	26.38	2023-09-10	4	EURO
3327	Glovo 12SEP BRDXC77ZZ	2023-10-21	13.65	2023-09-13	4	EURO
3328	Glovo 15SEP BRYHLBNDM	2023-10-21	18.20	2023-09-16	4	EURO
3329	GlovoApp Portugal	2023-10-21	9.00	2023-09-17	4	EURO
3330	Glovo 23SEP BRPAWHLPF	2023-10-21	11.48	2023-09-24	4	EURO
3331	Glovo 23SEP BR8UH1HXX	2023-10-21	11.64	2023-09-24	4	EURO
3320	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2023-10-21	0.04	2023-10-06	3	EURO
3332	Glovo 25SEP BRKJYXB8Y	2023-10-21	10.95	2023-09-26	4	EURO
3333	Glovo 28SEP BRTPMPGVW	2023-10-21	10.95	2023-09-28	4	EURO
3334	Glovo 29SEP BRK1Y9CWT	2023-10-21	10.95	2023-09-30	4	EURO
3338	Only Fans	2023-10-21	8.70	2023-10-19	4	EURO
3339	Only Fans	2023-10-21	31.56	2023-10-20	4	EURO
3340	DA COMGAS 48353698	2023-10-21	10.92	2023-10-16	5	REAL
3341	DA VIVO FIXO 9324810660	2023-10-21	148.99	2023-10-16	5	REAL
3342	Glovo 01NOV BR7LDDSYA	2023-11-03	13.45	2023-11-03	3	EURO
3343	Glovo 01NOV BRNPZXSFD	2023-11-03	8.35	2023-11-03	3	EURO
3344	Glovo 31OCT BRFQ5MTN7	2023-11-03	10.05	2023-11-02	3	EURO
3345	Glovo 31OCT BRLLBBZBR	2023-11-03	10.95	2023-11-02	3	EURO
3346	Glovo 31OCT BRFFGBL16	2023-11-03	10.10	2023-11-02	3	EURO
3347	Com.Transf.credito nao SEPA+ Em Linha(desp.OUR)	2023-11-03	25.00	2023-11-01	3	EURO
3350	IVA  23%   s/Desp.SWIFT Ord.Pag.Ref.20232169917	2023-11-03	2.88	2023-11-01	3	EURO
3351	I.S.   4%  s/Com. OUR Ord. Pag. Ref.20232169917	2023-11-03	1.00	2023-11-01	3	EURO
3352	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20232169917	2023-11-03	0.70	2023-11-01	3	EURO
3353	Glovo 30OCT BRY7DWCJW	2023-11-03	10.95	2023-11-01	3	EURO
3354	Glovo 29OCT BRUXYQWFH	2023-11-03	11.49	2023-10-31	3	EURO
3357	CONTINENTE BRAGA BRAGA	2023-11-03	59.77	2023-10-31	3	EURO
3358	Glovo 27OCT BRU11GYQP	2023-11-03	9.20	2023-10-31	3	EURO
3359	Glovo 27OCT BRGDAVZBB	2023-11-03	10.95	2023-10-31	3	EURO
3360	Glovo 26OCT BR6QAVD1K	2023-11-03	15.79	2023-10-27	3	EURO
3361	Glovo 26OCT BRAXNGEQW	2023-11-03	10.95	2023-10-27	3	EURO
3362	LEV ATM 6251 CGD   Braga         C Com Nova Arc	2023-11-03	60.00	2023-10-27	3	EURO
3363	IMPOSTO DO SELO	2023-11-03	0.03	2023-10-27	3	EURO
3364	CUSTO DE SERVICO INTERNACIONAL	2023-11-03	0.85	2023-10-27	3	EURO
3365	WWW.EPCPLC.COM B USD TC   0.9450596	2023-11-03	22.19	2023-10-27	3	EURO
3366	Glovo 25OCT BRWGNAYBT	2023-11-03	9.00	2023-10-27	3	EURO
3367	Glovo 25OCT BR1QMLQW6	2023-11-03	10.95	2023-10-27	3	EURO
3368	DD PT34100781 EDP COMERCIAL C 16010011942146	2023-11-03	67.57	2023-10-27	3	EURO
3369	Glovo 24OCT BRX8ZVYCQ	2023-11-03	10.95	2023-10-26	3	EURO
3370	PAG SERV 21796/259625442 AGEREEMP.DE AGUAS,EFL	2023-11-03	21.03	2023-10-25	3	EURO
3371	Glovo 23OCT BRUK9Z61C	2023-11-03	10.95	2023-10-25	3	EURO
3374	VITAMINAS N ARCADA BRAG	2023-11-03	11.25	2023-10-24	3	EURO
3375	CONTINENTE BRAGA BRAGA	2023-11-03	21.34	2023-10-24	3	EURO
3376	Glovo 21OCT BR. UWB1Y	2023-11-03	10.10	2023-10-24	3	EURO
3377	Glovo 21OCT BRW9YU9CL	2023-11-03	13.45	2023-10-24	3	EURO
3378	Glovo 20OCT BR1LN6BUU	2023-11-03	14.29	2023-10-24	3	EURO
3379	Glovo 20OCT BRUJE36C1	2023-11-03	10.95	2023-10-24	3	EURO
3380	Glovo 19OCT BRLJMSGRJ	2023-11-03	10.95	2023-10-23	3	EURO
3381	Remessa Internacional	2023-11-03	7000.00	2023-11-03	3	REAL
3383	Glovo 11OCT BRECAUC1D	2023-11-03	15.79	2023-10-12	4	EURO
3384	OnlyFans	2023-11-03	29.20	2023-10-19	4	EURO
3387	OnlyFans	2023-11-03	11.69	2023-10-30	4	EURO
3388	Glovo GLOVO PRIME	2023-11-03	5.99	2023-11-03	4	EURO
3389	DA  ELETROPAULO 56301179	2023-11-03	21.20	2023-10-30	5	REAL
3390	01- IOF CAMBIO	2023-11-03	133.54	2023-11-03	5	REAL
3391	AMERICANAS *FIT IN MONTEIRO	2023-11-03	137.78	2023-10-01	6	REAL
3392	ALURA	2023-11-03	92.65	2023-10-01	6	REAL
3393	BLOX COBRANC*DESM 02/06	2023-11-03	342.32	2023-10-01	6	REAL
3394	Amazon Kindle Unltd	2023-11-03	19.90	2023-10-03	6	REAL
3395	AmazonPrimeBR	2023-11-03	14.90	2023-10-03	6	REAL
3396	ANUIDADE DIFERENCIADA 11/12	2023-11-03	30.00	2023-10-03	6	REAL
3397	Disney Plus	2023-11-03	33.90	2023-10-06	6	REAL
3398	NETFLIX.COM	2023-11-03	39.90	2023-10-11	6	REAL
3399	APPLE.COM/BILL	2023-11-03	14.90	2023-10-20	6	REAL
3400	DM*HELPHBOMAXCOM	2023-11-03	34.90	2023-10-21	6	REAL
3401	EBN *SPOTIFY	2023-11-03	21.90	2023-10-28	6	REAL
3403	IMPOSTO DE SELO 17.3.4	2023-11-12	0.21	2023-11-10	3	EURO
3404	COM. MANUTENCAO CONTA ORDENADO 102023	2023-11-12	5.20	2023-11-10	3	EURO
3405	Glovo 08NOV BRSCMHGNJ	2023-11-12	8.40	2023-11-10	3	EURO
3406	Glovo 08NOV BRBNX1E7A	2023-11-12	8.35	2023-11-10	3	EURO
3407	Glovo 07NOV BRE7PN6NQ	2023-11-12	10.95	2023-11-10	3	EURO
3408	UBR PENDING.UBER.COM	2023-11-12	1.75	2023-11-09	3	EURO
3409	UBR PENDING.UBER.COM	2023-11-12	1.84	2023-11-09	3	EURO
3410	Glovo 06NOV BRUHLXMCG	2023-11-12	10.95	2023-11-09	3	EURO
3411	UBR PENDING.UBER.COM	2023-11-12	4.14	2023-11-08	3	EURO
3412	UBR PENDING.UBER.COM	2023-11-12	3.53	2023-11-08	3	EURO
3413	UBR PENDING.UBER.COM	2023-11-12	5.77	2023-11-08	3	EURO
3414	UBR PENDING.UBER.COM	2023-11-12	5.68	2023-11-08	3	EURO
3415	C A MODAS BRAGA PR	2023-11-12	80.18	2023-11-08	3	EURO
3416	VITAMINAS BRAGA PQ BRAG	2023-11-12	11.25	2023-11-08	3	EURO
3419	CONTINENTE BRAGA BRAGA	2023-11-12	57.24	2023-11-07	3	EURO
3420	Glovo 04NOV BRHS1KLWL	2023-11-12	10.10	2023-11-07	3	EURO
3421	Glovo 03NOV BRNNF23ZZ	2023-11-12	10.95	2023-11-07	3	EURO
3402	Salario	\N	5494.00	2023-11-30	3	EURO
3418	Comissão Transferência a crédito SEPA+ Em Linha	2023-11-12	1.10	2023-11-08	3	EURO
3417	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2023-11-12	0.04	2023-11-08	3	EURO
3349	Com. Transf. crédito não SEPA+ Em Linha (SWIFT)	2023-11-03	12.50	2023-11-01	3	EURO
3348	Comissão Transf. a crédito não SEPA+ Em Linha	2023-11-03	17.50	2023-11-01	3	EURO
3422	Glovo 03NOV BRNAGXVTQ	2023-11-12	16.40	2023-11-07	3	EURO
3423	TRF P/ Lucinda dona da casa	2023-11-12	650.00	2023-11-07	3	EURO
3424	FARMACIA MADALENA 4700207 BRAGA	2023-11-12	17.24	2023-11-06	3	EURO
3425	HOSP PRIV BRAGA BRAGA	2023-11-12	287.37	2023-11-06	3	EURO
3426	COMPANHIA SANDES BRG BR	2023-11-12	5.97	2023-11-06	3	EURO
3427	UBR PENDING.UBER.COM	2023-11-12	4.20	2023-11-06	3	EURO
3428	UBR PENDING.UBER.COM	2023-11-12	3.68	2023-11-06	3	EURO
3429	Glovo 02NOV BRLN1TFMT	2023-11-12	8.90	2023-11-06	3	EURO
3430	Amazon	2023-11-12	71.28	2023-11-11	4	EURO
3431	Glovo Prime	2023-11-12	5.99	2023-11-03	4	EURO
3432	Pagamento fatura 11/2023	2023-11-03	783.05	2023-11-12	5	REAL
3433	INT PAG TIT 775324902000	2023-11-12	664.00	2023-11-03	5	REAL
3434	TAR PACOTE ITAU OUT/23	2023-11-12	71.90	2023-11-03	5	REAL
3435	PIX TRANSF AGENCIA09/11	2023-11-12	911.00	2023-11-09	5	REAL
3436	PAG SERV 21796/272295142 AGEREEMP.DE AGUAS,EFL	2023-12-26	19.83	2023-12-26	3	EURO
3437	DD PT10100825 VODAFONE PORTUG 07335462122	2023-12-26	61.07	2023-12-14	3	EURO
3438	IMPOSTO DE SELO 17.3.4	2023-12-26	0.21	2023-12-08	3	EURO
3439	COM. MANUTENCAO CONTA ORDENADO 112023	2023-12-26	5.20	2023-12-08	3	EURO
3442	TRF P/ Lucinda dona da casa	2023-12-26	650.00	2023-12-04	3	EURO
3445	MIGUELANGELGF1974.GMAI	2023-12-26	27.35	2023-11-28	3	EURO
3446	AREAS MADRID ES	2023-12-26	4.85	2023-11-28	3	EURO
3447	T4S01DL67 ARZABAL MARK	2023-12-26	17.50	2023-11-28	3	EURO
3448	DEPILMEN MADRID ES	2023-12-26	45.00	2023-11-28	3	EURO
3449	AREAS PORTUGAL SA MAIA	2023-12-26	8.20	2023-11-28	3	EURO
3451	Glovo 23NOV BR1NA11GS Lisbon PR	2023-12-26	10.95	2023-11-28	3	EURO
3452	PAG SERV 21796/266084342 AGEREEMP.DE AGUAS,EFL	2023-12-26	20.88	2023-11-27	3	EURO
3453	Glovo 22NOV BRZC11AWQ Lisbon PR	2023-12-26	10.95	2023-11-24	3	EURO
3454	DD PT34100781 EDP COMERCIALC 16010011942146	2023-12-26	82.49	2023-11-24	3	EURO
3455	Glovo 21NOV BR165WKX6 Lisbon PR	2023-12-26	8.40	2023-11-23	3	EURO
3456	Glovo 20NOV BR8LQMN91 Lisbon PR	2023-12-26	10.95	2023-11-23	3	EURO
3459	Glovo 19NOV BRH681JE1 Lisbon PR	2023-12-26	10.10	2023-11-21	3	EURO
3460	CONTINENTE BRAGA BRAGA	2023-12-26	35.62	2023-11-21	3	EURO
3461	Glovo 17NOV BRLLHPREJ Lisbon PR	2023-12-26	10.95	2023-11-21	3	EURO
3464	Glovo 15NOV BRNLMEVZN Lisbon PR	2023-12-26	10.95	2023-11-17	3	EURO
3465	FNAC BRAGA BRAGA PR	2023-12-26	22.13	2023-11-16	3	EURO
3468	Glovo 14NOV BRAXYLCA2 Lisbon PR	2023-12-26	10.95	2023-11-16	3	EURO
3471	HOSPITAL PRIV BRAGA 4715196 BRAGA	2023-12-26	362.03	2023-11-15	3	EURO
3472	Glovo 13NOV BRGC8ZSQH Lisbon PR	2023-12-26	10.95	2023-11-15	3	EURO
3477	CONTINENTE BRAGA BRAGA	2023-12-26	44.36	2023-11-15	3	EURO
3478	FNAC BRAGA BRAGA PR	2023-12-26	0.15	2023-11-15	3	EURO
3479	FNAC BRAGA BRAGA PR	2023-12-26	473.99	2023-11-15	3	EURO
3480	Glovo 12NOV BRADWTZRN Lisbon PR	2023-12-26	13.00	2023-11-15	3	EURO
3481	TRF P/ CLUB TENIS BRAGA	2023-12-26	42.00	2023-11-15	3	EURO
3482	Glovo 11NOV BRZCEL12W Lisbon PR	2023-12-26	9.60	2023-11-14	3	EURO
3483	Glovo 11NOV BRMQNH4HL Lisbon PR	2023-12-26	10.95	2023-11-14	3	EURO
3484	Glovo 10NOV BRLGLNXEL Lisbon PR	2023-12-26	16.26	2023-11-14	3	EURO
3485	Glovo 10NOV BREXV15P1 Lisbon PR	2023-12-26	10.95	2023-11-14	3	EURO
3486	Glovo 09NOV BRN2BBFAP Lisbon PR	2023-12-26	8.40	2023-11-14	3	EURO
3487	Glovo 08NOV BRY1LKVRW Lisbon PR	2023-12-26	10.95	2023-11-14	3	EURO
3488	DD PT10100825 VODAFONE PORTUG 07335462122	2023-12-26	61.07	2023-11-14	3	EURO
3489	Estorno Convenio	2023-12-26	324.71	2023-12-08	3	EURO
3490	ARTESANATO AEROPORTO	2023-12-26	31.00	2023-11-25	4	EURO
3491	O GAROTO	2023-12-26	16.00	2023-11-26	4	EURO
3492	AMAZON MARKETPLACE	2023-12-26	10.15	2023-12-01	4	EURO
3493	Glovo GLOVO PRIME	2023-12-26	5.99	2023-12-03	4	EURO
3494	Salario	\N	3500.00	2023-12-31	3	EURO
3495	EDP	2023-12-31	189.83	2023-12-28	3	EURO
3496	DA COMGAS 48353698	2023-12-31	10.92	2023-11-16	5	REAL
3497	DA VIVO FIXO 9324810660	2023-12-31	148.99	2023-11-16	5	REAL
3498	CASA NOVA CH2711	2023-12-31	13.00	2023-11-27	5	REAL
3499	FARMACIA CEN2711	2023-12-31	93.96	2023-11-27	5	REAL
3500	BAFFS CONGO27/11	2023-12-31	25.00	2023-11-27	5	REAL
3501	PAG*VARANDA27/11	2023-12-31	67.00	2023-11-27	5	REAL
3502	PAG*GUARUCO26/11	2023-12-31	215.14	2023-11-27	5	REAL
3503	CARREFOUR S26/11	2023-12-31	191.76	2023-11-27	5	REAL
3441	Comissão Transferência a crédito SEPA+ Em Linha	2023-12-26	1.10	2023-12-05	3	EURO
3470	Comissão Transferência a crédito SEPA+ Em Linha	2023-12-26	1.10	2023-11-16	3	EURO
3440	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2023-12-26	0.04	2023-12-05	3	EURO
3469	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2023-12-26	0.04	2023-11-16	3	EURO
3504	CARREFOUR S26/11	2023-12-31	10.00	2023-11-27	5	REAL
3505	BONITO ECOTO2811	2023-12-31	2161.00	2023-11-28	5	REAL
3506	RESTAURANTE 2811	2023-12-31	19.00	2023-11-28	5	REAL
3507	D B PERALTA28/11	2023-12-31	21.00	2023-11-28	5	REAL
3508	PAG Restaur28/11	2023-12-31	116.09	2023-11-28	5	REAL
3509	MERCADO VIL28/11	2023-12-31	31.00	2023-11-28	5	REAL
3510	PAG*ERONASS28/11	2023-12-31	35.00	2023-11-28	5	REAL
3511	BAGUETES PI28/11	2023-12-31	32.50	2023-11-28	5	REAL
3512	DA ELETROPAULO 56301179	2023-12-31	21.65	2023-11-29	5	REAL
3513	RESTAURANTE29/11	2023-12-31	46.20	2023-11-29	5	REAL
3514	BAGUETES PIL2911	2023-12-31	35.00	2023-11-29	5	REAL
3515	RECANTO ECOL3011	2023-12-31	16.00	2023-11-30	5	REAL
3516	CASA NOVA C01/12	2023-12-31	5.00	2023-12-01	5	REAL
3517	POUSADA GIR01/12	2023-12-31	16.00	2023-12-01	5	REAL
3518	ON IFOOD 0412	2023-12-31	29.98	2023-12-04	5	REAL
3519	PIX TRANSF FABIO Z03/12	2023-12-31	49.00	2023-12-04	5	REAL
3520	PIX QRS MARCOS KIYO04/12	2023-12-31	27.70	2023-12-04	5	REAL
3521	TAR PACOTE ITAU NOV/23	2023-12-31	71.90	2023-12-04	5	REAL
3522	ON IFD*RESTAURA0512	2023-12-31	25.48	2023-12-05	5	REAL
3523	SANTA CATAR05/12	2023-12-31	75.67	2023-12-05	5	REAL
3524	CDB CENTR05/12	2023-12-31	240.00	2023-12-05	5	REAL
3525	NEUPARK 06/12	2023-12-31	20.00	2023-12-06	5	REAL
3526	PARADA DO A06/12	2023-12-31	35.00	2023-12-06	5	REAL
3527	PAY IFOOD 06/12	2023-12-31	25.96	2023-12-06	5	REAL
3528	CARREFOUR S06/12	2023-12-31	188.51	2023-12-06	5	REAL
3529	PAY IFOOD 07/12	2023-12-31	20.99	2023-12-07	5	REAL
3530	PAG REFUGIO08/12	2023-12-31	40.98	2023-12-08	5	REAL
3531	VAMO TOMA U08/12	2023-12-31	65.30	2023-12-08	5	REAL
3532	PAY IFOOD 08/12	2023-12-31	55.90	2023-12-08	5	REAL
3533	PAG MANIADE11/12	2023-12-31	199.60	2023-12-11	5	REAL
3534	PAY IFOOD 11/12	2023-12-31	39.45	2023-12-11	5	REAL
3535	PAY IFOOD 10/12	2023-12-31	30.89	2023-12-11	5	REAL
3536	PAY IFOOD 09/12	2023-12-31	35.98	2023-12-11	5	REAL
3537	SAQUE 24H 900719816	2023-12-31	100.00	2023-12-11	5	REAL
3538	DROGARIA SA09/12	2023-12-31	25.99	2023-12-11	5	REAL
3539	VAMO TOMA U12/12	2023-12-31	72.02	2023-12-12	5	REAL
3540	PAY IFOOD 12/12	2023-12-31	25.94	2023-12-12	5	REAL
3541	PAY IFOOD 13/12	2023-12-31	25.94	2023-12-13	5	REAL
3542	PAY IFOOD 13/12	2023-12-31	30.89	2023-12-13	5	REAL
3543	MOBILEPAG TIT 7753249020	2023-12-31	664.00	2023-12-13	5	REAL
3544	RSCCSCARREFOUR S14/12	2023-12-31	200.57	2023-12-14	5	REAL
3545	PAY IFOOD 14/12	2023-12-31	30.89	2023-12-14	5	REAL
3546	DA COMGAS 48353698	2023-12-31	10.92	2023-12-14	5	REAL
3547	PAG*KRA 15/12	2023-12-31	92.00	2023-12-15	5	REAL
3548	BETO PAIXAO15/12	2023-12-31	40.00	2023-12-15	5	REAL
3549	PAY IFOOD 15/12	2023-12-31	43.33	2023-12-15	5	REAL
3550	DA VIVO FIXO 9324810660	2023-12-31	148.99	2023-12-15	5	REAL
3551	PAY IFOOD 17/12	2023-12-31	35.90	2023-12-18	5	REAL
3552	PAY HOTEL E RES18/12	2023-12-31	168.74	2023-12-18	5	REAL
3553	PAY CHEIRIN BAO18/12	2023-12-31	9.00	2023-12-18	5	REAL
3554	THE BAR BAR16/12	2023-12-31	106.40	2023-12-18	5	REAL
3555	PAY PAO DE MACA19/12	2023-12-31	65.80	2023-12-19	5	REAL
3556	PIX TRANSF ELIANA 20/12	2023-12-31	700.00	2023-12-20	5	REAL
3557	PAY IFOOD 20/12	2023-12-31	46.99	2023-12-20	5	REAL
3558	PAY MIRANTE PRA20/12	2023-12-31	40.00	2023-12-20	5	REAL
3559	EVO Thais Pa2112	2023-12-31	350.00	2023-12-21	5	REAL
3560	PAY IFD*JOSE RO21/12	2023-12-31	24.96	2023-12-21	5	REAL
3561	PAY HAMB DO SEU21/12	2023-12-31	37.50	2023-12-21	5	REAL
3562	PAY IFOOD 22/12	2023-12-31	25.94	2023-12-22	5	REAL
3563	PAY PAG*WALTERG22/12	2023-12-31	350.00	2023-12-22	5	REAL
3564	PAY QUINKAS BAR22/12	2023-12-31	124.40	2023-12-22	5	REAL
3565	ON IFD*50 340 42612	2023-12-31	20.98	2023-12-26	5	REAL
3566	ON IFD*MEIRE BO2312	2023-12-31	23.98	2023-12-26	5	REAL
3567	ON IFD*LANCHONE2312	2023-12-31	43.18	2023-12-26	5	REAL
3568	PAY CARREFOUR S23/12	2023-12-31	222.20	2023-12-26	5	REAL
3569	PAY COOP 07 IND26/12	2023-12-31	63.52	2023-12-26	5	REAL
3570	ON IFD*RESTAURA2712	2023-12-31	46.99	2023-12-27	5	REAL
3571	CINEMARK MO27/12	2023-12-31	86.00	2023-12-27	5	REAL
3572	CARREFOUR 382712	2023-12-31	249.40	2023-12-27	5	REAL
3573	ON IFD*VO LUIZA2812	2023-12-31	51.79	2023-12-28	5	REAL
3574	ON IFD*RESTAURA2812	2023-12-31	35.98	2023-12-28	5	REAL
3575	ON IFD*LANCHONE2812	2023-12-31	32.39	2023-12-28	5	REAL
3576	SACOMA POIN28/12	2023-12-31	14.18	2023-12-28	5	REAL
3577	CADILLAC BBQ2912	2023-12-31	201.30	2023-12-29	5	REAL
3578	PAY MARINHO VAL29/12	2023-12-31	20.00	2023-12-29	5	REAL
3579	ON 3012	2023-12-31	33.75	2024-01-02	5	REAL
3580	ON IFD*LANCHONE3012	2023-12-31	201.49	2024-01-02	5	REAL
3581	ON IFD*RESTAURA3112	2023-12-31	40.49	2024-01-02	5	REAL
3582	DA ELETROPAULO 56301179	2023-12-31	21.70	2024-01-02	5	REAL
3584	AMERICANAS *FIT IN 04/08 MONTEIRO	2023-12-31	137.78	2023-11-21	6	REAL
3585	ALURA 03/12 SAO PAULO BR	2023-12-31	92.65	2023-11-26	6	REAL
3586	BLOX COBRANC*DESM 03/06 COLOMBO BR	2023-12-31	342.32	2023-11-25	6	REAL
3587	ANUIDADE DIFERENCIADA 12/12	2023-12-31	30.00	2023-11-02	6	REAL
3588	Amazon Kindle Unltd SAO PAULO BR	2023-12-31	19.90	2023-11-03	6	REAL
3589	AmazonPrimeBR SAO PAULO BR	2023-12-31	14.90	2023-11-03	6	REAL
3590	Disney Plus SAO PAULO BR	2023-12-31	33.90	2023-11-06	6	REAL
3591	GOL LINHAS A*MRVH 01/05 SAO PAULO	2023-12-31	795.31	2023-11-09	6	REAL
3592	DECOLAR BARUERI BR	2023-12-31	116.71	2023-11-09	6	REAL
3593	NETFLIX.COM SAO PAULO BR	2023-12-31	39.90	2023-11-11	6	REAL
3594	APPLE.COM/BILL SAO PAULO BR	2023-12-31	14.90	2023-11-20	6	REAL
3595	DM*HELPHBOMAXCOM SAO PAULO BR	2023-12-31	34.90	2023-11-21	6	REAL
3596	UBER* TRIP OSASCO BR	2023-12-31	8.91	2023-11-26	6	REAL
3597	SERVICOS CLA*119657134 RIO DE JANE	2023-12-31	30.00	2023-11-26	6	REAL
3598	Uber *UBER *TRIP Sao Paulo BR	2023-12-31	34.96	2023-11-26	6	REAL
3599	Uber *UBER *TRIP Sao Paulo BR	2023-12-31	29.94	2023-11-27	6	REAL
3600	EBN *SPOTIFY CURITIBA BR	2023-12-31	21.90	2023-11-28	6	REAL
3601	ABISMO ANHUMAS BONITO BR	2023-12-31	1359.00	2023-11-28	6	REAL
3602	Pagamento fatura 12/2023	2023-12-01	3157.88	2023-12-31	5	REAL
3603	Glovo 1	2024-01-05	10.95	2024-01-04	3	EURO
3605	tarifa	2024-01-05	71.90	2024-01-03	5	REAL
3606	almoco	2024-01-05	63.50	2024-01-03	5	REAL
3609	AMERICANAS *FIT IN 05/08 MONTEIRO	2024-01-27	137.78	2023-12-01	6	REAL
3610	ALURA 04/12	2024-01-27	92.65	2023-11-29	6	REAL
3611	BLOX COBRANC*DESM 04/06	2024-01-27	342.32	2023-11-29	6	REAL
3612	GOL LINHAS A*MRVH 02/05	2024-01-27	795.29	2023-11-30	6	REAL
3613	ANUIDADE DIFERENCIADA 01/12	2024-01-27	17.00	2023-11-30	6	REAL
3614	UBER* TRIP	2024-01-27	88.80	2023-12-01	6	REAL
3615	ME PAY SOLUCOES FINANC NOVA LIMA	2024-01-27	84.68	2023-12-01	6	REAL
3616	LOCALIZA RAC ACCAE0 SAO CAETANO	2024-01-27	3931.20	2023-12-02	6	REAL
3617	ZIG THE GLOBAL FUNTECH	2024-01-27	261.03	2023-12-02	6	REAL
3618	PAG*PontoD	2024-01-27	20.00	2023-12-02	6	REAL
3619	Uber *UBER *TRIP	2024-01-27	29.93	2023-12-02	6	REAL
3620	Amazon Kindle Unltd	2024-01-27	19.90	2023-12-03	6	REAL
3621	AmazonPrimeBR	2024-01-27	14.90	2023-12-03	6	REAL
3622	MISURINA CAFE LTDA EPP	2024-01-27	10.90	2023-12-03	6	REAL
3623	MAC PARK	2024-01-27	20.00	2023-12-05	6	REAL
3624	CARREFOUR PAN	2024-01-27	216.81	2023-12-05	6	REAL
3625	Disney Plus	2024-01-27	33.90	2023-12-06	6	REAL
3626	Microsoft*Store	2024-01-27	3.45	2023-12-07	6	REAL
3627	Uber *UBER *TRIP	2024-01-27	39.94	2023-12-08	6	REAL
3628	NETFLIX ENTRETENIMENTO	2024-01-27	39.90	2023-12-11	6	REAL
3629	UBER* TRIP	2024-01-27	24.92	2023-12-12	6	REAL
3630	AMAZON MARKETPLACE 01/10	2024-01-27	82.12	2023-12-14	6	REAL
3631	CARREFOUR PAN	2024-01-27	218.55	2023-12-16	6	REAL
3632	APPLE.COM/BILL	2024-01-27	21.90	2023-12-20	6	REAL
3633	DM*HELPHBOMAXCOM	2024-01-27	34.90	2023-12-21	6	REAL
3634	Uber *UBER *TRIP	2024-01-27	24.97	2023-12-22	6	REAL
3635	PAG*XsollaEpic	2024-01-27	28.99	2023-12-24	6	REAL
3636	SERVICOS CLA*119657134	2024-01-27	20.00	2023-12-27	6	REAL
3637	EBN*SPOTIFY	2024-01-27	21.90	2023-12-28	6	REAL
3638	LOCALIZA RAC ACCAE0	2024-01-27	4068.96	2023-12-01	6	REAL
3639	Pagamento fatura 01/2024	2024-01-11	10747.59	2024-01-27	5	REAL
3640	PIX TRANSF LOCALIZ09/01	2024-01-27	3749.82	2024-01-09	5	REAL
3641	TED 033.1800.DEBORA B E	2024-01-27	80.40	2024-01-02	5	REAL
3642	PIX TRANSF NATALLI16/01	2024-01-27	49.00	2024-01-16	5	REAL
3643	RSCSSNOVA SANTA 02/01	2024-01-27	128.00	2024-01-02	5	REAL
3644	PAY  MERCADO MAX02/01	2024-01-27	31.47	2024-01-02	5	REAL
3645	TED INTcba98176	2024-01-27	880.00	2024-01-08	5	REAL
3646	DA  VIVO FIXO 9324810660	2024-01-27	148.99	2024-01-15	5	REAL
3647	PAG TIT INT 775324902000	2024-01-27	665.00	2024-01-15	5	REAL
3648	DA  COMGAS 48353698	2024-01-27	14.53	2024-01-16	5	REAL
3649	DA  ELETROPAULO 56301179	2024-01-27	62.73	2024-01-29	5	REAL
3651	Saque	2024-01-27	100.00	2024-01-19	4	EURO
3652	Glovo 1	2024-01-27	12.95	2024-01-19	4	EURO
3653	Glovo 2	2024-01-27	13.75	2024-01-04	4	EURO
3654	Glovo Prime	2024-01-27	5.99	2024-01-03	4	EURO
3655	Glovo 29JAN BR5BSLFKD Lisbon ES	2024-04-29	10.95	2024-01-31	3	EURO
3656	UBER TRIP	2024-04-29	6.04	2024-01-30	3	EURO
3657	UBR PENDING.UBER.COM	2024-04-29	3.72	2024-01-30	3	EURO
3658	UBR PENDING.UBER.COM	2024-04-29	5.94	2024-01-30	3	EURO
3659	UBR PENDING.UBER.COM	2024-04-29	4.05	2024-01-30	3	EURO
3660	Glovo 28JAN BRFAPVEG1 Lisbon ES	2024-04-29	10.00	2024-01-30	3	EURO
3661	CORTES DE LISBOA BRAGA	2024-04-29	16.00	2024-01-30	3	EURO
3662	PARQUE CAFETARIA BRAGA	2024-04-29	2.20	2024-01-30	3	EURO
3663	CONTINENTE BRAGA BRAGA	2024-04-29	57.05	2024-01-30	3	EURO
3664	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-01-30	3	EURO
3665	UBR PENDING.UBER.COM	2024-04-29	2.45	2024-01-30	3	EURO
3666	Glovo 26JAN BRKWRUCXP Lisbon ES	2024-04-29	10.95	2024-01-30	3	EURO
3667	PAG SERV 21796/279932442 AGEREEMP.DE AGUAS,EFL	2024-04-29	19.08	2024-01-29	3	EURO
3668	TOMATINO NOVA ARCADABRAGA	2024-04-29	8.20	2024-01-29	3	EURO
3669	IMPOSTO DO SELO	2024-04-29	0.92	2024-01-26	3	EURO
3670	BCP4758828DISPONIBILIZACAO CARTAO DEBITO  47588	2024-04-29	23.00	2024-01-26	3	EURO
3671	Glovo 25JAN BRGRUKZHP	2024-04-29	10.95	2024-01-26	3	EURO
3672	Glovo 24JAN BR9RWURUD	2024-04-29	17.25	2024-01-26	3	EURO
3673	Glovo 24JAN BRCGDCDTT	2024-04-29	10.95	2024-01-26	3	EURO
3674	UBR PENDING.UBER.COM	2024-04-29	2.66	2024-01-25	3	EURO
3675	UBR PENDING.UBER.COM	2024-04-29	2.45	2024-01-25	3	EURO
3676	Glovo 23JAN BRAZZZ1HK	2024-04-29	16.69	2024-01-25	3	EURO
3677	Glovo 23JAN BRJYYKBF8	2024-04-29	10.95	2024-01-25	3	EURO
3678	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-04-29	28.24	2024-01-25	3	EURO
3679	Glovo 22JAN BRY1KWJ7G	2024-04-29	10.95	2024-01-24	3	EURO
3680	UBR PENDING.UBER.COM	2024-04-29	5.93	2024-01-23	3	EURO
3681	UBR PENDING.UBER.COM	2024-04-29	5.98	2024-01-23	3	EURO
3682	Glovo 21JAN BRKV7F6KX	2024-04-29	12.35	2024-01-23	3	EURO
3683	CONTINENTE BRAGA BRAGA	2024-04-29	51.87	2024-01-23	3	EURO
3684	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-01-23	3	EURO
3685	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-01-23	3	EURO
3686	Glovo 19JAN BRP7ZJYB1	2024-04-29	17.60	2024-01-23	3	EURO
3687	Glovo 18JAN BRVSKPCMK	2024-04-29	15.85	2024-01-19	3	EURO
3688	Glovo 18JAN BRMNDYW5V	2024-04-29	10.95	2024-01-19	3	EURO
3689	Glovo 17JAN BRFE5G19B	2024-04-29	9.70	2024-01-19	3	EURO
3690	Glovo 17JAN BRX1LRJ1M	2024-04-29	10.95	2024-01-19	3	EURO
3691	Glovo 16JAN BRA1NSCKG	2024-04-29	10.95	2024-01-18	3	EURO
3778	UBR PENDING.UBER.COM	2024-04-29	5.98	2024-02-13	3	EURO
3779	UBR PENDING.UBER.COM	2024-04-29	5.95	2024-02-13	3	EURO
3693	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20240126417	2024-04-29	0.04	2024-01-17	3	EURO
3694	Glovo 15JAN BRKXJLKPN	2024-04-29	8.80	2024-01-17	3	EURO
3695	UBR PENDING.UBER.COM	2024-04-29	5.96	2024-01-16	3	EURO
3696	UBR PENDING.UBER.COM	2024-04-29	5.95	2024-01-16	3	EURO
3697	Glovo 14JAN BR271E6W1	2024-04-29	10.00	2024-01-16	3	EURO
3698	CONTINENTE BRAGA BRAGA	2024-04-29	0.10	2024-01-16	3	EURO
3699	CONTINENTE BRAGA BRAGA	2024-04-29	37.07	2024-01-16	3	EURO
3700	Glovo 13JAN BRZMDCYZJ	2024-04-29	12.00	2024-01-16	3	EURO
3701	Glovo 12JAN BR4NALCAF	2024-04-29	14.70	2024-01-16	3	EURO
3702	Glovo 12JAN BRWZDPGA5	2024-04-29	10.95	2024-01-16	3	EURO
3703	Glovo 12JAN BRKZ8S5WX	2024-04-29	10.05	2024-01-16	3	EURO
3704	DD PT10100825 VODAFONE PORTUG 07335462122	2024-04-29	121.59	2024-01-16	3	EURO
3705	UBR PENDING.UBER.COM	2024-04-29	5.92	2024-01-12	3	EURO
3706	UBR PENDING.UBER.COM	2024-04-29	5.91	2024-01-12	3	EURO
3707	WORTEN BRAGA NOVA BRAGA	2024-04-29	79.99	2024-01-12	3	EURO
3708	Glovo 11JAN BRY7B6X38	2024-04-29	11.20	2024-01-12	3	EURO
3709	Glovo 11JAN BRV99HPKL	2024-04-29	10.95	2024-01-12	3	EURO
3710	IMPOSTO DE SELO 17.3.4	2024-04-29	0.21	2024-01-15	3	EURO
3711	COM. MANUTENCAO CONTA ORDENADO 122023	2024-04-29	5.20	2024-01-15	3	EURO
3712	Glovo 10JAN BRBLU11SP	2024-04-29	10.95	2024-01-12	3	EURO
3713	MEDIA MARKT BRAGA BRAGA	2024-04-29	98.00	2024-01-11	3	EURO
3714	UBR PENDING.UBER.COM	2024-04-29	8.97	2024-01-11	3	EURO
3715	UBR PENDING.UBER.COM	2024-04-29	5.91	2024-01-11	3	EURO
3716	Glovo 09JAN BR1P7UKWU	2024-04-29	10.95	2024-01-11	3	EURO
3717	Glovo 08JAN BRGBUR9M6	2024-04-29	10.95	2024-01-10	3	EURO
3720	PINGO DOCE BRAGA BRAGA	2024-04-29	8.65	2024-01-09	3	EURO
3721	UBR PENDING.UBER.COM	2024-04-29	4.01	2024-01-09	3	EURO
3722	UBR PENDING.UBER.COM	2024-04-29	3.52	2024-01-09	3	EURO
3723	UBR PENDING.UBER.COM	2024-04-29	5.72	2024-01-09	3	EURO
3724	Glovo 07JAN BRASX3BTD	2024-04-29	9.90	2024-01-09	3	EURO
3725	MUNDO DO CAFE BRAGA PR	2024-04-29	4.70	2024-01-09	3	EURO
3726	CONTINENTE BRAGA BRAGA	2024-04-29	70.82	2024-01-09	3	EURO
3727	Glovo 06JAN BR8NNPWMB	2024-04-29	10.80	2024-01-09	3	EURO
3728	Glovo 06JAN BRKRTC5RL	2024-04-29	8.30	2024-01-09	3	EURO
3729	Glovo 05JAN BRM2E33SA	2024-04-29	10.95	2024-01-09	3	EURO
3730	Glovo 05JAN BRGLDMSL1	2024-04-29	10.05	2024-01-09	3	EURO
3731	TRF P/ Lucinda dona da casa	2024-04-29	650.00	2024-01-08	3	EURO
3733	Cobrir Conta	\N	300.00	2024-01-17	3	EURO
3734	Cobrir Conta	\N	400.00	2024-02-26	3	EURO
3735	Estorno Seguro Saude	2024-04-29	324.69	2024-02-12	3	EURO
3736	LEV ATM 8281 CCAM  PORTO Shopping Domus	2024-04-29	60.00	2024-02-29	3	EURO
3737	Glovo 27FEB BR1C2KBMA	2024-04-29	8.40	2024-02-29	3	EURO
3738	Glovo 27FEB BRZPLC3EA	2024-04-29	10.95	2024-02-29	3	EURO
3739	Glovo 26FEB BRJ1LV1QX	2024-04-29	10.95	2024-02-28	3	EURO
3740	Glovo 24FEB BRVAEXZES	2024-04-29	13.90	2024-02-27	3	EURO
3741	Glovo 24FEB BR5F8YKW7	2024-04-29	8.30	2024-02-27	3	EURO
3742	WORTEN BRAGA FROSSOS PT	2024-04-29	59.99	2024-02-27	3	EURO
3743	UBR PENDING.UBER.COM	2024-04-29	4.06	2024-02-27	3	EURO
3744	UBR PENDING.UBER.COM	2024-04-29	3.90	2024-02-27	3	EURO
3745	UBR PENDING.UBER.COM	2024-04-29	4.99	2024-02-27	3	EURO
3746	UBR PENDING.UBER.COM	2024-04-29	6.91	2024-02-27	3	EURO
3747	CONTINENTE BRAGA BRAGA	2024-04-29	60.54	2024-02-27	3	EURO
3748	Glovo 23FEB BRAFLGBMG	2024-04-29	9.80	2024-02-27	3	EURO
3749	Glovo 23FEB BRLC1CSGU	2024-04-29	12.95	2024-02-27	3	EURO
3750	DD PT34100781 EDP COMERCIALC 16010011942146	2024-04-29	172.93	2024-02-27	3	EURO
3752	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20240405595	2024-04-29	0.04	2024-02-26	3	EURO
3753	Glovo 22FEB BR5223VRJ	2024-04-29	10.95	2024-02-23	3	EURO
3754	UBR PENDING.UBER.COM	2024-04-29	4.49	2024-02-23	3	EURO
3755	UBR PENDING.UBER.COM	2024-04-29	4.61	2024-02-23	3	EURO
3756	Glovo 21FEB BRWJ6QGA2	2024-04-29	10.95	2024-02-23	3	EURO
3757	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-22	3	EURO
3758	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-22	3	EURO
3759	Glovo 20FEB BRWNUZ4HG	2024-04-29	8.50	2024-02-22	3	EURO
3760	Glovo 19FEB BR1DYB1JV	2024-04-29	11.75	2024-02-21	3	EURO
3761	Glovo 18FEB BRLJVXPZA	2024-04-29	8.30	2024-02-20	3	EURO
3762	Glovo 17FEB BRQUYXEK8	2024-04-29	8.90	2024-02-20	3	EURO
3763	UBR PENDING.UBER.COM	2024-04-29	5.99	2024-02-20	3	EURO
3764	UBR PENDING.UBER.COM	2024-04-29	5.94	2024-02-20	3	EURO
3765	CONTINENTE BRAGA BRAGA	2024-04-29	66.57	2024-02-20	3	EURO
3766	Glovo 15FEB BRU5GKLHR	2024-04-29	9.70	2024-02-16	3	EURO
3767	Glovo 15FEB BR5TQ7LV2	2024-04-29	12.00	2024-02-16	3	EURO
3768	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-16	3	EURO
3769	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-16	3	EURO
3770	SUMUP OKPC BRAGA PT	2024-04-29	25.00	2024-02-16	3	EURO
3771	Glovo 14FEB BRFEZZR35	2024-04-29	8.30	2024-02-16	3	EURO
3772	Glovo 14FEB BRNAMVPB6	2024-04-29	13.75	2024-02-16	3	EURO
3773	Glovo 13FEB BRCAPZQ1J	2024-04-29	10.85	2024-02-15	3	EURO
3774	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-14	3	EURO
3775	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-14	3	EURO
3776	Glovo 12FEB BRRTMSBXM	2024-04-29	13.13	2024-02-14	3	EURO
3777	DD PT10100825 VODAFONE PORTUG 07335462122	2024-04-29	65.79	2024-02-14	3	EURO
3719	Comissão Transferência a crédito SEPA+ Em Linha	2024-04-29	1.10	2024-01-08	3	EURO
3751	Comissão Transferência a crédito SEPA+ Em Linha	2024-04-29	1.10	2024-02-26	3	EURO
3718	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-04-29	0.04	2024-01-08	3	EURO
3780	Glovo 11FEB BRN7UHVWM	2024-04-29	8.30	2024-02-13	3	EURO
3781	CONTINENTE BRAGA BRAGA	2024-04-29	75.70	2024-02-13	3	EURO
3782	Glovo 09FEB BRE2GDLHR	2024-04-29	9.09	2024-02-13	3	EURO
3783	Glovo 09FEB BR1TZCUZ2	2024-04-29	11.75	2024-02-13	3	EURO
3784	Glovo 08FEB BRUSP4WNZ	2024-04-29	8.70	2024-02-12	3	EURO
3785	PAG SERV 21796/285866542 AGEREEMP.DE AGUAS,EFL	2024-04-29	21.34	2024-02-12	3	EURO
3786	IMPOSTO DE SELO 17.3.4	2024-04-29	0.21	2024-02-12	3	EURO
3787	COM. MANUTENCAO CONTA ORDENADO 012024	2024-04-29	5.20	2024-02-12	3	EURO
3788	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-09	3	EURO
3789	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-09	3	EURO
3790	Glovo 07FEB BRACLLY2T	2024-04-29	11.60	2024-02-09	3	EURO
3791	Glovo 07FEB BR911ZHNG	2024-04-29	8.60	2024-02-09	3	EURO
3792	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-08	3	EURO
3793	UBR PENDING.UBER.COM	2024-04-29	3.61	2024-02-08	3	EURO
3794	Glovo 06FEB BRYBZQYWJ	2024-04-29	13.75	2024-02-08	3	EURO
3795	Glovo 06FEB BRDPABHYE	2024-04-29	10.95	2024-02-08	3	EURO
3796	Glovo 05FEB BRNWCERCL	2024-04-29	8.00	2024-02-07	3	EURO
3799	UBR PENDING.UBER.COM	2024-04-29	5.92	2024-02-06	3	EURO
3800	UBR PENDING.UBER.COM	2024-04-29	5.99	2024-02-06	3	EURO
3801	Glovo 04FEB BRFVK9ABE	2024-04-29	9.90	2024-02-06	3	EURO
3802	CONTINENTE BRAGA BRAGA	2024-04-29	44.12	2024-02-06	3	EURO
3803	Glovo 03FEB BRPKSRJ81	2024-04-29	12.70	2024-02-06	3	EURO
3804	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-06	3	EURO
3805	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-06	3	EURO
3806	Glovo 02FEB BR3QVVK7W	2024-04-29	11.64	2024-02-06	3	EURO
3807	Glovo 02FEB BRYNL11BN	2024-04-29	12.95	2024-02-06	3	EURO
3808	TRF P/ Lucinda dona da casa	2024-04-29	650.00	2024-02-05	3	EURO
3809	Glovo 01FEB BRET1QX14	2024-04-29	10.95	2024-02-05	3	EURO
3810	Glovo 01FEB BRNT1WZFM	2024-04-29	10.14	2024-02-05	3	EURO
3811	Glovo 01FEB BREGUDLSJ	2024-04-29	14.95	2024-02-05	3	EURO
3812	Glovo 31JAN BRWLN1TFU	2024-04-29	9.70	2024-02-02	3	EURO
3813	Glovo 31JAN BRW6ERKFE	2024-04-29	10.95	2024-02-02	3	EURO
3814	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-02-01	3	EURO
3815	UBR PENDING.UBER.COM	2024-04-29	3.74	2024-02-01	3	EURO
3816	Glovo 30JAN BR7PF9FMM	2024-04-29	9.50	2024-02-01	3	EURO
3817	Glovo 30JAN BRSQ3MHJ9	2024-04-29	10.95	2024-02-01	3	EURO
3972	Glovo GLOVO PRIME	2024-04-29	5.99	2024-02-03	4	EURO
3973	Glovo GLOVO PRIME	2024-04-29	5.99	2024-03-03	4	EURO
3974	Avis RentACar	2024-04-29	241.34	2024-03-08	4	EURO
3975	ONLY FANS	2024-04-29	7.92	2024-03-09	4	EURO
3976	ONLY FANS	2024-04-29	11.31	2024-03-09	4	EURO
3977	ONLY FANS	2024-04-29	5.64	2024-03-19	4	EURO
3978	Avis RentACar	2024-04-29	34.93	2024-03-30	4	EURO
3979	Glovo GLOVO PRIME	2024-04-29	5.99	2024-04-03	4	EURO
3980	Avis RentACar	2024-04-29	392.91	2024-04-05	4	EURO
3981	Avis RentACar	2024-04-29	17.67	2024-04-27	4	EURO
3798	Comissão Transferência a crédito SEPA+ Em Linha	2024-04-29	1.10	2024-02-05	3	EURO
3797	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-04-29	0.04	2024-02-05	3	EURO
3819	Glovo 27MAR BRLLVSDMK	2024-04-29	11.00	2024-03-28	3	EURO
3820	Glovo 27MAR BRZVKSGNL	2024-04-29	8.30	2024-03-28	3	EURO
3821	Glovo 27MAR BRLQ5LZ5Z	2024-04-29	10.95	2024-03-28	3	EURO
3822	Glovo 26MAR BR7LTJ1XD	2024-04-29	10.95	2024-03-28	3	EURO
3823	Glovo 25MAR BR1R3FNC6	2024-04-29	10.95	2024-03-27	3	EURO
3824	UBR PENDING.UBER.COM	2024-04-29	5.93	2024-03-26	3	EURO
3825	UBR PENDING.UBER.COM	2024-04-29	5.94	2024-03-26	3	EURO
3826	Glovo 24MAR BRYNMPLC3	2024-04-29	14.00	2024-03-26	3	EURO
3827	CONTINENTE BRAGA BRAGA	2024-04-29	75.58	2024-03-26	3	EURO
3828	Glovo 23MAR BR4L6RLUB	2024-04-29	10.15	2024-03-26	3	EURO
3829	Glovo 22MAR BRJCLPKCU	2024-04-29	13.55	2024-03-26	3	EURO
3830	FRIGIDEIRAS DA PRC BRAG	2024-04-29	2.00	2024-03-22	3	EURO
3831	FRIGIDEIRAS DA PRC BRAG	2024-04-29	4.70	2024-03-22	3	EURO
3832	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-03-22	3	EURO
3833	Glovo 21MAR BRFMXGMMY	2024-04-29	8.30	2024-03-22	3	EURO
3834	Glovo 20MAR BRA14JQ4E	2024-04-29	15.90	2024-03-22	3	EURO
3835	Glovo 20MAR BRZG2EFVR	2024-04-29	10.95	2024-03-22	3	EURO
3836	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-04-29	153.78	2024-03-22	3	EURO
3837	UBR PENDING.UBER.COM	2024-04-29	3.55	2024-03-21	3	EURO
3838	BOLT.EU O 2403191832 Tallinn EE	2024-04-29	3.71	2024-03-21	3	EURO
3839	Glovo 19MAR BRN7KYTCR	2024-04-29	10.95	2024-03-21	3	EURO
3840	Glovo 18MAR BRJCLVLQL	2024-04-29	10.95	2024-03-20	3	EURO
3841	UBR PENDING.UBER.COM	2024-04-29	5.98	2024-03-19	3	EURO
3842	UBR PENDING.UBER.COM	2024-04-29	5.90	2024-03-19	3	EURO
3843	Glovo 17MAR BRDYV1LZ1	2024-04-29	13.78	2024-03-19	3	EURO
3844	IKEA BRAGA CAIXAS ECO B	2024-04-29	9.78	2024-03-19	3	EURO
3845	Glovo 16MAR BRMAE1EJZ	2024-04-29	8.30	2024-03-19	3	EURO
3846	LIVRARIA BERTRAND BRAGA	2024-04-29	22.90	2024-03-19	3	EURO
3847	UBR PENDING.UBER.COM	2024-04-29	5.99	2024-03-19	3	EURO
3848	UBR PENDING.UBER.COM	2024-04-29	5.90	2024-03-19	3	EURO
3849	CONTINENTE BRAGA BRAGA	2024-04-29	40.27	2024-03-19	3	EURO
3850	Glovo 15MAR BRJ39PNT8	2024-04-29	10.95	2024-03-19	3	EURO
3851	Glovo 14MAR BRSCT4UA4	2024-04-29	10.95	2024-03-15	3	EURO
3852	Glovo 13MAR BREV9PR59	2024-04-29	10.95	2024-03-15	3	EURO
3853	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-03-14	3	EURO
3854	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-03-14	3	EURO
3855	Glovo 12MAR BRCVUAMMA	2024-04-29	10.95	2024-03-14	3	EURO
3856	PINGO DOCE BRAGA BRAGA	2024-04-29	10.08	2024-03-13	3	EURO
3857	UBR PENDING.UBER.COM	2024-04-29	3.75	2024-03-13	3	EURO
3858	UBR PENDING.UBER.COM	2024-04-29	4.20	2024-03-13	3	EURO
3859	Glovo 11MAR BRPMTZLD1	2024-04-29	10.00	2024-03-13	3	EURO
3860	DD PT10100825 VODAFONE PORTUG 07335462122	2024-04-29	71.40	2024-03-13	3	EURO
3861	UBR PENDING.UBER.COM	2024-04-29	5.95	2024-03-12	3	EURO
3862	UBR PENDING.UBER.COM	2024-04-29	5.94	2024-03-12	3	EURO
3863	CONTINENTE BRAGA BRAGA	2024-04-29	77.24	2024-03-12	3	EURO
3864	Glovo 10MAR BRVLDLKME	2024-04-29	11.60	2024-03-12	3	EURO
3865	Glovo 09MAR BRUVEWZQY	2024-04-29	8.30	2024-03-12	3	EURO
3866	Glovo 09MAR BRETS1R2X	2024-04-29	14.90	2024-03-12	3	EURO
3867	Glovo 08MAR BRSSTJRR7	2024-04-29	10.95	2024-03-12	3	EURO
3868	Glovo 07MAR BRT5CRR1W	2024-04-29	10.95	2024-03-08	3	EURO
3869	IMPOSTO DE SELO 17.3.4	2024-04-29	0.21	2024-03-11	3	EURO
3870	COM. MANUTENCAO CONTA ORDENADO 022024	2024-04-29	5.20	2024-03-11	3	EURO
3871	Glovo 06MAR BRW81GYAM	2024-04-29	10.95	2024-03-08	3	EURO
3872	Glovo 05MAR BRA1YA169	2024-04-29	9.16	2024-03-07	3	EURO
3873	Glovo 05MAR BRLLTSWY5	2024-04-29	10.95	2024-03-07	3	EURO
3876	Glovo 04MAR BRUTKLVSH	2024-04-29	10.95	2024-03-06	3	EURO
3877	LEV ATM 8281 BCP   Braga         Rua Bernardo S	2024-04-29	100.00	2024-03-05	3	EURO
3878	TRF P/ Lucinda dona da casa	2024-04-29	650.00	2024-03-05	3	EURO
3879	BRAGA RIO LOJA 306 BRAG	2024-04-29	14.10	2024-03-05	3	EURO
3880	TOMATINO NOVA ARCADA BR	2024-04-29	8.20	2024-03-05	3	EURO
3881	Glovo 02MAR BRXU49SL2	2024-04-29	10.05	2024-03-05	3	EURO
3882	CONTINENTE BRAGA BRAGA	2024-04-29	66.85	2024-03-05	3	EURO
3883	Glovo 01MAR BRUB1VEW7	2024-04-29	10.95	2024-03-05	3	EURO
3884	Glovo 29FEB BRD31EDZZ	2024-04-29	8.45	2024-03-01	3	EURO
3885	Glovo 29FEB BRSNSAY98	2024-04-29	10.95	2024-03-01	3	EURO
3886	JERONYMO DOMUS TRIND PO	2024-04-29	6.30	2024-03-01	3	EURO
3887	Glovo 28FEB BRLKTBX7M	2024-04-29	9.16	2024-03-01	3	EURO
3888	Glovo 28FEB BRALQWYLX	2024-04-29	10.95	2024-03-01	3	EURO
3818	Salário Fevereiro 2024	2024-04-29	3500.00	2024-02-29	3	EURO
3889	Salário Março 2024	2024-04-29	3500.00	2024-03-31	3	EURO
3875	Comissão Transferência a crédito SEPA+ Em Linha	2024-04-29	1.10	2024-03-05	3	EURO
3874	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-04-29	0.04	2024-03-05	3	EURO
3891	Glovo 24APR BRGNA1EPC	2024-04-29	11.00	2024-04-26	3	EURO
3892	Glovo 24APR BRAKKMD45	2024-04-29	8.25	2024-04-26	3	EURO
3893	PARQUE CAFETARIA BRAGA	2024-04-29	5.10	2024-04-25	3	EURO
3894	FNAC BRAGA BRAGA PT	2024-04-29	105.13	2024-04-25	3	EURO
3895	UBR PENDING.UBER.COM	2024-04-29	4.15	2024-04-25	3	EURO
3896	UBR PENDING.UBER.COM	2024-04-29	3.89	2024-04-25	3	EURO
3897	TOMATINO BRAGA PARQU BR	2024-04-29	8.20	2024-04-25	3	EURO
3898	Glovo 23APR BR48CM1A4	2024-04-29	10.95	2024-04-25	3	EURO
3899	UBR PENDING.UBER.COM	2024-04-29	4.00	2024-04-24	3	EURO
3900	UBR PENDING.UBER.COM	2024-04-29	3.72	2024-04-24	3	EURO
3901	Glovo 22APR BRN6YH68T	2024-04-29	10.95	2024-04-24	3	EURO
3902	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-04-29	171.37	2024-04-24	3	EURO
3903	UBER TRIP	2024-04-29	5.97	2024-04-23	3	EURO
3904	UBR PENDING.UBER.COM	2024-04-29	5.91	2024-04-23	3	EURO
3905	UBER TRIP	2024-04-29	8.29	2024-04-23	3	EURO
3906	UBER TRIP	2024-04-29	3.61	2024-04-23	3	EURO
3907	Glovo 21APR BRFLHRKEH	2024-04-29	8.16	2024-04-23	3	EURO
3908	Glovo 21APR BRLHQSZHB	2024-04-29	8.30	2024-04-23	3	EURO
3909	CONTINENTE BRAGA BRAGA	2024-04-29	72.35	2024-04-23	3	EURO
3910	CORTES DE LISBOA BRAGA	2024-04-29	16.00	2024-04-23	3	EURO
3911	UBER TRIP HELP.UBER.COMNL	2024-04-29	4.34	2024-04-23	3	EURO
3912	UBER TRIP HELP.UBER.COMNL	2024-04-29	3.87	2024-04-23	3	EURO
3913	Glovo 19APR BRCESGCF1	2024-04-29	10.95	2024-04-23	3	EURO
3914	Glovo 19APR BRBVC3NMG	2024-04-29	15.00	2024-04-23	3	EURO
3915	HUSSEL BRAGA PARQUE BRA	2024-04-29	5.04	2024-04-19	3	EURO
3916	UBR PENDING.UBER.COM	2024-04-29	4.04	2024-04-19	3	EURO
3917	UBR PENDING.UBER.COM	2024-04-29	3.76	2024-04-19	3	EURO
3918	Glovo 18APR BR1PWMVNP	2024-04-29	9.05	2024-04-19	3	EURO
3919	Glovo 18APR BRVNVYXUY	2024-04-29	10.95	2024-04-19	3	EURO
3920	Glovo 17APR BRY3SP433	2024-04-29	10.95	2024-04-19	3	EURO
3921	FNAC BRAGA 4710427 BRAGA	2024-04-29	189.97	2024-04-18	3	EURO
3922	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-04-18	3	EURO
3923	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-04-18	3	EURO
3924	Glovo 16APR BR1LQYZS7	2024-04-29	10.95	2024-04-18	3	EURO
3925	Glovo 15APR BRCW8QVHB	2024-04-29	10.95	2024-04-17	3	EURO
3926	UBR PENDING.UBER.COM	2024-04-29	5.99	2024-04-16	3	EURO
3927	UBR PENDING.UBER.COM	2024-04-29	5.94	2024-04-16	3	EURO
3928	Glovo 14APR BRDU4VQK4	2024-04-29	13.55	2024-04-16	3	EURO
3929	IKEA BRAGA CAIXAS ECO B	2024-04-29	10.00	2024-04-16	3	EURO
3930	UBR PENDING.UBER.COM	2024-04-29	5.97	2024-04-16	3	EURO
3931	UBR PENDING.UBER.COM	2024-04-29	5.99	2024-04-16	3	EURO
3932	Glovo 12APR BRBHC21JF	2024-04-29	13.00	2024-04-16	3	EURO
3933	Glovo 12APR BRBYFA1NZ	2024-04-29	10.95	2024-04-16	3	EURO
3934	LA ROTISSERIE BRAGA	2024-04-29	11.20	2024-04-15	3	EURO
3935	Glovo 11APR BRSKMTPLF	2024-04-29	10.95	2024-04-12	3	EURO
3936	CONTINENTE BRAGA BRAGA	2024-04-29	69.60	2024-04-12	3	EURO
3937	Glovo 10APR BR7JCYVVH	2024-04-29	8.30	2024-04-12	3	EURO
3938	Glovo 10APR BRNFPQBLL	2024-04-29	16.40	2024-04-12	3	EURO
3939	DD PT10100825 VODAFONE PORTUG 07335462122	2024-04-29	63.68	2024-04-12	3	EURO
3940	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-04-11	3	EURO
3941	UBR PENDING.UBER.COM	2024-04-29	3.50	2024-04-11	3	EURO
3942	Glovo 09APR BR18WJBTZ	2024-04-29	14.40	2024-04-11	3	EURO
3943	Glovo 09APR BRHETKJ1H	2024-04-29	10.95	2024-04-11	3	EURO
3944	LEV ATM 8281 CGD   Maximinos     R Caires, 58	2024-04-29	100.00	2024-04-10	3	EURO
3945	Glovo 08APR BRCUA91E2	2024-04-29	8.30	2024-04-10	3	EURO
3948	UBR PENDING.UBER.COM	2024-04-29	5.92	2024-04-09	3	EURO
3949	UBR PENDING.UBER.COM	2024-04-29	4.31	2024-04-09	3	EURO
3950	UBER TRIP	2024-04-29	5.30	2024-04-09	3	EURO
3951	UBR PENDING.UBER.COM	2024-04-29	5.91	2024-04-09	3	EURO
3952	CONTINENTE BRAGA BRAGA	2024-04-29	78.95	2024-04-09	3	EURO
3953	Glovo 06APR BR9UCWD8F	2024-04-29	18.90	2024-04-09	3	EURO
3954	Glovo 05APR BRWSQWK14	2024-04-29	11.25	2024-04-09	3	EURO
3955	Glovo 05APR BRH21EL9B	2024-04-29	10.95	2024-04-09	3	EURO
3956	TRF P/ Lucinda dona da casa	2024-04-29	650.00	2024-04-08	3	EURO
3957	PAG SERV 21796/298376442 AGEREEMP.DE AGUAS,EFL	2024-04-29	48.59	2024-04-08	3	EURO
3958	Glovo 04APR BRTBFJU1J	2024-04-29	10.95	2024-04-05	3	EURO
3959	IMPOSTO DE SELO 17.3.4	2024-04-29	0.21	2024-04-08	3	EURO
3960	COM. MANUTENCAO CONTA ORDENADO 032024	2024-04-29	5.20	2024-04-08	3	EURO
3961	EST SERVICO SANTOS DA CUNHA 6  BRA	2024-04-29	39.02	2024-04-05	3	EURO
3962	Glovo 03APR BRLECLYKM	2024-04-29	13.55	2024-04-05	3	EURO
3963	PIZZA HUT B. ARCADA BRA	2024-04-29	6.10	2024-04-04	3	EURO
3964	Glovo 02APR BRRTSVAGA	2024-04-29	10.95	2024-04-04	3	EURO
3965	CIN BRAGA PARQUE BRAGA	2024-04-29	6.70	2024-04-03	3	EURO
3966	RESTAURANTE TRINCAS BRA	2024-04-29	9.80	2024-04-03	3	EURO
3967	Glovo 31MAR BRSAYTJF5	2024-04-29	8.30	2024-04-02	3	EURO
3968	CONTINENTE BRAGA BRAGA	2024-04-29	57.72	2024-04-02	3	EURO
3969	RAUL EDGAR UNIP LDA BRA	2024-04-29	9.90	2024-04-02	3	EURO
3970	FNAC BRAGA BRAGA PT	2024-04-29	19.15	2024-04-02	3	EURO
3971	H3 NOVA ARCADA BRAGA PT	2024-04-29	9.90	2024-04-02	3	EURO
3982	AMERICANAS *FIT IN 06/08 MONTEIRO	2024-04-29	137.78	2024-01-21	6	REAL
3983	ALURA 05/12	2024-04-29	92.65	2024-01-26	6	REAL
3984	BLOX COBRANC*DESM 05/06 COLOMBO	2024-04-29	342.32	2024-01-26	6	REAL
3985	GOL LINHAS A*MRVH 03/05	2024-04-29	795.29	2024-01-09	6	REAL
3947	Comissão Transferência a crédito SEPA+ Em Linha	2024-04-29	1.10	2024-04-08	3	EURO
3946	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-04-29	0.04	2024-04-08	3	EURO
3986	AMAZON MARKETPLACE 02/10	2024-04-29	82.09	2024-01-14	6	REAL
3987	Uber *UBER *TRIP	2024-04-29	12.96	2024-01-02	6	REAL
3988	UBER* TRIP	2024-04-29	12.98	2024-01-02	6	REAL
3989	Uber *UBER *TRIP	2024-04-29	19.90	2024-01-02	6	REAL
3990	Amazon Kindle Unltd	2024-04-29	19.90	2024-01-03	6	REAL
3991	AmazonPrimeBR	2024-04-29	14.90	2024-01-03	6	REAL
3992	UBER* TRIP	2024-04-29	74.90	2024-01-03	6	REAL
3993	Disney Plus	2024-04-29	33.90	2024-01-06	6	REAL
3994	NETFLIX ENTRETENIMENTO	2024-04-29	39.90	2024-01-11	6	REAL
3995	APPLE.COM/BILL	2024-04-29	21.90	2024-01-20	6	REAL
3996	DM*HELPHBOMAXCOM	2024-04-29	34.90	2024-01-21	6	REAL
3997	EBN*SPOTIFY CURITIBA	2024-04-29	21.90	2024-01-29	6	REAL
3998	IOF TRANSACOES INTERNACIONAIS	2024-04-29	15.47	2024-02-04	6	REAL
3999	UBER *TRIP HELP.UBER.COM NL	2024-04-29	264.68	2024-01-04	6	REAL
4000	UBER *TRIP HELP.UBER.COM NL	2024-04-29	30.74	2024-01-06	6	REAL
4001	STEAM PURCHASE SEATTLE DE	2024-04-29	57.99	2024-01-14	6	REAL
4002	TAR PACOTE ITAU JAN/24	2024-04-29	71.90	2024-02-02	5	REAL
4003	MOBILE PAG TIT 775324902000	2024-04-29	664.00	2024-02-14	5	REAL
4004	DA COMGAS 48353698	2024-04-29	11.39	2024-02-14	5	REAL
4005	DA VIVO FIXO 9324810660	2024-04-29	148.99	2024-02-15	5	REAL
4006	DA ELETROPAULO 56301179	2024-04-29	21.44	2024-02-29	5	REAL
4007	TAR PACOTE ITAU FEV/24	2024-04-29	71.90	2024-03-04	5	REAL
4008	MOBILE PAG TIT 775324902000	2024-04-29	664.00	2024-03-11	5	REAL
4009	DA COMGAS 48353698	2024-04-29	11.39	2024-03-14	5	REAL
4010	DA VIVO FIXO 9324810660	2024-04-29	148.99	2024-03-15	5	REAL
4011	DA ELETROPAULO 56301179	2024-04-29	21.40	2024-04-01	5	REAL
4012	TAR PACOTE ITAU MAR/24	2024-04-29	71.90	2024-04-02	5	REAL
4013	MOBILEPAG TIT 7753249020	2024-04-29	664.00	2024-04-08	5	REAL
4014	TEDINT 25854320	2024-04-29	440.00	2024-04-08	5	REAL
4015	DA VIVO FIXO 9324810660	2024-04-29	148.99	2024-04-15	5	REAL
4016	DA COMGAS 48353698	2024-04-29	11.39	2024-04-15	5	REAL
4017	DA ELETROPAULO 56301179	2024-04-29	21.29	2024-04-29	5	REAL
4018	Pagamento fatura 02/2024	2024-02-14	2127.05	2024-04-29	5	REAL
4019	AMERICANAS *FIT IN 07/08 MONTEIRO	2024-04-29	137.78	2024-02-21	6	REAL
4020	ALURA 06/12	2024-04-29	92.65	2024-02-26	6	REAL
4021	BLOX COBRANC*DESM 06/06 COLOMBO	2024-04-29	342.32	2024-02-27	6	REAL
4022	GOL LINHAS A*MRVH 04/05	2024-04-29	795.29	2024-02-09	6	REAL
4023	AMAZON MARKETPLACE 03/10	2024-04-29	82.09	2024-02-14	6	REAL
4024	AmazonPrimeBR	2024-04-29	14.90	2024-02-03	6	REAL
4025	Amazon Kindle Unltd	2024-04-29	19.90	2024-02-03	6	REAL
4026	ANUIDADE DIFERENCIADA 03/12	2024-04-29	17.00	2024-02-03	6	REAL
4027	Disney Plus	2024-04-29	33.90	2024-02-06	6	REAL
4028	NETFLIX.COM	2024-04-29	39.90	2024-02-11	6	REAL
4029	APPLE.COM/BILL	2024-04-29	21.90	2024-02-20	6	REAL
4030	DM*HELPHBOMAXCOM	2024-04-29	34.90	2024-02-21	6	REAL
4031	EBN*SPOTIFY	2024-04-29	21.90	2024-02-27	6	REAL
4032	Pagamento fatura 03/2024	2024-03-11	1654.43	2024-04-29	5	REAL
4033	AMERICANAS *FIT IN 08/08 MONTEIRO	2024-04-29	137.78	2024-03-21	6	REAL
4034	ALURA 07/12	2024-04-29	92.65	2024-03-26	6	REAL
4035	GOL LINHAS A*MRVH 05/05	2024-04-29	795.29	2024-03-09	6	REAL
4036	AMAZON MARKETPLACE 04/10	2024-04-29	82.09	2024-03-14	6	REAL
4037	ANUIDADE DIFERENCIADA 04/12	2024-04-29	34.00	2024-03-02	6	REAL
4038	Amazon Kindle Unltd	2024-04-29	19.90	2024-03-03	6	REAL
4039	AmazonPrimeBR	2024-04-29	14.90	2024-03-03	6	REAL
4040	Disney Plus	2024-04-29	33.90	2024-03-06	6	REAL
4041	NETFLIX ENTRETENIMENTO	2024-04-29	39.90	2024-03-11	6	REAL
4042	APPLE.COM/BILL	2024-04-29	21.90	2024-03-20	6	REAL
4043	DM *HELPMAXCOM	2024-04-29	34.90	2024-03-21	6	REAL
4044	EBN*SPOTIFY	2024-04-29	21.90	2024-03-27	6	REAL
4045	Pagamento fatura 04/2024	2024-04-08	1329.11	2024-04-29	5	REAL
4047	AMAZONPRIMEBR	2024-04-29	14.90	2024-04-03	6	REAL
4048	AMAZON KINDLE UNLTD	2024-04-29	19.90	2024-04-03	6	REAL
4049	ANUIDADE DIFERENCIADA 05/12	2024-04-29	34.00	2024-04-04	6	REAL
4050	DISNEY PLUS	2024-04-29	33.90	2024-04-06	6	REAL
4051	NETFLIX ENTRETENIMENTO	2024-04-29	39.90	2024-04-11	6	REAL
4052	AMAZON MARKETPLACE 05 - PARCELA 5 DE 10	2024-04-29	82.09	2024-04-14	6	REAL
4053	APPLE.COM/BILL	2024-04-29	21.90	2024-04-20	6	REAL
4054	DM*HELPMAXCOM	2024-04-29	34.90	2024-04-21	6	REAL
4055	ALURA 08 - PARCELA 8 DE 12	2024-04-29	92.65	2024-04-26	6	REAL
4056	EBN*SPOTIFY	2024-04-29	21.90	2024-04-27	6	REAL
4057	Glovo 29APR BRKTHSX99	2024-05-01	11.85	2024-04-30	3	EURO
4058	UBR PENDING.UBER.COM	2024-05-01	5.94	2024-04-30	3	EURO
4059	UBR PENDING.UBER.COM	2024-05-01	5.91	2024-04-30	3	EURO
4060	CONTINENTE BRAGA BRAGA	2024-05-01	46.93	2024-04-30	3	EURO
4061	Glovo 27APR BRGZF76VR	2024-05-01	11.65	2024-04-30	3	EURO
4062	Glovo 26APR BRVFHGQA1	2024-05-01	10.95	2024-04-30	3	EURO
4063	Glovo 26APR BRLRRHLCV	2024-05-01	11.10	2024-04-30	3	EURO
4064	Uber 1	2024-05-01	3.50	2024-04-30	3	EURO
4065	Uber 2	2024-05-01	3.74	2024-04-30	3	EURO
4066	Glovo 1	2024-05-01	10.95	2024-04-30	3	EURO
26	EDEKA M PELKOVENST 822 MUENCHEN DE	2020-03-19	11.23	2020-03-18	3	EURO
27	KAMILIA PEREIRA MUENCHEN DE	2020-03-19	200.00	2020-03-17	3	EURO
28	EDEKA CENTER OEZ MUENCHEN DE	2020-03-19	45.52	2020-03-17	3	EURO
29	EDEKA CENTER OEZ MUENCHEN DE	2020-03-19	51.28	2020-03-10	3	EURO
34	EDEKA CENTER OEZ MUENCHEN DE	2020-03-19	49.20	2020-03-03	3	EURO
36	EDEKA M PELKOVENST 822 MUENCHEN DE	2020-03-19	7.22	2020-03-02	3	EURO
45	EDEKA CENTER OEZ MUENCHEN DE	2020-02-25	43.79	2020-02-25	3	EURO
47	KAMILIA PEREIRA MUENCHEN DE	2020-02-18	200.00	2020-02-18	3	EURO
48	EDEKA CENTER OEZ MUENCHEN DE	2020-02-18	58.17	2020-02-18	3	EURO
50	EDEKA CENTER OEZ MUENCHEN DE	2020-02-13	31.65	2020-02-13	3	EURO
51	EDEKA CENTER OEZ MUENCHEN DE	2020-02-11	56.89	2020-02-11	3	EURO
52	MVG AUTOMATEN MUENCHEN DE	2020-02-11	88.90	2020-02-11	3	EURO
54	EDEKA CENTER OEZ MUENCHEN DE	2020-02-04	58.69	2020-02-04	3	EURO
64	EDEKA CENTER OEZ MUENCHEN DE	2020-01-28	53.13	2020-01-28	3	EURO
66	EDEKA M PELKOVENST 822 MUENCHEN DE	2020-01-22	16.06	2020-01-22	3	EURO
67	EDEKA CENTER OEZ MUENCHEN DE	2020-01-21	52.03	2020-01-21	3	EURO
68	Saturn Electro-Handels MUnchen DE	2020-01-21	56.98	2020-01-21	3	EURO
69	KAMILIA PEREIRA MUENCHEN DE	2020-01-14	200.00	2020-01-14	3	EURO
70	EDEKA CENTER OEZ MUENCHEN DE	2020-01-14	42.78	2020-01-14	3	EURO
72	EDEKA CENTER OEZ MUENCHEN DE	2020-01-09	60.89	2020-01-09	3	EURO
73	MVG AUTOMATEN MUENCHEN DE	2020-01-09	88.90	2020-01-09	3	EURO
100	MAX RISCHART S BACKHAU MUENCHEN DE	2019-12-17	18.00	2019-12-17	3	EURO
102	MVG AUTOMATEN MUENCHEN DE	2019-12-13	22.10	2019-12-13	3	EURO
103	EDEKA M ERIKA MANN 880 MUENCHEN DE	2019-12-11	5.38	2019-12-11	3	EURO
104	MAX RISCHART S BACKHAU MUENCHEN DE	2019-12-10	18.00	2019-12-10	3	EURO
105	EDEKA CENTER OEZ MUENCHEN DE	2019-12-10	37.76	2019-12-10	3	EURO
106	GameStop Deutschland G MUnchen DE	2019-12-10	41.99	2019-12-10	3	EURO
109	MVG AUTOMATEN MUENCHEN DE	2019-12-06	22.10	2019-12-06	3	EURO
110	EDEKA CENTER OEZ MUENCHEN DE	2019-12-03	58.01	2019-12-03	3	EURO
199	EDEKA CENTER OEZ MUENCHEN DE	2020-05-12	27.96	2020-05-04	3	EURO
200	EDEKA CENTER OEZ MUENCHEN DE	2020-05-12	44.22	2020-05-07	3	EURO
842	EDEKA CENTER OEZ MUENCHEN DE	2021-04-30	47.10	2021-04-20	3	EURO
839	EDEKA CENTER OEZ MUENCHEN DE	2021-04-30	40.48	2021-04-27	3	EURO
841	GALERIA Kaufhof Muenchen DE	2021-04-30	59.13	2021-04-20	3	EURO
843	EDEKA M ERIKA MANN 880 MUENCHEN DE	2021-04-30	9.65	2021-04-15	3	EURO
844	EDEKA CENTER OEZ MUENCHEN DE	2021-04-30	54.84	2021-04-13	3	EURO
933	EDEKA M ERIKA MANN 880 MUENCHEN DE	2021-06-30	9.04	2021-06-10	3	EURO
934	MUNCHNER VERKEHRSGESEL MUNCHEN DE	2021-06-30	57.00	2021-06-09	3	EURO
921	EDEKA CENTER OEZ MUENCHEN DE	2021-06-30	35.73	2021-06-22	3	EURO
927	PUMA Concept Store Muenchen DE	2021-06-30	55.00	2021-06-17	3	EURO
928	GALERIA Kaufhof Muenchen DE	2021-06-30	39.90	2021-06-17	3	EURO
931	EDEKA M ERIKA MANN 880 MUENCHEN DE	2021-06-30	6.09	2021-06-16	3	EURO
932	EDEKA CENTER OEZ MUENCHEN DE	2021-06-30	37.60	2021-06-11	3	EURO
957	SANI PLUS-APOTHEKE MUEN	2021-09-04	3.99	2021-08-27	3	EURO
961	MODEFRISEUR BLATTER GM	2021-09-04	37.00	2021-08-18	3	EURO
965	BAECKEREI ZIEGLER MUENC	2021-09-04	10.15	2021-08-17	3	EURO
967	AUGUSTINER BRAEUSTUBEN	2021-09-04	17.25	2021-08-13	3	EURO
974	SANI PLUS-APOTHEKE MUEN	2021-09-04	11.99	2021-07-27	3	EURO
1172	AUGUSTINER BRAEUSTUBEN	2021-11-30	18.00	2021-11-19	3	EURO
2780	BRAGA RIO LOJA 306 BRAG	2023-05-06	13.40	2023-05-05	3	EURO
2781	PINGO DOCE BRAGA BRAGA	2023-05-06	17.67	2023-05-05	3	EURO
2790	IKEA BRAGA CAIXAS ECO B	2023-05-06	15.65	2023-05-03	3	EURO
2791	TOMATINO NOVA ARCADA BR	2023-05-06	8.50	2023-05-03	3	EURO
3018	JEAN LOUIS DAVID BRAGA	2023-07-22	15.90	2023-07-18	3	EURO
3019	BRAGA RIO LOJA 306 BRAG	2023-07-22	13.40	2023-07-18	3	EURO
3020	PINGO DOCE BRAGA BRAGA	2023-07-22	28.04	2023-07-18	3	EURO
3023	CONTINENTE BRAGA BRAGA	2023-07-22	42.41	2023-07-18	3	EURO
3035	CONTINENTE BRAGA BRAGA	2023-07-22	52.48	2023-07-11	3	EURO
919	EDEKA M ERIKA MANN 880	2021-06-30	6.95	2021-06-23	3	EURO
923	EDEKA M ERIKA MANN 880	2021-06-30	8.54	2021-06-22	3	EURO
925	EDEKA M ERIKA MANN 880	2021-06-30	5.40	2021-06-17	3	EURO
929	EDEKA M ERIKA MANN 880	2021-06-30	5.90	2021-06-17	3	EURO
2470	Vodafone.pt	2023-03-24	15.00	2023-01-27	3	EURO
2778	UBR PENDING.UBER.COM	2023-05-06	5.13	2023-05-05	3	EURO
2779	UBR PENDING.UBER.COM	2023-05-06	6.59	2023-05-05	3	EURO
2782	UBR PENDING.UBER.COM	2023-05-06	4.61	2023-05-05	3	EURO
2783	UBR PENDING.UBER.COM	2023-05-06	3.99	2023-05-05	3	EURO
2784	UBR PENDING.UBER.COM	2023-05-06	4.80	2023-05-03	3	EURO
2785	UBR PENDING.UBER.COM	2023-05-06	4.29	2023-05-03	3	EURO
2786	UBR PENDING.UBER.COM	2023-05-06	6.99	2023-05-03	3	EURO
2787	UBR PENDING.UBER.COM	2023-05-06	6.64	2023-05-03	3	EURO
2788	UBR PENDING.UBER.COM	2023-05-06	6.62	2023-05-03	3	EURO
2789	UBER TRIP	2023-05-06	6.94	2023-05-03	3	EURO
2792	UBR PENDING.UBER.COM	2023-05-06	5.32	2023-05-03	3	EURO
2818	UBR PENDING.UBER.COM	2023-05-30	6.68	2023-05-30	3	EURO
2819	UBR PENDING.UBER.COM	2023-05-30	6.52	2023-05-30	3	EURO
2834	UBR PENDING.UBER.COM	2023-05-30	3.97	2023-05-25	3	EURO
2835	UBR PENDING.UBER.COM	2023-05-30	3.95	2023-05-25	3	EURO
838	KFC  M?NCHEN DE	2021-04-30	7.99	2021-04-27	3	EURO
930	KFC  MUNCHEN DE	2021-06-30	9.29	2021-06-16	3	EURO
920	KFC  MUNCHEN DE	2021-06-30	9.49	2021-06-23	3	EURO
922	KFC  MUNCHEN DE	2021-06-30	9.29	2021-06-22	3	EURO
924	KFC  MUNCHEN DE	2021-06-30	9.29	2021-06-17	3	EURO
2839	UBR PENDING.UBER.COM	2023-05-30	4.44	2023-05-24	3	EURO
2840	UBR PENDING.UBER.COM	2023-05-30	5.68	2023-05-24	3	EURO
2841	UBR PENDING.UBER.COM	2023-05-30	6.07	2023-05-24	3	EURO
2842	UBR PENDING.UBER.COM	2023-05-30	3.61	2023-05-24	3	EURO
2851	UBR PENDING.UBER.COM	2023-05-30	2.97	2023-05-19	3	EURO
2854	UBR PENDING.UBER.COM	2023-05-30	3.87	2023-05-18	3	EURO
2855	UBR PENDING.UBER.COM	2023-05-30	4.05	2023-05-18	3	EURO
2857	UBR PENDING.UBER.COM	2023-05-30	5.50	2023-05-16	3	EURO
2858	UBR PENDING.UBER.COM	2023-05-30	4.73	2023-05-16	3	EURO
2859	UBR PENDING.UBER.COM	2023-05-30	6.72	2023-05-16	3	EURO
2860	UBR PENDING.UBER.COM	2023-05-30	6.76	2023-05-16	3	EURO
2865	UBR PENDING.UBER.COM	2023-05-30	3.74	2023-05-16	3	EURO
2866	UBR PENDING.UBER.COM	2023-05-30	5.98	2023-05-16	3	EURO
2875	UBR PENDING.UBER.COM	2023-05-30	4.01	2023-05-12	3	EURO
2876	UBR PENDING.UBER.COM	2023-05-30	4.00	2023-05-12	3	EURO
2881	UBR PENDING.UBER.COM	2023-05-30	6.73	2023-05-09	3	EURO
2882	UBR PENDING.UBER.COM	2023-05-30	11.11	2023-05-09	3	EURO
2909	UBR PENDING.UBER.COM	2023-07-01	3.95	2023-06-29	3	EURO
2914	UBR PENDING.UBER.COM	2023-07-01	6.69	2023-06-27	3	EURO
2915	UBR PENDING.UBER.COM	2023-07-01	4.55	2023-06-27	3	EURO
2916	UBR PENDING.UBER.COM	2023-07-01	4.07	2023-06-27	3	EURO
2917	UBR PENDING.UBER.COM	2023-07-01	4.03	2023-06-27	3	EURO
2923	UBR PENDING.UBER.COM	2023-07-01	3.62	2023-06-23	3	EURO
2924	UBR PENDING.UBER.COM	2023-07-01	5.26	2023-06-23	3	EURO
2928	UBR PENDING.UBER.COM	2023-07-01	4.25	2023-06-20	3	EURO
2929	UBR PENDING.UBER.COM	2023-07-01	4.18	2023-06-20	3	EURO
2930	UBR PENDING.UBER.COM	2023-07-01	5.96	2023-06-20	3	EURO
2931	UBR PENDING.UBER.COM	2023-07-01	5.67	2023-06-20	3	EURO
2942	UBR PENDING.UBER.COM	2023-07-01	3.98	2023-06-16	3	EURO
2943	UBR PENDING.UBER.COM	2023-07-01	4.05	2023-06-16	3	EURO
2945	UBR PENDING.UBER.COM	2023-07-01	3.95	2023-06-16	3	EURO
2946	UBR PENDING.UBER.COM	2023-07-01	4.00	2023-06-16	3	EURO
2949	UBR PENDING.UBER.COM	2023-07-01	6.79	2023-06-14	3	EURO
2950	UBR PENDING.UBER.COM	2023-07-01	6.70	2023-06-14	3	EURO
2961	UBR PENDING.UBER.COM	2023-07-01	7.06	2023-06-08	3	EURO
2962	UBR PENDING.UBER.COM	2023-07-01	3.95	2023-06-08	3	EURO
2964	UBR PENDING.UBER.COM	2023-07-01	6.76	2023-06-06	3	EURO
2965	UBR PENDING.UBER.COM	2023-07-01	6.90	2023-06-06	3	EURO
3013	UBR PENDING.UBER.COM	2023-07-22	4.90	2023-07-19	3	EURO
3015	UBR PENDING.UBER.COM	2023-07-22	4.77	2023-07-18	3	EURO
3016	UBR PENDING.UBER.COM	2023-07-22	4.45	2023-07-18	3	EURO
3021	UBR PENDING.UBER.COM	2023-07-22	7.12	2023-07-18	3	EURO
3022	UBR PENDING.UBER.COM	2023-07-22	8.86	2023-07-18	3	EURO
3029	UBR PENDING.UBER.COM	2023-07-22	3.50	2023-07-12	3	EURO
3030	UBR PENDING.UBER.COM	2023-07-22	3.50	2023-07-12	3	EURO
3032	UBR PENDING.UBER.COM	2023-07-22	5.99	2023-07-11	3	EURO
3033	UBR PENDING.UBER.COM	2023-07-22	6.74	2023-07-11	3	EURO
3057	UBR PENDING.UBER.COM	2023-08-06	4.29	2023-08-01	3	EURO
3058	UBR PENDING.UBER.COM	2023-08-06	6.74	2023-08-01	3	EURO
3059	UBR PENDING.UBER.COM	2023-08-06	6.61	2023-08-01	3	EURO
3060	UBR PENDING.UBER.COM	2023-08-06	4.66	2023-08-01	3	EURO
3065	UBR PENDING.UBER.COM	2023-08-06	3.98	2023-07-27	3	EURO
3066	UBR PENDING.UBER.COM	2023-08-06	3.96	2023-07-27	3	EURO
3070	UBR PENDING.UBER.COM	2023-08-06	5.24	2023-07-26	3	EURO
3071	UBR PENDING.UBER.COM	2023-08-06	4.78	2023-07-26	3	EURO
3355	UBR PENDING.UBER.COM	2023-11-03	5.77	2023-10-31	3	EURO
3356	UBR PENDING.UBER.COM	2023-11-03	5.69	2023-10-31	3	EURO
3372	UBR PENDING.UBER.COM	2023-11-03	5.59	2023-10-24	3	EURO
3373	UBR PENDING.UBER.COM	2023-11-03	5.81	2023-10-24	3	EURO
3443	UBR PENDING.UBER.COM	2023-12-26	29.30	2023-11-28	3	EURO
3444	UBR PENDING.UBER.COM	2023-12-26	15.49	2023-11-28	3	EURO
3450	UBR PENDING.UBER.COM	2023-12-26	37.15	2023-11-28	3	EURO
3457	UBR PENDING.UBER.COM	2023-12-26	5.78	2023-11-21	3	EURO
3458	UBR PENDING.UBER.COM	2023-12-26	5.69	2023-11-21	3	EURO
3462	UBR PENDING.UBER.COM	2023-12-26	3.66	2023-11-17	3	EURO
3463	UBR PENDING.UBER.COM	2023-12-26	3.58	2023-11-17	3	EURO
3466	UBR PENDING.UBER.COM	2023-12-26	4.54	2023-11-16	3	EURO
3467	UBR PENDING.UBER.COM	2023-12-26	3.73	2023-11-16	3	EURO
3473	UBR PENDING.UBER.COM	2023-12-26	2.33	2023-11-15	3	EURO
3474	UBR PENDING.UBER.COM	2023-12-26	2.10	2023-11-15	3	EURO
3475	UBR PENDING.UBER.COM	2023-12-26	1.84	2023-11-15	3	EURO
3476	UBR PENDING.UBER.COM	2023-12-26	5.93	2023-11-15	3	EURO
1003	KFC	2021-09-04	9.29	2021-07-28	4	EURO
1007	KFC	2021-09-04	9.29	2021-08-04	4	EURO
1008	KFC	2021-09-04	9.29	2021-08-08	4	EURO
1009	KFC	2021-09-04	7.79	2021-08-18	4	EURO
1014	KFC	2021-09-04	9.49	2021-08-25	4	EURO
1103	KFC  MUNCHEN DE	2021-10-31	9.99	2021-10-06	3	EURO
1441	KFC	2022-03-27	8.49	2022-03-23	3	EURO
1473	KFC	2022-03-27	8.49	2022-03-09	3	EURO
1498	KFC	2022-04-09	2.49	2022-04-08	3	EURO
1499	KFC	2022-04-09	8.49	2022-04-08	3	EURO
1557	KFC	2022-05-18	8.49	2022-05-09	3	EURO
1577	KFC	2022-05-18	8.49	2022-04-27	3	EURO
1596	KFC	2022-05-18	10.98	2022-04-20	3	EURO
4067	TRF P/ Lucinda dona da casa	2024-06-03	650.00	2024-06-03	3	EURO
4068	Glovo 30MAY BRGEYLA1V	2024-06-03	10.95	2024-06-03	3	EURO
4069	Glovo 29MAY BRLCXSQ1K	2024-06-03	14.00	2024-05-31	3	EURO
4070	Glovo 29MAY BRXUGNFGG	2024-06-03	10.95	2024-05-31	3	EURO
4071	BOLT.EU O 2405281906	2024-06-03	3.85	2024-05-30	3	EURO
4072	Glovo 28MAY BRL5TQBS6	2024-06-03	16.40	2024-05-30	3	EURO
4073	Glovo 28MAY BRX4U533P	2024-06-03	10.95	2024-05-30	3	EURO
4074	BOLT.EU O 2405281745	2024-06-03	3.95	2024-05-30	3	EURO
4075	HUSSEL BRAGA PARQUE BRA	2024-06-03	3.94	2024-05-29	3	EURO
4076	Glovo 27MAY BRXSVLN7R	2024-06-03	10.95	2024-05-29	3	EURO
4077	PIZZA HUT BRAGA PARQ V	2024-06-03	6.10	2024-05-28	3	EURO
4078	UBR PENDING.UBER.COM	2024-06-03	3.86	2024-05-28	3	EURO
4079	UBR PENDING.UBER.COM	2024-06-03	4.50	2024-05-28	3	EURO
4080	UBR PENDING.UBER.COM	2024-06-03	3.64	2024-05-28	3	EURO
4081	UBR PENDING.UBER.COM	2024-06-03	5.95	2024-05-28	3	EURO
4082	UBR PENDING.UBER.COM	2024-06-03	3.72	2024-05-28	3	EURO
4083	Glovo 26MAY BR25GDLV7	2024-06-03	11.60	2024-05-28	3	EURO
4084	CORTES DE LISBOA BRAGA	2024-06-03	34.00	2024-05-28	3	EURO
4085	CONTINENTE BRAGA BRAGA	2024-06-03	63.27	2024-05-28	3	EURO
4086	Glovo 25MAY BRSDZGEHC	2024-06-03	8.90	2024-05-28	3	EURO
4087	Glovo 24MAY BR4HJLFQG	2024-06-03	8.78	2024-05-28	3	EURO
4088	Glovo 24MAY BRTER1MNU	2024-06-03	10.95	2024-05-28	3	EURO
4089	Glovo 23MAY BRYXPJYRM	2024-06-03	10.95	2024-05-27	3	EURO
4090	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-06-03	112.54	2024-05-27	3	EURO
4091	CLINICA STA MADALENA BR	2024-06-03	15.90	2024-05-24	3	EURO
4092	UBR PENDING.UBER.COM	2024-06-03	3.81	2024-05-24	3	EURO
4093	UBR PENDING.UBER.COM	2024-06-03	4.16	2024-05-24	3	EURO
4094	Glovo 22MAY BRYMU7Z1T	2024-06-03	10.95	2024-05-24	3	EURO
4095	UBR PENDING.UBER.COM	2024-06-03	3.50	2024-05-23	3	EURO
4096	UBR PENDING.UBER.COM	2024-06-03	3.50	2024-05-23	3	EURO
4097	Glovo 21MAY BRE5LDA78	2024-06-03	10.95	2024-05-23	3	EURO
4098	Glovo 21MAY BRLFZNNDA	2024-06-03	10.06	2024-05-23	3	EURO
4099	HUSSEL BRAGA PARQUE BRA	2024-06-03	4.38	2024-05-22	3	EURO
4100	ARCADIA BRAGA PARQUE BR	2024-06-03	3.95	2024-05-22	3	EURO
4101	UBR PENDING.UBER.COM	2024-06-03	4.27	2024-05-22	3	EURO
4102	UBR PENDING.UBER.COM	2024-06-03	3.99	2024-05-22	3	EURO
4103	Glovo 20MAY BR2GTVWY1	2024-06-03	12.70	2024-05-22	3	EURO
4104	UBR PENDING.UBER.COM	2024-06-03	5.91	2024-05-21	3	EURO
4105	UBR PENDING.UBER.COM	2024-06-03	5.96	2024-05-21	3	EURO
4106	Glovo 19MAY BREASXL9F	2024-06-03	8.90	2024-05-21	3	EURO
4107	CONTINENTE BRAGA BRAGA	2024-06-03	59.74	2024-05-21	3	EURO
4108	Glovo 18MAY BRS5XCGLG	2024-06-03	12.00	2024-05-21	3	EURO
4109	Glovo 17MAY BRLKPJHNH	2024-06-03	10.95	2024-05-21	3	EURO
4110	Glovo 17MAY BRS4UK1NE	2024-06-03	18.50	2024-05-21	3	EURO
4111	LEV ATM 8281 MG    BRAGA         CC Braga Parqu	2024-06-03	100.00	2024-05-20	3	EURO
4112	Glovo 16MAY BRAN1Y166	2024-06-03	10.95	2024-05-20	3	EURO
4113	Glovo 15MAY BRY3A6URB	2024-06-03	10.95	2024-05-17	3	EURO
4114	Glovo 14MAY BRMUV3WUT	2024-06-03	10.95	2024-05-16	3	EURO
4115	DD PT10100825 VODAFONE PORTUG 07335462122	2024-06-03	63.68	2024-05-16	3	EURO
4116	Glovo 13MAY BRNK56L7R	2024-06-03	10.95	2024-05-15	3	EURO
4117	UBR PENDING.UBER.COM	2024-06-03	4.03	2024-05-14	3	EURO
4118	UBR PENDING.UBER.COM	2024-06-03	3.64	2024-05-14	3	EURO
4119	Glovo 12MAY BRTZCNTCL	2024-06-03	12.20	2024-05-14	3	EURO
4120	Glovo 11MAY BRFHERWJG	2024-06-03	12.20	2024-05-14	3	EURO
4121	UBR PENDING.UBER.COM	2024-06-03	3.50	2024-05-14	3	EURO
4122	UBR PENDING.UBER.COM	2024-06-03	5.95	2024-05-14	3	EURO
4123	UBR PENDING.UBER.COM	2024-06-03	5.92	2024-05-14	3	EURO
4124	UBR PENDING.UBER.COM	2024-06-03	3.50	2024-05-14	3	EURO
4125	TOMATINO NOVA ARCADA BR	2024-06-03	8.80	2024-05-14	3	EURO
4126	CONTINENTE BRAGA BRAGA	2024-06-03	51.20	2024-05-14	3	EURO
4127	Glovo 09MAY BRGYQTWXR	2024-06-03	10.95	2024-05-13	3	EURO
4128	PAG SERV 21796/306021542 AGEREEMP.DE AGUAS,EFL	2024-06-03	18.80	2024-05-13	3	EURO
4129	IMPOSTO DE SELO 17.3.4	2024-06-03	0.21	2024-05-10	3	EURO
4130	COM. MANUTENCAO CONTA ORDENADO 042024	2024-06-03	5.20	2024-05-10	3	EURO
4131	Glovo 08MAY BRB1KZEZY	2024-06-03	13.55	2024-05-10	3	EURO
4132	UBR PENDING.UBER.COM	2024-06-03	4.04	2024-05-09	3	EURO
4133	UBR PENDING.UBER.COM	2024-06-03	3.53	2024-05-09	3	EURO
4134	Glovo 07MAY BRAQ6AGUA	2024-06-03	10.95	2024-05-09	3	EURO
4135	Glovo 07MAY BRTH72EFB	2024-06-03	16.40	2024-05-09	3	EURO
4136	Glovo 06MAY BRXXUHHHT	2024-06-03	10.95	2024-05-08	3	EURO
4139	UBER TRIP	2024-06-03	6.01	2024-05-07	3	EURO
4140	UBR PENDING.UBER.COM	2024-06-03	5.93	2024-05-07	3	EURO
4141	Glovo 05MAY BRHQAKYLB	2024-06-03	12.00	2024-05-07	3	EURO
4142	TOMATINO NOVA ARCADA BR	2024-06-03	8.80	2024-05-07	3	EURO
4143	CONTINENTE BRAGA BRAGA	2024-06-03	76.79	2024-05-07	3	EURO
4144	Glovo 04MAY BRPNUNHBM	2024-06-03	9.09	2024-05-07	3	EURO
4145	Glovo 03MAY BREVWL9JH	2024-06-03	10.95	2024-05-07	3	EURO
4146	TRF P/ Lucinda dona da casa	2024-06-03	650.00	2024-05-06	3	EURO
4147	Glovo 02MAY BR5WR9CSD	2024-06-03	10.95	2024-05-06	3	EURO
4148	NOS CINEMAS BRAGA PQ BR	2024-06-03	7.70	2024-05-03	3	EURO
4149	UBR PENDING.UBER.COM	2024-06-03	3.59	2024-05-03	3	EURO
4150	UBER TRIP	2024-06-03	6.91	2024-05-03	3	EURO
4151	UBR PENDING.UBER.COM	2024-06-03	3.92	2024-05-03	3	EURO
4152	TOMATINO BRAGA PARQU BR	2024-06-03	8.20	2024-05-03	3	EURO
4153	UBR PENDING.UBER.COM	2024-06-03	3.50	2024-05-03	3	EURO
4154	UBR PENDING.UBER.COM	2024-06-03	3.74	2024-05-03	3	EURO
4155	Glovo 30APR BRDGM1SVC	2024-06-03	10.95	2024-05-03	3	EURO
4156	STM BRAGA	2024-06-03	2.30	2024-05-02	3	EURO
4157	Pending Uber	2024-06-03	4.25	2024-06-01	3	EURO
4158	Supermercado	2024-06-03	56.20	2024-06-01	3	EURO
4137	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-06-03	0.04	2024-05-07	3	EURO
4159	Tomantino	2024-06-03	8.80	2024-06-01	3	EURO
4160	Uber	2024-06-03	4.59	2024-06-01	3	EURO
4162	Amazon Kindle Unltd	2024-06-03	19.90	2024-05-03	6	REAL
4163	Amazon Prime	2024-06-03	19.90	2024-05-03	6	REAL
4164	ANUIDADE DIFERENCIADA 06/12	2024-06-03	34.00	2024-05-04	6	REAL
4165	THE WALT DISNEY COMPAN	2024-06-03	33.90	2024-05-06	6	REAL
4166	NETFLIX.COM	2024-06-03	39.90	2024-05-11	6	REAL
4167	AMAZON MARKETPLACE 06/10	2024-06-03	82.09	2024-12-14	6	REAL
4168	APPLE.COM/BILL	2024-06-03	21.90	2024-05-20	6	REAL
4169	DM*HELPMAXCOM	2024-06-03	34.90	2024-05-21	6	REAL
4170	ALURA09/12	2024-06-03	92.65	2024-09-26	6	REAL
4171	EBN*SPOTIFY	2024-06-03	21.90	2024-05-29	6	REAL
4173	Pagamento fatura 05/2024	2024-05-06	396.04	2024-06-04	5	REAL
4174	TAR PACOTE ITAU   ABR/24	2024-06-04	71.90	2024-05-03	5	REAL
4175	MOBILE PAG TIT 775324902000	2024-06-04	664.00	2024-05-06	5	REAL
4176	DA  COMGAS 48353698	2024-06-04	11.39	2024-05-15	5	REAL
4177	DA  VIVO FIXO 9324810660	2024-06-04	148.99	2024-05-15	5	REAL
4178	DA  ELETROPAULO 56301179	2024-06-04	21.41	2024-05-29	5	REAL
4179	MOBILE PAG TIT 775324902000	2024-06-04	664.00	2024-06-03	5	REAL
4180	EPC*EPIC GAMES STORE	2024-06-04	9.99	2024-05-02	4	EURO
4181	Glovo GLOVO PRIME	2024-06-04	5.99	2024-05-03	4	EURO
4182	NOS CINEMAS APP	2024-06-04	7.70	2024-05-14	4	EURO
4183	Only Fans	2024-06-04	11.37	2024-05-25	4	EURO
4184	NOS CINEMAS APP	2024-06-04	7.70	2024-05-28	4	EURO
4185	Glovo 31MAY BRUNXSERF	2024-06-04	10.95	2024-06-01	4	EURO
4186	Glovo 31MAY BR6QQM8J7	2024-06-04	9.45	2024-06-01	4	EURO
4187	Glovo 03JUN BRTC6FJTP	2024-06-04	10.95	2024-06-03	4	EURO
4188	Glovo GLOVO PRIME	2024-06-04	5.99	2024-06-03	4	EURO
4189	Glovo 02JUN BRG7CLLN1	2024-06-04	12.20	2024-06-03	4	EURO
4190	Glovo 04JUN BR6PGGCYG	2024-06-04	10.95	2024-06-04	4	EURO
4191	Pagamento fatura 06/2024	2024-06-05	401.04	2024-06-05	5	REAL
4192	Tarifa pacote	2024-06-05	71.90	2024-06-04	5	REAL
4193	PAG SERV 21796/311351142 AGEREEMP.DE AGUAS,EFL	2024-06-11	21.34	2024-06-11	3	EURO
4194	UBR PENDING.UBER.COM	2024-06-11	5.94	2024-06-11	3	EURO
4195	UBR PENDING.UBER.COM	2024-06-11	5.99	2024-06-11	3	EURO
4196	H3 NOVA ARCADA BRAGA PT	2024-06-11	10.15	2024-06-11	3	EURO
4197	CONTINENTE BRAGA BRAGA	2024-06-11	47.10	2024-06-11	3	EURO
4198	IMPOSTO DE SELO 17.3.4	2024-06-11	0.21	2024-06-07	3	EURO
4199	COM. MANUTENCAO CONTA ORDENADO 052024	2024-06-11	5.20	2024-06-07	3	EURO
4200	ARCADIA BRAGA PARQUE BR	2024-06-11	5.20	2024-06-07	3	EURO
4201	UBR PENDING.UBER.COM	2024-06-11	4.41	2024-06-07	3	EURO
4202	UBR PENDING.UBER.COM	2024-06-11	3.60	2024-06-07	3	EURO
4203	FOTOSPORT BRAGA PT	2024-06-11	2.85	2024-06-07	3	EURO
4204	UBR PENDING.UBER.COM	2024-06-11	3.50	2024-06-06	3	EURO
4205	UBR PENDING.UBER.COM	2024-06-11	3.50	2024-06-06	3	EURO
4206	UBR PENDING.UBER.COM	2024-06-11	4.10	2024-06-05	3	EURO
4207	UBR PENDING.UBER.COM	2024-06-11	4.15	2024-06-05	3	EURO
4210	LEV NUM MTM9684 BRAGA SANTA TECLA	2024-06-11	100.00	2024-06-04	3	EURO
4213	Glovo 04JUN BRSF3CTDK	2024-06-11	16.40	2024-06-05	4	EURO
4214	Glovo 05JUN BRPSQMD18	2024-06-11	8.30	2024-06-06	4	EURO
4215	Glovo 05JUN BRX5MWJVT	2024-06-11	10.95	2024-06-06	4	EURO
4216	Glovo 06JUN BRCHJUGJX	2024-06-11	8.00	2024-06-07	4	EURO
4217	Glovo 06JUN BRTLZH9MK	2024-06-11	10.95	2024-06-07	4	EURO
4218	Glovo 07JUN BRA3VUJ11	2024-06-11	10.95	2024-06-08	4	EURO
4219	Glovo 07JUN BRE1A2LGL	2024-06-11	9.45	2024-06-08	4	EURO
4220	Glovo 08JUN BRFPKPVFF	2024-06-11	9.60	2024-06-09	4	EURO
4221	Glovo 09JUN BRSQ1X3M1	2024-06-11	8.90	2024-06-10	4	EURO
4222	Glovo 10JUN BRJTS8Y3F	2024-06-11	9.90	2024-06-11	4	EURO
4223	Glovo 11JUN BR1NNGDE4	2024-06-11	10.95	2024-06-11	4	EURO
4224	Ordem Pagamento s/Estrangeiro   Ref.20241371631	\N	200.00	2024-06-20	3	EURO
4225	HOSPITAL PRIV BRAGA NOG	2024-06-21	45.00	2024-06-21	3	EURO
4226	UBR PENDING.UBER.COM	2024-06-21	3.65	2024-06-21	3	EURO
4227	UBR PENDING.UBER.COM	2024-06-21	3.50	2024-06-21	3	EURO
4228	Glovo 19JUN BRK2DG5RQ	2024-06-21	12.12	2024-06-21	3	EURO
4229	Glovo 19JUN BR1X1TL1W	2024-06-21	10.95	2024-06-21	3	EURO
4231	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20241371631	2024-06-21	0.04	2024-06-20	3	EURO
4232	Glovo 18JUN BRXB598VL	2024-06-21	10.95	2024-06-20	3	EURO
4233	HUSSEL BRAGA PARQUE BRA	2024-06-21	4.60	2024-06-20	3	EURO
4234	ARCADIA BRAGA PARQUE BR	2024-06-21	4.70	2024-06-20	3	EURO
4235	FARMACIA MADALENA 4700207 BRAGA	2024-06-21	10.60	2024-06-19	3	EURO
4236	Glovo 17JUN BRS9M4LF9	2024-06-21	10.95	2024-06-19	3	EURO
4237	UBR PENDING.UBER.COM	2024-06-21	5.91	2024-06-18	3	EURO
4238	UBR PENDING.UBER.COM	2024-06-21	5.96	2024-06-18	3	EURO
4239	UBR PENDING.UBER.COM	2024-06-21	3.95	2024-06-18	3	EURO
4240	UBR PENDING.UBER.COM	2024-06-21	3.58	2024-06-18	3	EURO
4241	SPORT ZONE 4710427 BRA	2024-06-21	26.98	2024-06-18	3	EURO
4242	TOMATINO NOVA ARCADA BR	2024-06-21	8.95	2024-06-18	3	EURO
4243	CONTINENTE BRAGA BRAGA	2024-06-21	82.82	2024-06-18	3	EURO
4244	Glovo 15JUN BRE8C7GCC	2024-06-21	8.00	2024-06-18	3	EURO
4245	Glovo 15JUN BRLUZ3BJL	2024-06-21	13.55	2024-06-18	3	EURO
4246	UBR PENDING.UBER.COM	2024-06-21	3.50	2024-06-18	3	EURO
4161	Sálario Junho 2024	\N	3500.00	2024-06-30	3	EURO
4209	Comissão Transferência a crédito SEPA+ Em Linha	2024-06-11	1.10	2024-06-04	3	EURO
4230	Comissão Transferência a crédito SEPA+ Em Linha	2024-06-21	1.10	2024-06-20	3	EURO
4208	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-06-11	0.04	2024-06-04	3	EURO
4247	UBR PENDING.UBER.COM	2024-06-21	3.50	2024-06-18	3	EURO
4248	Glovo 14JUN BR2WLSKTY	2024-06-21	13.42	2024-06-18	3	EURO
4249	UBR PENDING.UBER.COM	2024-06-21	5.97	2024-06-17	3	EURO
4250	UBR PENDING.UBER.COM	2024-06-21	5.92	2024-06-17	3	EURO
4251	CONTINENTE BRAGA BRAGA	2024-06-21	26.89	2024-06-17	3	EURO
4252	HUSSEL BRAGA PARQUE BRA	2024-06-21	5.26	2024-06-17	3	EURO
4253	ADIDAS BRAGA PARQUE BRA	2024-06-21	25.00	2024-06-17	3	EURO
4254	DECATHLON BRAGA BRAGA P	2024-06-21	18.20	2024-06-17	3	EURO
4255	UBR PENDING.UBER.COM	2024-06-21	4.06	2024-06-14	3	EURO
4256	UBR PENDING.UBER.COM	2024-06-21	4.99	2024-06-14	3	EURO
4257	UBR PENDING.UBER.COM	2024-06-21	4.90	2024-06-14	3	EURO
4258	POKE HOUSE BRAGA 13500	2024-06-21	11.00	2024-06-14	3	EURO
4259	UBR PENDING.UBER.COM	2024-06-21	3.90	2024-06-13	3	EURO
4260	UBR PENDING.UBER.COM	2024-06-21	3.50	2024-06-13	3	EURO
4261	DD PT10100825 VODAFONE PORTUG 07335462122	2024-06-21	64.38	2024-06-12	3	EURO
4262	Glovo 1	2024-06-21	10.95	2024-06-21	3	EURO
4263	Glovo 2	2024-06-21	10.95	2024-06-20	3	EURO
4264	Amazon 1	2024-06-21	52.40	2024-06-21	4	EURO
4265	Amazon 2	2024-06-21	39.59	2024-06-20	4	EURO
4266	Glovo 12JUN BR97CHKKX	2024-06-21	10.95	2024-09-13	4	EURO
4267	Glovo 13JUN BRG1RA1V1	2024-06-21	10.95	2024-09-14	4	EURO
4268	Glovo 13JUN BRT6SQ6Z3	2024-06-21	8.90	2024-09-14	4	EURO
4269	Glovo 14JUN BRBVP8WHU	2024-06-21	10.95	2024-09-15	4	EURO
4270	UBR PENDING.UBER.COM	2024-07-04	3.50	2024-07-04	3	EURO
4271	UBR PENDING.UBER.COM	2024-07-04	3.50	2024-07-04	3	EURO
4272	Glovo 02JUL BRKYVYZRE	2024-07-04	12.12	2024-07-04	3	EURO
4273	Glovo 02JUL BRYWVVNXZ	2024-07-04	10.95	2024-07-04	3	EURO
4274	CLINICA STA MADALENA BR	2024-07-04	11.70	2024-07-03	3	EURO
4275	UBR PENDING.UBER.COM	2024-07-04	3.59	2024-07-03	3	EURO
4276	UBR PENDING.UBER.COM	2024-07-04	4.03	2024-07-03	3	EURO
4277	Glovo 01JUL BRKXFKMNX	2024-07-04	8.35	2024-07-03	3	EURO
4278	Glovo 01JUL BRAZHNWNB	2024-07-04	10.95	2024-07-03	3	EURO
4279	Com.Transf.crédito não SEPA+ Em Linha(desp.OUR)	2024-07-04	25.00	2024-07-02	3	EURO
4280	Comissão Transf. a crédito não SEPA+ Em Linha	2024-07-04	17.50	2024-07-02	3	EURO
4281	Com. Transf. crédito não SEPA+ Em Linha (SWIFT)	2024-07-04	12.50	2024-07-02	3	EURO
4282	IVA  23%   s/Desp.SWIFT Ord.Pag.Ref.20241474340	2024-07-04	2.88	2024-07-02	3	EURO
4283	I.S.   4%  s/Com. OUR Ord. Pag. Ref.20241474340	2024-07-04	1.00	2024-07-02	3	EURO
4284	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20241474340	2024-07-04	0.70	2024-07-02	3	EURO
4285	UBR PENDING.UBER.COM	2024-07-04	5.46	2024-07-02	3	EURO
4286	UBR PENDING.UBER.COM	2024-07-04	4.94	2024-07-02	3	EURO
4287	Glovo 30JUN BRLCYKQUZ	2024-07-04	9.05	2024-07-02	3	EURO
4288	H3 NOVA ARCADA BRAGA PT	2024-07-04	10.15	2024-07-02	3	EURO
4289	CONTINENTE BRAGA BRAGA	2024-07-04	45.36	2024-07-02	3	EURO
4290	Glovo 29JUN BRTG41CJC	2024-07-04	8.30	2024-07-02	3	EURO
4291	Glovo 28JUN BRKHWPNDV	2024-07-04	9.30	2024-07-02	3	EURO
4292	Glovo 28JUN BRFCZW5BS	2024-07-04	10.95	2024-07-02	3	EURO
4293	LEV ATM 8281 BCP   Braga	2024-07-04	100.00	2024-07-02	3	EURO
4294	Glovo 27JUN BR5JLJKSR	2024-07-04	12.45	2024-07-01	3	EURO
4295	Glovo 27JUN BRMZF1JX3	2024-07-04	11.54	2024-07-01	3	EURO
4296	Glovo 27JUN BRWXXVUZM	2024-07-04	10.95	2024-07-01	3	EURO
4297	Glovo 26JUN BRLHBGRQW	2024-07-04	9.30	2024-06-28	3	EURO
4298	Glovo 26JUN BR1PT1SFQ	2024-07-04	10.95	2024-06-28	3	EURO
4299	Glovo 25JUN BRVWAEJ21	2024-07-04	10.95	2024-06-27	3	EURO
4300	Glovo 24JUN BR1MBT6AF	2024-07-04	9.45	2024-06-26	3	EURO
4301	UBR PENDING.UBER.COM	2024-07-04	5.94	2024-06-25	3	EURO
4302	UBR PENDING.UBER.COM	2024-07-04	5.96	2024-06-25	3	EURO
4303	UBR PENDING.UBER.COM	2024-07-04	3.95	2024-06-25	3	EURO
4304	UBR PENDING.UBER.COM	2024-07-04	3.61	2024-06-25	3	EURO
4305	Glovo 23JUN BRXZLP7VQ	2024-07-04	12.00	2024-06-25	3	EURO
4306	HUSSEL BRAGA PARQUE BRA	2024-07-04	4.16	2024-06-25	3	EURO
4307	PINGO DOCE BRAGA BRAGA	2024-07-04	6.91	2024-06-25	3	EURO
4308	H3 NOVA ARCADA BRAGA PT	2024-07-04	10.15	2024-06-25	3	EURO
4309	CONTINENTE BRAGA BRAGA	2024-07-04	71.90	2024-06-25	3	EURO
4310	Glovo 21JUN BRFYZQXE9	2024-07-04	12.12	2024-06-25	3	EURO
4311	Glovo 21JUN BR2F6QJ86	2024-07-04	10.95	2024-06-25	3	EURO
4312	Glovo 20JUN BR1SYMYDQ	2024-07-04	10.95	2024-06-24	3	EURO
4313	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-07-04	117.63	2024-06-24	3	EURO
4314	STM BRAGA	2024-07-04	2.80	2024-06-24	3	EURO
4315	Remessa Internacional	2024-07-04	7000.00	2024-07-04	3	REAL
4316	COMGAS 48353698	2024-07-04	11.39	2024-06-17	5	REAL
4317	VIVO FIXO 9324810660	2024-07-04	148.99	2024-06-17	5	REAL
4318	ELETROPAULO 56301179	2024-07-04	21.30	2024-07-01	5	REAL
4319	TAR PACOTE ITAU   JUN/24	2024-07-04	71.90	2024-07-02	5	REAL
4320	IOF CAMBIO01	2024-07-04	150.48	2024-07-04	5	REAL
4322	Glovo GLOVO PRIME	2024-07-04	5.99	2024-07-03	4	EURO
4323	Amazon Kindle Unltd	2024-07-04	19.90	2024-06-03	6	REAL
4324	Amazon Prime	2024-07-04	19.90	2024-06-03	6	REAL
4325	ANUIDADE DIFERENCIADA 07/12	2024-07-04	34.00	2024-06-04	6	REAL
4328	AMAZON MARKET PLACE 07/10	2024-07-04	82.09	2024-12-14	6	REAL
4329	APPLE.COM/BILL	2024-07-04	21.90	2024-06-20	6	REAL
4330	DM HELPMAXCOM	2024-07-04	34.90	2024-06-21	6	REAL
4331	ALURA 10/12	2024-07-04	92.65	2024-09-26	6	REAL
4332	EBN SPOTIFY	2024-07-04	21.90	2024-06-28	6	REAL
4333	STEAMGAMES.COM	2024-07-04	10.99	2024-06-28	6	REAL
4321	Salário Julho 2024	\N	3500.00	2024-07-31	3	EURO
4334	Amazon Prime	2024-07-04	19.90	2024-06-28	6	REAL
4335	Amazon Kindle Unltd	2024-07-04	19.90	2024-06-28	6	REAL
4336	Aluguel	2024-07-05	650.00	2024-07-05	3	EURO
4337	Condominio	2024-07-05	664.00	2024-07-15	5	REAL
4343	THE WALT DISNEY COMPAN	2024-07-06	33.90	2024-06-06	6	REAL
4344	NETFLIX.COM	2024-07-06	39.90	2024-06-11	6	REAL
4350	IOF TRANSACOES INTERNACIONAIS	2024-07-06	3.39	2024-06-27	6	REAL
4351	AMZN Mktp ES*HV5IG5T24 800-279-662	2024-07-06	66.44	2024-06-11	6	REAL
4353	Pagamento fatura 07/2024	2024-07-11	521.66	2024-07-06	5	REAL
4354	TRF. P/O  REEMBOLSOS   IRS            AT - REEM	2024-07-25	1999.79	2024-07-09	3	EURO
4355	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-25	3	EURO
4356	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-25	3	EURO
4357	Glovo 23JUL BRMT7FJ8A	2024-07-25	10.95	2024-07-25	3	EURO
4358	Glovo 22JUL BRKEPCRM6	2024-07-25	10.95	2024-07-24	3	EURO
4359	BRAGA RIO LOJA 306 BRAG	2024-07-25	10.80	2024-07-24	3	EURO
4360	HUSSEL BRAGA PARQUE BRA	2024-07-25	5.15	2024-07-24	3	EURO
4361	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-07-25	83.47	2024-07-24	3	EURO
4362	UBR PENDING.UBER.COM	2024-07-25	5.95	2024-07-23	3	EURO
4363	UBR PENDING.UBER.COM	2024-07-25	3.59	2024-07-23	3	EURO
4364	UBR PENDING.UBER.COM	2024-07-25	5.96	2024-07-23	3	EURO
4365	UBR PENDING.UBER.COM	2024-07-25	4.05	2024-07-23	3	EURO
4366	CONTINENTE BRAGA BRAGA	2024-07-25	56.93	2024-07-23	3	EURO
4367	Glovo 20JUL BRPPA1XQN	2024-07-25	9.10	2024-07-23	3	EURO
4368	Glovo 19JUL BR6JGNLXU	2024-07-25	8.80	2024-07-23	3	EURO
4369	Glovo 19JUL BR151MNF9	2024-07-25	10.95	2024-07-23	3	EURO
4370	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-22	3	EURO
4371	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-22	3	EURO
4372	Glovo 18JUL BRRCRE115	2024-07-25	16.40	2024-07-22	3	EURO
4373	Glovo 18JUL BRKDWJMF6	2024-07-25	10.95	2024-07-22	3	EURO
4374	DECATHLON BRAGA BRAGA P	2024-07-25	7.00	2024-07-19	3	EURO
4375	UBER TRIP	2024-07-25	7.94	2024-07-19	3	EURO
4376	UBR PENDING.UBER.COM	2024-07-25	4.62	2024-07-19	3	EURO
4377	Glovo 17JUL BR1LGFSCA	2024-07-25	10.95	2024-07-19	3	EURO
4378	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-18	3	EURO
4379	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-18	3	EURO
4380	Glovo 16JUL BR5YFFRZL	2024-07-25	10.95	2024-07-18	3	EURO
4381	Glovo 15JUL BR2XSQE1Y	2024-07-25	10.95	2024-07-17	3	EURO
4382	ARCADIA BRAGA PARQUE BR	2024-07-25	3.95	2024-07-16	3	EURO
4383	CIN BRAGA PARQUE BRAGA	2024-07-25	7.70	2024-07-16	3	EURO
4384	HUSSEL BRAGA PARQUE BRA	2024-07-25	4.82	2024-07-16	3	EURO
4385	UBR PENDING.UBER.COM	2024-07-25	3.78	2024-07-16	3	EURO
4386	UBR PENDING.UBER.COM	2024-07-25	5.95	2024-07-16	3	EURO
4387	UBR PENDING.UBER.COM	2024-07-25	5.95	2024-07-16	3	EURO
4388	UBR PENDING.UBER.COM	2024-07-25	4.07	2024-07-16	3	EURO
4389	TOMATINO BRAGA PARQU BR	2024-07-25	9.20	2024-07-16	3	EURO
4390	Glovo 14JUL BRFKLLG7L	2024-07-25	8.14	2024-07-16	3	EURO
4391	CONTINENTE BRAGA BRAGA	2024-07-25	58.36	2024-07-16	3	EURO
4392	Glovo 13JUL BR1HD6JQL	2024-07-25	10.10	2024-07-16	3	EURO
4393	Glovo 12JUL BRVCRC5RV	2024-07-25	9.30	2024-07-16	3	EURO
4394	Glovo 12JUL BRNL5XVQL	2024-07-25	10.95	2024-07-16	3	EURO
4395	Glovo 11JUL BRWQCBY6T	2024-07-25	9.30	2024-07-15	3	EURO
4396	Glovo 11JUL BRPU1S99S	2024-07-25	10.95	2024-07-15	3	EURO
4397	IMPOSTO DO SELO	2024-07-25	0.06	2024-07-12	3	EURO
4398	CUSTO DE SERVICO INTERNACIONAL	2024-07-25	1.58	2024-07-12	3	EURO
4399	OF LONDON GB     USD TC   0.9254742	2024-07-25	40.98	2024-07-12	3	EURO
4400	Glovo 10JUL BRHBQWT1X	2024-07-25	10.95	2024-07-12	3	EURO
4401	Glovo 10JUL BR3PKMKZ1	2024-07-25	9.30	2024-07-12	3	EURO
4402	DD PT10100825 VODAFONE PORTUG 07335462122	2024-07-25	63.68	2024-07-12	3	EURO
4403	COMISSAO TRF MBWAY 35.00 APP MILLENNIUM	2024-07-25	0.04	2024-07-11	3	EURO
4404	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-11	3	EURO
4405	UBR PENDING.UBER.COM	2024-07-25	3.50	2024-07-11	3	EURO
4406	Glovo 09JUL BRQ1KZKZF	2024-07-25	9.05	2024-07-11	3	EURO
4407	Glovo 09JUL BRLM2MMEJ	2024-07-25	10.95	2024-07-11	3	EURO
4408	TRF MB WAY P/ *****3053	2024-07-25	35.00	2024-07-10	3	EURO
4409	Glovo 08JUL BRD74RV1T	2024-07-25	10.95	2024-07-10	3	EURO
4412	UBR PENDING.UBER.COM	2024-07-25	4.01	2024-07-09	3	EURO
4413	UBR PENDING.UBER.COM	2024-07-25	3.75	2024-07-09	3	EURO
4414	UBR PENDING.UBER.COM	2024-07-25	5.95	2024-07-09	3	EURO
4415	UBR PENDING.UBER.COM	2024-07-25	5.96	2024-07-09	3	EURO
4416	CONTINENTE BRAGA BRAGA	2024-07-25	47.98	2024-07-09	3	EURO
4417	Glovo 07JUL BRVQ1Y1BR	2024-07-25	8.30	2024-07-09	3	EURO
4418	CORTES DE LISBOA BRAGA	2024-07-25	16.00	2024-07-09	3	EURO
4419	HUSSEL BRAGA PARQUE BRA	2024-07-25	5.37	2024-07-09	3	EURO
4420	SABOR SORRATEIRO LDA BR	2024-07-25	4.50	2024-07-09	3	EURO
4421	Glovo 06JUL BRCT1JFKS	2024-07-25	12.00	2024-07-09	3	EURO
4422	Glovo 05JUL BRP4JQEUD	2024-07-25	8.99	2024-07-09	3	EURO
4423	Glovo 05JUL BRXCVC4A9	2024-07-25	10.95	2024-07-09	3	EURO
4424	Glovo 04JUL BRLKZFVPB	2024-07-25	10.95	2024-07-08	3	EURO
4425	PAG SERV 21796/317953742 AGEREEMP.DE AGUAS,EFL	2024-07-25	20.12	2024-07-08	3	EURO
4426	IMPOSTO DE SELO 17.3.4	2024-07-25	0.21	2024-07-08	3	EURO
4427	COM. MANUTENCAO CONTA ORDENADO 062024	2024-07-25	5.20	2024-07-08	3	EURO
4428	Glovo 03JUL BRM1MBH8K	2024-07-25	8.35	2024-07-05	3	EURO
4429	Glovo 03JUL BRYSYDU1E	2024-07-25	10.95	2024-07-05	3	EURO
4430	AMAZON* 404-9889815-74	2024-07-25	88.14	2024-07-09	4	EURO
4410	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-07-25	0.04	2024-07-08	3	EURO
4431	OnlyFans 1	2024-07-25	9.11	2024-07-11	4	EURO
4432	OnlyFans 2	2024-07-25	18.22	2024-07-11	4	EURO
4433	OnlyFans 3	2024-07-25	3.42	2024-07-11	4	EURO
4434	VIVO FIXO	2024-07-25	148.99	2024-07-17	5	REAL
4435	COMGAS	2024-07-25	11.39	2024-07-16	5	REAL
4437	Glovo 31JUL BRLSWF1E1	2024-08-04	10.95	2024-08-02	3	EURO
4438	UBR PENDING.UBER.COM	2024-08-04	3.50	2024-08-01	3	EURO
4439	UBR PENDING.UBER.COM	2024-08-04	3.50	2024-08-01	3	EURO
4440	Glovo 30JUL BRX9V27QY	2024-08-04	16.20	2024-08-01	3	EURO
4441	Glovo 30JUL BRXMYEXVL	2024-08-04	10.95	2024-08-01	3	EURO
4442	AMAZON 404288987183 LUXEMBOURG LU	2024-08-04	69.51	2024-07-31	3	EURO
4443	Glovo 29JUL BRUWTLCRD	2024-08-04	10.95	2024-07-31	3	EURO
4444	LEV ATM 8281 BCP	2024-08-04	100.00	2024-07-30	3	EURO
4445	HUSSEL BRAGA PARQUE BRA	2024-08-04	5.58	2024-07-30	3	EURO
4446	UBR PENDING.UBER.COM	2024-08-04	3.50	2024-07-30	3	EURO
4447	UBR PENDING.UBER.COM	2024-08-04	5.94	2024-07-30	3	EURO
4448	UBR PENDING.UBER.COM	2024-08-04	5.93	2024-07-30	3	EURO
4449	UBR PENDING.UBER.COM	2024-08-04	3.94	2024-07-30	3	EURO
4450	TOMATINO BRAGA PARQU BR	2024-08-04	8.80	2024-07-30	3	EURO
4451	Glovo 28JUL BR7USLGWD	2024-08-04	14.90	2024-07-30	3	EURO
4452	CONTINENTE BRAGA BRAGA	2024-08-04	79.64	2024-07-30	3	EURO
4453	Glovo 27JUL BRGVNVVFM	2024-08-04	9.05	2024-07-30	3	EURO
4454	Glovo 26JUL BRC59GF9L	2024-08-04	16.40	2024-07-30	3	EURO
4455	Glovo 26JUL BRUQF1SHX	2024-08-04	8.30	2024-07-30	3	EURO
4456	Glovo 25JUL BRPZZ9R1M	2024-08-04	10.10	2024-07-29	3	EURO
4457	Glovo 25JUL BRSPGDBQ7	2024-08-04	10.95	2024-07-29	3	EURO
4458	Glovo 24JUL BR1DZW5J6	2024-08-04	10.95	2024-07-26	3	EURO
4470	ALURA 11/12	2024-08-27	92.65	2024-07-26	6	REAL
4471	AMAZON MARKETPLACE 08/10	2024-08-27	82.09	2024-07-14	6	REAL
4472	ANUIDADE DIFERENCIADA 08/12	2024-08-27	34.00	2024-07-05	6	REAL
4473	THE WALT DISNEY COMPAN	2024-08-27	33.90	2024-07-06	6	REAL
4474	NETFLIX.COM	2024-08-27	44.90	2024-07-11	6	REAL
4475	APPLE.COM/BILL	2024-08-27	21.90	2024-07-20	6	REAL
4476	DM *HELPMAXCOM	2024-08-27	34.90	2024-07-21	6	REAL
4477	EBN *SPOTIFY	2024-08-27	21.90	2024-07-28	6	REAL
4478	ZP *IO PRIVACY	2024-08-27	19.99	2024-07-30	6	REAL
4479	AMAZON	2024-08-27	134.90	2024-07-31	6	REAL
4480	AmazonPrimeBR	2024-08-27	19.90	2024-08-03	6	REAL
4481	Pagamento fatura 08/2024	2024-08-07	541.03	2024-08-27	5	REAL
4482	DA  ELETROPAULO 56301179	2024-08-27	21.32	2024-07-29	5	REAL
4483	TAR PACOTE ITAU   JUL/24	2024-08-27	71.90	2024-08-02	5	REAL
4484	MOBILE PAG TIT 775324902000	2024-08-27	664.00	2024-08-07	5	REAL
4485	DA  COMGAS 48353698	2024-08-27	11.39	2024-08-14	5	REAL
4486	DA  VIVO FIXO 9324810660	2024-08-27	148.99	2024-08-15	5	REAL
4487	DA  ELETROPAULO 56301179	2024-08-27	21.15	2024-08-29	5	REAL
4488	Cobrir conta	\N	2000.00	2024-08-21	3	EURO
4489	NOS CINEMAS APP	2024-08-27	7.70	2024-07-30	4	EURO
4490	Glovo GLOVO PRIME	2024-08-27	5.99	2024-08-03	4	EURO
4491	Only Fans	2024-08-27	6.77	2024-08-11	4	EURO
4492	FlyTAP Tickets	2024-08-27	1396.52	2024-08-22	4	EURO
4493	NOS CINEMAS APP	2024-08-27	7.70	2024-08-25	4	EURO
4494	Credito Amazon	2024-08-27	17.46	2024-08-13	3	EURO
4495	LEV ATM 8281 CGD   Maximinos     R Caires. 58	2024-08-27	100.00	2024-08-27	3	EURO
4496	FNAC BRAGA BRAGA PT	2024-08-27	24.70	2024-08-27	3	EURO
4497	UBR PENDING.UBER.COM	2024-08-27	3.52	2024-08-27	3	EURO
4498	UBR PENDING.UBER.COM	2024-08-27	5.92	2024-08-27	3	EURO
4499	UBR PENDING.UBER.COM	2024-08-27	5.93	2024-08-27	3	EURO
4500	UBR PENDING.UBER.COM	2024-08-27	4.05	2024-08-27	3	EURO
4501	POKE HOUSE BRAGA 13500	2024-08-27	11.00	2024-08-27	3	EURO
4502	CONTINENTE BRAGA BRAGA	2024-08-27	66.50	2024-08-27	3	EURO
4503	Glovo 24AUG BRN6R8Z1Y	2024-08-27	9.60	2024-08-27	3	EURO
4504	Glovo 24AUG BRB4C1KJX	2024-08-27	8.35	2024-08-27	3	EURO
4505	Glovo 23AUG BRJ7R7KHW	2024-08-27	15.84	2024-08-27	3	EURO
4506	Glovo 23AUG BRPAZKBUX	2024-08-27	10.95	2024-08-27	3	EURO
4507	DD PT34100781 EDP COMERCIALC 16010011942146	2024-08-27	80.89	2024-08-26	3	EURO
4508	Glovo 22AUG BREL4EPSY	2024-08-27	10.95	2024-08-23	3	EURO
4509	MINIPRECO MAXIMINOS PT	2024-08-27	3.59	2024-08-23	3	EURO
4510	Glovo 21AUG BR1S2YPW4	2024-08-27	10.95	2024-08-23	3	EURO
4511	Glovo 20AUG BRM4RAJXJ	2024-08-27	10.95	2024-08-22	3	EURO
4512	Glovo 19AUG BR1NRXRLC	2024-08-27	10.80	2024-08-21	3	EURO
4513	Glovo 19AUG BRCB1UCDQ	2024-08-27	10.95	2024-08-21	3	EURO
4515	I.S.  4%  s/Com.Emis. Ord. Pag. Ref.20241874952	2024-08-27	0.04	2024-08-20	3	EURO
4516	UBR PENDING.UBER.COM	2024-08-27	5.93	2024-08-20	3	EURO
4517	UBR PENDING.UBER.COM	2024-08-27	5.91	2024-08-20	3	EURO
4518	Glovo 18AUG BR6RVM76T	2024-08-27	9.05	2024-08-20	3	EURO
4519	CONTINENTE BRAGA BRAGA	2024-08-27	57.40	2024-08-20	3	EURO
4520	Glovo 17AUG BRAPBSR8T	2024-08-27	12.12	2024-08-20	3	EURO
4521	Glovo 16AUG BRLJPW611	2024-08-27	10.75	2024-08-20	3	EURO
4522	Glovo 16AUG BR1R21USD	2024-08-27	10.85	2024-08-20	3	EURO
4523	PAPPA LAB GELATARIA BRA	2024-08-27	4.20	2024-08-19	3	EURO
4524	Glovo 15AUG BRRNCLVRH	2024-08-27	13.55	2024-08-19	3	EURO
4525	Glovo 14AUG BRAN9D1MA	2024-08-27	8.30	2024-08-16	3	EURO
4526	Glovo 13AUG BRMJJJVUQ	2024-08-27	12.00	2024-08-15	3	EURO
4527	Glovo 12AUG BRQV1FQUL	2024-08-27	8.35	2024-08-14	3	EURO
4528	UBR PENDING.UBER.COM	2024-08-27	4.43	2024-08-13	3	EURO
4529	UBR PENDING.UBER.COM	2024-08-27	5.91	2024-08-13	3	EURO
4530	UBER TRIP	2024-08-27	10.00	2024-08-13	3	EURO
4531	UBR PENDING.UBER.COM	2024-08-27	5.91	2024-08-13	3	EURO
4532	UBR PENDING.UBER.COM	2024-08-27	3.50	2024-08-13	3	EURO
4533	UBR PENDING.UBER.COM	2024-08-27	3.50	2024-08-13	3	EURO
4534	Glovo 11AUG BRHDELAQ4	2024-08-27	11.85	2024-08-13	3	EURO
4535	WORTEN BRAGA NOVA BRAGA	2024-08-27	219.99	2024-08-13	3	EURO
4536	CONTINENTE BRAGA BRAGA	2024-08-27	45.59	2024-08-13	3	EURO
4537	Glovo 10AUG BRPHS112J	2024-08-27	18.30	2024-08-13	3	EURO
4538	Glovo 09AUG BRUPGV1WV	2024-08-27	10.95	2024-08-13	3	EURO
4539	Glovo 09AUG BRSRUQEWN	2024-08-27	16.40	2024-08-13	3	EURO
4540	DD PT10100825 VODAFONE PORTUG 07335462122	2024-08-27	63.68	2024-08-13	3	EURO
4541	Glovo 08AUG BRACKK91K	2024-08-27	10.95	2024-08-12	3	EURO
4542	PAG SERV 21796/324920942 AGEREEMP.DE AGUAS.EFL	2024-08-27	22.36	2024-08-12	3	EURO
4543	IMPOSTO DE SELO 17.3.4	2024-08-27	0.21	2024-08-12	3	EURO
4544	COM. MANUTENCAO CONTA ORDENADO 072024	2024-08-27	5.20	2024-08-12	3	EURO
4545	Glovo 07AUG BRX5YPLPG	2024-08-27	9.55	2024-08-09	3	EURO
4546	Glovo 07AUG BRX7HHFUU	2024-08-27	10.95	2024-08-09	3	EURO
4547	IMPOSTO DO SELO	2024-08-27	0.01	2024-08-08	3	EURO
4548	COMISSAO TRF MBWAY 140.00 APP MILLENNIUM	2024-08-27	0.14	2024-08-08	3	EURO
4549	Glovo 06AUG BRWAJGUPB	2024-08-27	10.95	2024-08-08	3	EURO
4550	TRF MB WAY P/ *****3053	2024-08-27	140.00	2024-08-07	3	EURO
4551	Glovo 05AUG BRDWTKCBA	2024-08-27	10.95	2024-08-07	3	EURO
4554	TRF P/ Lucinda dona da casa	2024-08-27	650.00	2024-08-06	3	EURO
4555	UBER TRIP	2024-08-27	6.00	2024-08-06	3	EURO
4556	UBR PENDING.UBER.COM	2024-08-27	3.74	2024-08-06	3	EURO
4557	UBR PENDING.UBER.COM	2024-08-27	4.58	2024-08-06	3	EURO
4558	Glovo 04AUG BRKAX6VJM	2024-08-27	12.98	2024-08-06	3	EURO
4559	Glovo 04AUG BRV8L1TUB	2024-08-27	8.30	2024-08-06	3	EURO
4560	IKEA BRAGA CAIXAS ECO B	2024-08-27	17.69	2024-08-06	3	EURO
4561	CONTINENTE BRAGA BRAGA	2024-08-27	66.22	2024-08-06	3	EURO
4562	Glovo 03AUG BRTXSKK1B	2024-08-27	8.35	2024-08-06	3	EURO
4563	MARTINS E MARTINS LD MA	2024-08-27	1.45	2024-08-06	3	EURO
4564	Glovo 02AUG BREQ2YZAK	2024-08-27	16.40	2024-08-06	3	EURO
4565	Glovo 02AUG BRCZ1H6RZ	2024-08-27	10.95	2024-08-06	3	EURO
4566	Glovo 01AUG BRH6CLJCL	2024-08-27	10.95	2024-08-05	3	EURO
4567	GLOVO BR2Q4T3L6	2024-08-27	10.95	2024-08-27	3	EURO
4568	GLOVO BRCETPNH1	2024-08-27	9.60	2024-08-26	3	EURO
4570	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-09-05	3	EURO
4571	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-09-05	3	EURO
4572	Glovo 03SEP BRNSKDNTX	2024-09-06	10.10	2024-09-05	3	EURO
4573	FARMACIA PINHEIRO BRAGA	2024-09-06	41.12	2024-09-04	3	EURO
4574	Glovo 02SEP BRFJER2ZU	2024-09-06	10.95	2024-09-04	3	EURO
4575	LEV ATM 8281 CGD   Maximinos     R Caires, 58	2024-09-06	100.00	2024-09-03	3	EURO
4576	H T SAUDE BRAGA SUL BRA	2024-09-06	45.00	2024-09-03	3	EURO
4577	UBR PENDING.UBER.COM	2024-09-06	5.95	2024-09-03	3	EURO
4578	UBR PENDING.UBER.COM	2024-09-06	4.55	2024-09-03	3	EURO
4579	UBR PENDING.UBER.COM	2024-09-06	3.59	2024-09-03	3	EURO
4580	UBR PENDING.UBER.COM	2024-09-06	3.70	2024-09-03	3	EURO
4581	UBR PENDING.UBER.COM	2024-09-06	4.14	2024-09-03	3	EURO
4582	Glovo 01SEP BRWKEUZHW	2024-09-06	8.30	2024-09-03	3	EURO
4583	Glovo 01SEP BRSZNP1RU	2024-09-06	10.10	2024-09-03	3	EURO
4584	CORTES DE LISBOA BRAGA	2024-09-06	19.00	2024-09-03	3	EURO
4585	ARCADIA NOVA ARCADA BRA	2024-09-06	2.10	2024-09-03	3	EURO
4586	ARCADIA NOVA ARCADA BRA	2024-09-06	5.60	2024-09-03	3	EURO
4587	CONTINENTE BRAGA BRAGA	2024-09-06	44.27	2024-09-03	3	EURO
4588	Glovo 31AUG BR1MBQBC1	2024-09-06	9.60	2024-09-03	3	EURO
4589	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-09-03	3	EURO
4590	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-09-03	3	EURO
4591	Glovo 30AUG BRDY8MHEL	2024-09-06	13.55	2024-09-03	3	EURO
4592	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-09-02	3	EURO
4593	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-09-02	3	EURO
4594	Glovo 28AUG BRK1VPR11	2024-09-06	8.90	2024-08-30	3	EURO
4595	Glovo 28AUG BRPDASPCU	2024-09-06	10.95	2024-08-30	3	EURO
4596	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-08-29	3	EURO
4597	UBR PENDING.UBER.COM	2024-09-06	3.50	2024-08-29	3	EURO
4598	Glovo 27AUG BR14YTL61	2024-09-06	16.92	2024-08-29	3	EURO
4599	GLOVO PRIME	2024-09-06	5.99	2024-09-03	4	EURO
4600	tar pacote itau	2024-09-06	71.90	2024-09-03	5	REAL
4601	GLOVO 05SEP BRJ8D41JD	2024-09-06	11.00	2024-09-05	3	EURO
4603	GLOVO 05SEP BRYAF6Q9M	2024-09-06	10.95	2024-09-04	3	EURO
4604	ALURA 12/12	2024-09-06	92.65	2024-08-26	6	REAL
4605	AMAZON MARKETPLACE 09/10	2024-09-06	82.09	2024-08-14	6	REAL
4606	Disney Plus BR	2024-09-06	43.90	2024-08-06	6	REAL
4607	ANUIDADE DIFERENCIADA 09/12	2024-09-06	34.00	2024-08-06	6	REAL
4608	NETFLIX.COM	2024-09-06	44.90	2024-08-11	6	REAL
4609	APPLE.COM/BILL	2024-09-06	21.90	2024-08-20	6	REAL
4610	DM*HELPMAXCOM	2024-09-06	34.90	2024-08-21	6	REAL
4611	ALURA 01/12	2024-09-06	87.20	2024-08-28	6	REAL
4612	EBN *SPOTIFY	2024-09-06	21.90	2024-08-28	6	REAL
4613	UBR PENDING.UBER.COM	2024-09-10	5.92	2024-09-10	3	EURO
4614	UBR PENDING.UBER.COM	2024-09-10	5.93	2024-09-10	3	EURO
4615	CONTINENTE BRAGA BRAGA	2024-09-10	53.07	2024-09-10	3	EURO
4616	Glovo 07SEP BRSZMK1TU	2024-09-10	18.30	2024-09-10	3	EURO
4569	Salário Setembro 2024	\N	3500.00	2024-09-30	3	EURO
4436	Salário Agosto 2024	\N	5597.00	2024-08-31	3	EURO
4552	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-08-27	0.04	2024-08-06	3	EURO
4617	CUSTO DE SERVICO INTERNACIONAL	2024-09-10	0.12	2024-09-10	3	EURO
4618	AmazonPrimeBR AM BRL TC   0.1623115	2024-09-10	3.23	2024-09-10	3	EURO
4619	CARMO SOARES LDA BRAGA	2024-09-10	90.00	2024-09-10	3	EURO
4620	Glovo 06SEP BRXBL6J2A	2024-09-10	13.32	2024-09-10	3	EURO
4621	Glovo 06SEP BRVPTWSTZ	2024-09-10	9.30	2024-09-10	3	EURO
4622	Glovo 06SEP BRWGQ6ZWJ	2024-09-10	10.95	2024-09-10	3	EURO
4625	Glovo 05SEP BRDFWL8R8	2024-09-10	10.95	2024-09-06	3	EURO
4627	IMPOSTO DE SELO 17.3.4	2024-09-10	0.21	2024-09-06	3	EURO
4628	COM. MANUTENCAO CONTA ORDENADO 082024	2024-09-10	5.20	2024-09-06	3	EURO
4629	TRF P/ Lucinda dona da casa	2024-09-10	650.00	2024-09-06	3	EURO
4631	Agere	2024-09-10	21.33	2024-09-10	3	EURO
4632	Pagamento fatura 09/2024	2024-09-10	463.44	2024-09-10	5	REAL
4633	Condominio	2024-09-10	664.00	2024-09-10	5	REAL
4634	COMISSAO TRF MBWAY 40.00 APP MILLENNIUM	2024-10-05	0.04	2024-10-04	3	EURO
4635	CARMO SOARES LDA BRAGA	2024-10-05	90.00	2024-10-04	3	EURO
4636	TRF MB WAY P/ *****9710	2024-10-05	40.00	2024-10-03	3	EURO
4637	CORTES DE LISBOA BRAGA	2024-10-05	16.00	2024-10-03	3	EURO
4638	HUSSEL BRAGA PARQUE BRA	2024-10-05	6.18	2024-10-03	3	EURO
4639	TOMATINO BRAGA PARQU BR	2024-10-05	8.25	2024-10-03	3	EURO
4640	UBR PENDING.UBER.COM	2024-10-05	4.97	2024-10-03	3	EURO
4641	UBR PENDING.UBER.COM	2024-10-05	4.91	2024-10-03	3	EURO
4642	UBR PENDING.UBER.COM	2024-10-05	6.95	2024-10-03	3	EURO
4643	Glovo 01OCT BRH1XETH7	2024-10-05	10.95	2024-10-03	3	EURO
4644	GLOVO LISBOA PT	2024-10-05	11.65	2024-10-02	3	EURO
4645	UBR PENDING.UBER.COM	2024-10-05	4.96	2024-10-01	3	EURO
4646	UBR PENDING.UBER.COM	2024-10-05	6.91	2024-10-01	3	EURO
4647	UBR PENDING.UBER.COM	2024-10-05	4.21	2024-10-01	3	EURO
4648	UBR PENDING.UBER.COM	2024-10-05	6.97	2024-10-01	3	EURO
4649	UBR PENDING.UBER.COM	2024-10-05	6.92	2024-10-01	3	EURO
4650	CONTINENTE BRAGA BRAGA	2024-10-05	48.32	2024-10-01	3	EURO
4651	GLOVO LISBOA PT	2024-10-05	10.10	2024-10-01	3	EURO
4652	GLOVO LISBOA PT	2024-10-05	8.30	2024-10-01	3	EURO
4653	GLOVO LISBOA PT	2024-10-05	9.80	2024-10-01	3	EURO
4654	Glovo 27SEP BRFYTJL12	2024-10-05	16.84	2024-10-01	3	EURO
4655	Glovo 27SEP BRZBLL4DA	2024-10-05	10.95	2024-10-01	3	EURO
4656	LA ROTISSERIE BRAGA	2024-10-05	11.20	2024-09-30	3	EURO
4657	HOSPITAL PRIV BRAGA BRA	2024-10-05	15.00	2024-09-27	3	EURO
4658	UBR PENDING.UBER.COM	2024-10-05	3.96	2024-09-27	3	EURO
4659	UBR PENDING.UBER.COM	2024-10-05	3.86	2024-09-27	3	EURO
4660	Glovo 25SEP BRBAPXQP1	2024-10-05	10.95	2024-09-27	3	EURO
4661	UBR PENDING.UBER.COM	2024-10-05	4.08	2024-09-26	3	EURO
4662	UBR PENDING.UBER.COM	2024-10-05	4.07	2024-09-26	3	EURO
4663	Glovo 24SEP BRR11KD7F	2024-10-05	10.95	2024-09-26	3	EURO
4664	GLOVO LISBOA PT	2024-10-05	10.95	2024-09-25	3	EURO
4665	UBR PENDING.UBER.COM	2024-10-05	6.98	2024-09-24	3	EURO
4666	UBR PENDING.UBER.COM	2024-10-05	6.95	2024-09-24	3	EURO
4667	Glovo 22SEP BRTN1JSML	2024-10-05	13.55	2024-09-24	3	EURO
4668	TOMATINO NOVA ARCADA BR	2024-10-05	8.95	2024-09-24	3	EURO
4669	CONTINENTE BRAGA BRAGA	2024-10-05	48.46	2024-09-24	3	EURO
4670	UBR PENDING.UBER.COM	2024-10-05	3.50	2024-09-24	3	EURO
4671	UBR PENDING.UBER.COM	2024-10-05	3.50	2024-09-24	3	EURO
4672	GLOVO LISBOA PT	2024-10-05	16.40	2024-09-24	3	EURO
4673	Glovo 20SEP BR985LNHK	2024-10-05	10.95	2024-09-24	3	EURO
4674	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-10-05	79.72	2024-09-24	3	EURO
4675	UBR PENDING.UBER.COM	2024-10-05	3.50	2024-09-23	3	EURO
4676	UBR PENDING.UBER.COM	2024-10-05	3.50	2024-09-23	3	EURO
4677	Glovo 19SEP BRRLL6YUH	2024-10-05	10.95	2024-09-23	3	EURO
4678	GLOVO LISBOA PT	2024-10-05	10.95	2024-09-20	3	EURO
4679	HOSPITAL PRIV BRAGA BRA	2024-10-05	17.50	2024-09-19	3	EURO
4680	UBR PENDING.UBER.COM	2024-10-05	3.50	2024-09-19	3	EURO
4681	UBR PENDING.UBER.COM	2024-10-05	3.50	2024-09-19	3	EURO
4682	GLOVO LISBOA PT	2024-10-05	10.85	2024-09-19	3	EURO
4683	GLOVO LISBOA PT	2024-10-05	10.95	2024-09-18	3	EURO
4684	UBR PENDING.UBER.COM	2024-10-05	5.17	2024-09-17	3	EURO
4685	UBR PENDING.UBER.COM	2024-10-05	5.90	2024-09-17	3	EURO
4686	GLOVO LISBOA PT	2024-10-05	13.55	2024-09-17	3	EURO
4687	CONTINENTE BRAGA BRAGA	2024-10-05	57.53	2024-09-17	3	EURO
4688	GLOVO LISBOA PT	2024-10-05	10.10	2024-09-17	3	EURO
4689	Glovo 13SEP BRANSLGZ2	2024-10-05	10.95	2024-09-17	3	EURO
4690	Glovo 12SEP BR15L4HC4	2024-10-05	10.95	2024-09-16	3	EURO
4691	Amazon.de XU8V86VH5 AMAZON.DE LU	2024-10-05	56.96	2024-09-13	3	EURO
4692	Glovo 11SEP BRANPSC8Y	2024-10-05	10.95	2024-09-13	3	EURO
4693	HOSPITAL PRIV BRAGA BRA	2024-10-05	27.65	2024-09-12	3	EURO
4694	UBR PENDING.UBER.COM	2024-10-05	3.15	2024-09-12	3	EURO
4695	UBR PENDING.UBER.COM	2024-10-05	3.15	2024-09-12	3	EURO
4696	Glovo 10SEP BRHAYNBT7	2024-10-05	10.10	2024-09-12	3	EURO
4697	AMZN Mktp ES RZ6V13V85 8002796620	2024-10-05	219.41	2024-09-12	3	EURO
4698	Glovo 10SEP BRURT1U11	2024-10-05	10.95	2024-09-12	3	EURO
4699	Glovo 09SEP BRSA6BYZZ	2024-10-05	8.30	2024-09-11	3	EURO
4700	DD PT10100825 VODAFONE PORTUG 07335462122	2024-10-05	65.55	2024-09-11	3	EURO
4702	UBER 1	2024-10-05	5.84	2024-10-05	3	EURO
4703	CONTINENTE BRAGA	2024-10-05	51.42	2024-10-05	3	EURO
4704	UBER 2	2024-10-05	4.72	2024-10-05	3	EURO
4701	GLOVO LISB 20241005	2024-10-05	8.90	2024-10-05	3	EURO
4624	Comissão Transferência a crédito SEPA+ Em Linha	2024-09-10	1.10	2024-09-09	3	EURO
4623	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-09-10	0.04	2024-09-09	3	EURO
4706	GLOVO LISB 20241004 - 2	2024-10-05	10.95	2024-10-04	3	EURO
4707	UBER 3	2024-10-05	3.00	2024-10-04	3	EURO
4708	FRIGIDEIRA	2024-10-05	7.50	2024-10-04	3	EURO
4709	UBER 4	2024-10-05	3.00	2024-10-04	3	EURO
4710	UBER 5	2024-10-05	3.40	2024-10-03	3	EURO
4711	UBER 6	2024-10-05	3.83	2024-10-03	3	EURO
4712	GLOVO LISB 20241003	2024-10-05	10.95	2024-10-03	3	EURO
4713	tar pacote itau	2024-10-05	71.90	2024-10-02	5	REAL
4714	eletropaulo	2024-10-05	21.38	2024-09-30	5	REAL
4715	vivo fixo	2024-10-05	148.99	2024-09-16	5	REAL
4716	gas	2024-10-05	11.39	2024-09-16	5	REAL
4717	Aluguel Outubro 2024	2024-10-05	650.00	2024-10-07	3	EURO
4719	Glovo Prime	2024-10-05	5.99	2024-10-03	4	EURO
4720	Only Fans	2024-10-05	6.69	2024-09-10	4	EURO
3607	Salário Janeiro 2024	\N	3500.00	2024-01-31	3	EURO
3890	Salário Abril 2024	\N	3500.00	2024-04-30	3	EURO
4046	Sálario Maio 2024	\N	3500.00	2024-05-31	3	EURO
4718	Salário Outubro 2024	\N	3500.00	2024-10-31	3	EURO
4721	Condominio	2024-10-07	664.00	2024-10-07	5	REAL
4722	AMAZON MARKETPLACE 10/10	2024-10-07	82.09	2024-09-14	6	REAL
4723	ALURA 02/12	2024-10-07	87.20	2024-08-29	6	REAL
4724	ANUIDADE DIFERENCIADA	2024-10-07	34.00	2024-09-05	6	REAL
4725	Disney Plus	2024-10-07	43.90	2024-09-06	6	REAL
4726	mobly *MOBLY	2024-10-07	179.56	2024-09-07	6	REAL
4727	NETFLIX.COM	2024-10-07	44.90	2024-09-11	6	REAL
4728	APPLE.COM/BILL	2024-10-07	21.90	2024-09-20	6	REAL
4729	DM*HELPMAXCOM	2024-10-07	39.90	2024-09-21	6	REAL
4730	EBN*SPOTIFY	2024-10-07	21.90	2024-09-28	6	REAL
4731	Pagamento fatura 10/2024	2024-10-07	555.35	2024-10-07	5	REAL
4705	GLOVO LISB 20241004	2024-10-05	18.50	2024-10-04	3	EURO
4732	TRF MB WAY P/ *****9710	2024-10-10	65.00	2024-10-11	3	EURO
4733	HUSSEL BRAGA PARQUE BRA	2024-10-10	5.04	2024-10-10	3	EURO
4734	PINGO DOCE BRAGA BRAGA	2024-10-10	11.06	2024-10-10	3	EURO
4735	HOSPITAL PRIV BRAGA BRA	2024-10-10	17.50	2024-10-10	3	EURO
4736	UBR PENDING.UBER.COM	2024-10-10	5.97	2024-10-10	3	EURO
4737	UBR PENDING.UBER.COM	2024-10-10	4.75	2024-10-10	3	EURO
4738	UBR PENDING.UBER.COM	2024-10-10	4.87	2024-10-09	3	EURO
4739	UBR PENDING.UBER.COM	2024-10-10	4.42	2024-10-09	3	EURO
4740	Glovo 07OCT BRL1DYR11 Lisbon ES	2024-10-10	8.30	2024-10-09	3	EURO
4743	LEV ATM 8281 CGD   Maximinos     R Caires, 58	2024-10-10	100.00	2024-10-08	3	EURO
4744	IMPOSTO DO SELO	2024-10-10	0.01	2024-10-08	3	EURO
4745	CUSTO DE SERVICO INTERNACIONAL	2024-10-10	0.13	2024-10-08	3	EURO
4746	AmazonPrimeBR AM BRL TC   0.1673366	2024-10-10	3.33	2024-10-08	3	EURO
4747	Glovo 06OCT BRQEX9RLL Lisbon ES	2024-10-10	11.30	2024-10-08	3	EURO
4742	Comissão Transferência a crédito SEPA+ Em Linha	2024-10-10	1.10	2024-10-08	3	EURO
4741	IMP.  SELO  COM. TRANSFERENCIA (TAXA DE 4%)	2024-10-10	0.04	2024-10-08	3	EURO
3321	Comissão Transferência a crédito SEPA+ Em Linha	2023-10-21	1.10	2023-10-06	3	EURO
3692	Comissão Transferência a crédito SEPA+ Em Linha	2024-04-29	1.10	2024-01-17	3	EURO
4138	Comissão Transferência a crédito SEPA+ Em Linha	2024-06-03	1.10	2024-05-07	3	EURO
4411	Comissão Transferência a crédito SEPA+ Em Linha	2024-07-25	1.10	2024-07-08	3	EURO
4514	Comissão Transferência a crédito SEPA+ Em Linha	2024-08-27	1.10	2024-08-20	3	EURO
4553	Comissão Transferência a crédito SEPA+ Em Linha	2024-08-27	1.10	2024-08-06	3	EURO
4748	CRED. 8281 AmazonPrimeBR AMZ BRL TC   0.1628140	2024-11-02	3.24	2024-10-15	3	EURO
4749	COMISSAO TRF MBWAY 40.00 APP MILLENNIUM	2024-11-02	0.04	2024-11-01	3	EURO
4750	UBR PENDING.UBER.COM	2024-11-02	3.36	2024-11-01	3	EURO
4751	BOLT.EU O 2410311846 Tallinn EE	2024-11-02	6.60	2024-11-01	3	EURO
4752	GLOVO LISBOA PT	2024-11-02	8.70	2024-11-01	3	EURO
4753	TRF MB WAY P/ *****9710	2024-11-02	40.00	2024-11-01	3	EURO
4754	UBR PENDING.UBER.COM	2024-11-02	3.61	2024-11-01	3	EURO
4755	UBR PENDING.UBER.COM	2024-11-02	5.64	2024-11-01	3	EURO
4756	UBR PENDING.UBER.COM	2024-11-02	4.61	2024-11-01	3	EURO
4757	UBR PENDING.UBER.COM	2024-11-02	3.42	2024-10-31	3	EURO
4758	UBR PENDING.UBER.COM	2024-11-02	3.35	2024-10-31	3	EURO
4759	Glovo 28OCT BRALMPHYH	2024-11-02	10.95	2024-10-30	3	EURO
4760	Glovo 27OCT BRH5H111J	2024-11-02	11.30	2024-10-29	3	EURO
4761	ARCADIA NOVA ARCADA BRA	2024-11-02	9.90	2024-10-29	3	EURO
4762	CONTINENTE BRAGA BRAGA	2024-11-02	58.15	2024-10-29	3	EURO
4763	UBER TRIP	2024-11-02	6.03	2024-10-29	3	EURO
4764	UBR PENDING.UBER.COM	2024-11-02	5.61	2024-10-29	3	EURO
4765	GLOVO LISBOA PT 1	2024-11-02	10.10	2024-10-29	3	EURO
4766	GLOVO LISBOA PT	2024-11-02	9.60	2024-10-29	3	EURO
4767	Glovo 25OCT BRBZA1WUH	2024-11-02	10.95	2024-10-29	3	EURO
4768	COMISSAO TRF MBWAY 40.00 APP MILLENNIUM	2024-11-02	0.04	2024-10-25	3	EURO
4769	UBR PENDING.UBER.COM	2024-11-02	3.30	2024-10-25	3	EURO
4770	UBR PENDING.UBER.COM	2024-11-02	3.33	2024-10-25	3	EURO
4771	GLOVO LISBOA PT	2024-11-02	9.69	2024-10-25	3	EURO
4772	Glovo 24OCT BRETH3MGJ	2024-11-02	10.95	2024-10-25	3	EURO
4773	TRF MB WAY P/ *****9710	2024-11-02	40.00	2024-10-25	3	EURO
4774	Glovo 23OCT BR8JB1PAX	2024-11-02	10.95	2024-10-25	3	EURO
4775	UBR PENDING.UBER.COM	2024-11-02	3.47	2024-10-24	3	EURO
4776	UBR PENDING.UBER.COM	2024-11-02	3.43	2024-10-24	3	EURO
4777	HUSSEL BRAGA PARQUE BRA	2024-11-02	3.55	2024-10-24	3	EURO
4778	ARCADIA BRAGA PARQUE BR	2024-11-02	3.95	2024-10-24	3	EURO
4779	DD PT34100781 EDP COMERCIAL C 16010011942146	2024-11-02	82.99	2024-10-24	3	EURO
4780	FARMACIA MADALENA 4700207 BRAGA	2024-11-02	15.95	2024-10-23	3	EURO
4781	UBR PENDING.UBER.COM	2024-11-02	4.11	2024-10-23	3	EURO
4782	UBR PENDING.UBER.COM	2024-11-02	3.93	2024-10-23	3	EURO
4783	GLOVO LISBOA PT	2024-11-02	9.05	2024-10-23	3	EURO
4784	ARCADIA NOVA ARCADA BRA	2024-11-02	8.60	2024-10-22	3	EURO
4785	CONTINENTE BRAGA BRAGA	2024-11-02	59.11	2024-10-22	3	EURO
4786	UBR PENDING.UBER.COM	2024-11-02	6.02	2024-10-22	3	EURO
4787	UBR PENDING.UBER.COM	2024-11-02	5.74	2024-10-22	3	EURO
4788	COMISSAO TRF MBWAY 40.00 APP MILLENNIUM	2024-11-02	0.04	2024-10-18	3	EURO
4789	UBR PENDING.UBER.COM	2024-11-02	3.35	2024-10-18	3	EURO
4790	UBR PENDING.UBER.COM	2024-11-02	3.37	2024-10-18	3	EURO
4791	GLOVO LISBOA PT	2024-11-02	9.00	2024-10-18	3	EURO
4792	GLOVO LISBOA PT	2024-11-02	8.30	2024-10-18	3	EURO
4793	TRF MB WAY P/ *****9710	2024-11-02	40.00	2024-10-18	3	EURO
4794	FARMACIA MADALENA 4700207 BRAGA	2024-11-02	54.26	2024-10-18	3	EURO
4795	Glovo 16OCT BRW1PPHBY	2024-11-02	7.18	2024-10-18	3	EURO
4796	Glovo 16OCT BRFEUQETB	2024-11-02	8.35	2024-10-18	3	EURO
4797	UBR PENDING.UBER.COM	2024-11-02	3.35	2024-10-17	3	EURO
4798	UBR PENDING.UBER.COM	2024-11-02	3.36	2024-10-17	3	EURO
4799	GLOVO LISBOA PT	2024-11-02	10.55	2024-10-17	3	EURO
4800	GLOVO LISBOA PT	2024-11-02	13.10	2024-10-16	3	EURO
4801	HUSSEL BRAGA PARQUE BRA	2024-11-02	5.95	2024-10-15	3	EURO
4802	ARCADIA BRAGA PARQUE BR	2024-11-02	3.95	2024-10-15	3	EURO
4803	UBR PENDING.UBER.COM	2024-11-02	3.53	2024-10-15	3	EURO
4804	UBR PENDING.UBER.COM	2024-11-02	5.73	2024-10-15	3	EURO
4805	UBR PENDING.UBER.COM	2024-11-02	5.89	2024-10-15	3	EURO
4806	UBR PENDING.UBER.COM	2024-11-02	4.14	2024-10-15	3	EURO
4807	GLOVO LISBOA PT	2024-11-02	9.10	2024-10-15	3	EURO
4808	POKE HOUSE BRAGA 13500	2024-11-02	11.00	2024-10-15	3	EURO
4809	CONTINENTE BRAGA BRAGA	2024-11-02	56.27	2024-10-15	3	EURO
4810	H T SAUDE BRAGA SUL BRA	2024-11-02	17.50	2024-10-15	3	EURO
4811	UBR PENDING.UBER.COM	2024-11-02	5.26	2024-10-15	3	EURO
4812	UBR PENDING.UBER.COM	2024-11-02	5.30	2024-10-15	3	EURO
4813	Glovo 11OCT BR15LPCEZ	2024-11-02	11.30	2024-10-15	3	EURO
4814	ANUL CUSTO DE SERVICO INTERNACIONAL	2024-11-02	0.12	2024-10-15	3	EURO
4815	IMP.  SELO  COM. TRANSFERENCIA (à TAXA DE 4%)	2024-11-02	0.04	2024-10-14	3	EURO
4816	Comissão Transferência a crédito SEPA+ Em Linha	2024-11-02	1.10	2024-10-14	3	EURO
4817	COMISSAO TRF MBWAY 65.00 APP MILLENNIUM	2024-11-02	0.07	2024-10-14	3	EURO
4818	UBR PENDING.UBER.COM	2024-11-02	3.33	2024-10-14	3	EURO
4819	UBR PENDING.UBER.COM	2024-11-02	4.79	2024-10-14	3	EURO
4820	Glovo 10OCT BRYJSWJPP	2024-11-02	11.12	2024-10-14	3	EURO
4821	GLOVO LISBOA PT	2024-11-02	11.10	2024-10-14	3	EURO
4822	GLOVO LISBOA PT	2024-11-02	10.10	2024-10-14	3	EURO
4823	IMPOSTO DE SELO 17.3.4	2024-11-02	0.21	2024-10-11	3	EURO
4824	COM. MANUTENCAO CONTA ORDENADO 092024	2024-11-02	5.20	2024-10-11	3	EURO
4825	TRF P/ CLUBE TENIS BRAGA	2024-11-02	40.50	2024-10-11	3	EURO
4826	UBR PENDING.UBER.COM	2024-11-02	3.50	2024-10-11	3	EURO
4827	UBR PENDING.UBER.COM	2024-11-02	3.50	2024-10-11	3	EURO
4828	Glovo 09OCT BRCSYLC4C	2024-11-02	8.30	2024-10-11	3	EURO
4829	DD PT10100825 VODAFONE PORTUG 07335462122	2024-11-02	63.68	2024-10-11	3	EURO
4831	GLOVO LISBOA PT	2024-11-06	10.95	2024-11-06	3	EURO
4832	IMP.  SELO  COM. TRANSFERENCIA (A TAXA DE 4%)	2024-11-06	0.05	2024-11-06	3	EURO
4833	Comissão Transferência a crédito SEPA+ Em Linha	2024-11-06	1.20	2024-11-06	3	EURO
4834	TRF P/ Lucinda dona da casa	2024-11-06	650.00	2024-11-05	3	EURO
4835	GLOVO LISBOA PT	2024-11-06	11.12	2024-11-05	3	EURO
4836	GLOVO LISBOA PT	2024-11-06	9.30	2024-11-05	3	EURO
4837	UBR PENDING.UBER.COM	2024-11-06	5.79	2024-11-05	3	EURO
4838	UBR PENDING.UBER.COM	2024-11-06	5.63	2024-11-05	3	EURO
4839	CONTINENTE	2024-11-06	49.30	2024-11-05	3	EURO
4840	ARCADIA	2024-11-06	5.20	2024-11-05	3	EURO
4841	CIN BRAGA PARQUE	2024-11-06	7.70	2024-11-05	3	EURO
4842	UBR PENDING.UBER.COM	2024-11-06	4.20	2024-11-05	3	EURO
4843	UBR PENDING.UBER.COM	2024-11-06	3.67	2024-11-05	3	EURO
4844	GLOVO LISBOA PT	2024-11-06	8.35	2024-11-05	3	EURO
4845	GLOVO LISBOA PT	2024-11-06	12.00	2024-11-05	3	EURO
4847	Only Fans	2024-11-06	6.75	2024-10-12	4	EURO
4848	Glovo 18OCT BR3HEBZMG	2024-11-06	11.15	2024-10-19	4	EURO
4849	Glovo 20OCT BRFLFZVKU	2024-11-06	11.30	2024-10-21	4	EURO
4850	Only Fans	2024-11-06	6.82	2024-10-25	4	EURO
4851	Glovo 29OCT BRT5LEHER	2024-11-06	10.95	2024-10-30	4	EURO
4852	Glovo 29OCT BREX4KUDE	2024-11-06	10.44	2024-10-30	4	EURO
4853	Glovo 30OCT BRX1WKKGY	2024-11-06	10.95	2024-10-31	4	EURO
4854	Glovo 31OCT BR3P9HU9N	2024-11-06	10.95	2024-11-01	4	EURO
4855	GLOVOGLOVO PRIME	2024-11-06	5.99	2024-11-03	4	EURO
4856	DA  COMGAS 48353698	2024-11-06	11.39	2024-10-14	5	REAL
4857	DA  VIVO FIXO 9324810660	2024-11-06	148.99	2024-10-15	5	REAL
4858	PIX TRANSF  ALTO PA16/10	2024-11-06	2170.00	2024-10-16	5	REAL
4859	DA  ELETROPAULO 56301179	2024-11-06	22.95	2024-10-29	5	REAL
4860	TAR PACOTE ITAU   OUT/24	2024-11-06	71.90	2024-11-04	5	REAL
4861	MOBILEPAG TIT 7753249020	2024-11-06	664.00	2024-11-05	5	REAL
4862	DA  VIVO FIXO 9324810660	2024-11-06	148.99	2024-11-18	5	REAL
4863	ALURA 03/12	2024-11-06	87.20	2024-10-28	6	REAL
4864	Disney Plus	2024-11-06	43.90	2024-10-06	6	REAL
4865	NETFLIX.COM	2024-11-06	44.90	2024-10-11	6	REAL
4866	AmazonPrimeBR	2024-11-06	19.90	2024-10-12	6	REAL
4867	CASA DE SHIVA LTDA ALTO	2024-11-06	2868.75	2024-10-14	6	REAL
4868	DECOLAR BARUERI	2024-11-06	525.34	2024-10-14	6	REAL
4869	APPLE.COM/BILL	2024-11-06	21.90	2024-10-20	6	REAL
4870	DM*HELPMAXCOM	2024-11-06	39.90	2024-10-21	6	REAL
4871	DM*Spotify	2024-11-06	21.90	2024-10-28	6	REAL
4872	ANUIDADE DIFERENCIADA 11/12	2024-11-06	34.00	2024-10-28	6	REAL
4873	Pagamento fatura 11/2024	2024-11-06	3707.69	2024-11-06	5	REAL
4874	GLOVO LISBOA PT	2024-11-13	10.95	2024-11-13	3	EURO
4875	DD PT10100825 VODAFONE PORTUG 07335462122	2024-11-13	63.68	2024-11-13	3	EURO
4876	IMP. SELO COM. TRANSFERENCIA (A TAXA DE 4%)	2024-11-13	0.05	2024-11-12	3	EURO
4877	Comissao Transferencia a credito SEPA+ Em Linha	2024-11-13	1.20	2024-11-12	3	EURO
4878	GLOVO LISBOA PT	2024-11-13	8.90	2024-11-12	3	EURO
4879	CONTINENTE BRAGA BRAGA	2024-11-13	50.45	2024-11-12	3	EURO
4880	UBR PENDING.UBER.COM	2024-11-13	5.65	2024-11-12	3	EURO
4881	UBR PENDING.UBER.COM	2024-11-13	5.77	2024-11-12	3	EURO
4882	CLINICA STA MADALENA BR	2024-11-13	12.00	2024-11-12	3	EURO
4883	UBR PENDING.UBER.COM	2024-11-13	4.05	2024-11-12	3	EURO
4884	UBR PENDING.UBER.COM	2024-11-13	3.72	2024-11-12	3	EURO
4885	GLOVO LISBOA PT	2024-11-13	10.10	2024-11-12	3	EURO
4886	GLOVO LISBOA PT	2024-11-13	10.95	2024-11-12	3	EURO
4887	GLOVO LISBOA PT	2024-11-13	11.07	2024-11-12	3	EURO
4888	TRF P/ CLUBE TENIS BRAGA	2024-11-13	40.50	2024-11-11	3	EURO
4889	PAG SERV 21796/344397342 AGEREEMP.DE AGUAS,EFL	2024-11-13	42.51	2024-11-11	3	EURO
4890	GLOVO LISBOA PT	2024-11-13	9.25	2024-11-08	3	EURO
4891	GLOVO LISBOA PT	2024-11-13	10.95	2024-11-08	3	EURO
4892	IMPOSTO DE SELO 17.3.4	2024-11-13	0.21	2024-11-08	3	EURO
4893	COM. MANUTENCAO CONTA ORDENADO 102024	2024-11-13	5.20	2024-11-08	3	EURO
4894	GLOVO LISBOA PT	2024-11-13	10.20	2024-11-08	3	EURO
4895	GLOVO 1 LISBOA PT	2024-11-13	10.95	2024-11-08	3	EURO
4896	GLOVO LISBOA PT	2024-11-13	10.14	2024-11-07	3	EURO
4897	GLOVO 2 LISBOA PT	2024-11-13	10.95	2024-11-07	3	EURO
4968	UBER	2024-12-18	24.91	2024-11-25	5	REAL
4898	Aluguel	2024-12-16	650.00	2024-12-03	3	EURO
4899	Comissao Transferencia	2024-12-16	1.20	2024-12-04	3	EURO
4900	Imposto Selo	2024-12-16	0.05	2024-12-04	3	EURO
4901	Com manutencao	2024-12-16	5.20	2024-12-05	3	EURO
4902	Imposto Selo 2	2024-12-16	0.21	2024-12-05	3	EURO
4903	Clube Tenis	2024-12-16	40.50	2024-12-08	3	EURO
4904	Comisao transferencia 2	2024-12-16	1.20	2024-12-09	3	EURO
4905	Imposto Selo 3	2024-12-16	0.05	2024-12-09	3	EURO
4906	Agua	2024-12-16	20.17	2024-12-11	3	EURO
4907	VOdafone	2024-12-16	63.68	2024-12-11	3	EURO
4909	Feito Portugal	2024-12-18	21.90	2024-11-25	3	EURO
4910	Uber 1	2024-12-18	82.48	2024-11-25	3	EURO
4911	Glovo 1	2024-12-18	8.30	2024-11-25	3	EURO
4912	EDP Novembro	2024-12-18	89.78	2024-11-24	3	EURO
4913	Glovo 2	2024-12-18	8.50	2024-11-21	3	EURO
4914	Glovo 3	2024-12-18	10.95	2024-11-21	3	EURO
4915	Glovo 4	2024-12-18	8.40	2024-11-20	3	EURO
4916	Glovo 5	2024-12-18	10.95	2024-11-20	3	EURO
4917	Uber 1	2024-12-18	3.33	2024-11-19	3	EURO
4918	Uber 2	2024-12-18	3.33	2024-11-19	3	EURO
4919	Glovo 6	2024-12-18	10.95	2024-11-19	3	EURO
4920	Glovo 7	2024-12-18	8.90	2024-11-19	3	EURO
4921	Glovo 8	2024-12-18	9.50	2024-11-19	3	EURO
4922	Medico 1	2024-12-18	45.00	2024-11-18	3	EURO
4923	Medico 2	2024-12-18	90.00	2024-11-18	3	EURO
4924	Uber 3	2024-12-18	3.64	2024-11-18	3	EURO
4925	Uber 4	2024-12-18	5.82	2024-11-18	3	EURO
4926	Uber 5	2024-12-18	5.38	2024-11-18	3	EURO
4927	Uber 6	2024-12-18	3.10	2024-11-18	3	EURO
4928	Uber 7	2024-12-18	3.48	2024-11-18	3	EURO
4929	Glovo 9	2024-12-18	10.40	2024-11-18	3	EURO
4930	Roupas	2024-12-18	34.00	2024-11-18	3	EURO
4931	Uber 8	2024-12-18	5.71	2024-11-18	3	EURO
4932	Uber 9	2024-12-18	5.82	2024-11-18	3	EURO
4933	Continente	2024-12-18	60.68	2024-11-18	3	EURO
4934	Glovo 9	2024-12-18	10.95	2024-11-18	3	EURO
4935	Glovo 10	2024-12-18	9.40	2024-11-18	3	EURO
4936	Glovo 11	2024-12-18	8.30	2024-11-18	3	EURO
4937	SAque	2024-12-18	100.00	2024-11-17	3	EURO
4938	Farmacia	2024-12-18	4.76	2024-11-17	3	EURO
4939	Casa das Bolas	2024-12-18	4.40	2024-11-17	3	EURO
4940	Glovo 12	2024-12-18	9.85	2024-11-14	3	EURO
4941	Glovo 13	2024-12-18	10.95	2024-11-14	3	EURO
4942	Glovo 14	2024-12-18	10.95	2024-11-14	3	EURO
4943	STA Madalena	2024-12-18	21.00	2024-11-12	3	EURO
4944	Uber 1	2024-12-18	3.37	2024-11-12	3	EURO
4945	Uber 2	2024-12-18	3.59	2024-11-12	3	EURO
4946	Uber 3	2024-12-18	3.39	2024-11-12	3	EURO
4947	Uber 4	2024-12-18	3.81	2024-11-12	3	EURO
4948	Glovo 1	2024-12-18	10.95	2024-11-12	3	EURO
4830	Salário Novembro 2024	\N	3500.00	2024-11-27	3	EURO
4949	ALURA 04/12	2024-12-18	87.20	2024-11-28	6	REAL
4950	ANUIDADE DIFERENCIADA 12/12	2024-12-18	17.00	2024-11-05	6	REAL
4951	Disney Plus	2024-12-18	43.90	2024-11-06	6	REAL
4952	NETFLIX.COM	2024-12-18	44.90	2024-11-11	6	REAL
4953	AmazonPrimeBR	2024-12-18	19.90	2024-11-12	6	REAL
4954	APPLE.COM/BILL	2024-12-18	21.90	2024-11-20	6	REAL
4955	DM *HELPMAXCOM	2024-12-18	39.90	2024-11-21	6	REAL
4956	UBER * PENDING	2024-12-18	126.94	2024-11-27	6	REAL
4957	DM *Spotify	2024-12-18	21.90	2024-11-28	6	REAL
4958	UBER* TRIP	2024-12-18	43.68	2024-11-02	6	REAL
4959	Uber *UBER *TRIP	2024-12-18	47.50	2024-11-02	6	REAL
4960	UBER* TRIP	2024-12-18	90.55	2024-11-02	6	REAL
4961	LOCALIZA RAC ACCAE0 SAO CAETANO D	2024-12-18	5241.54	2024-11-02	6	REAL
4962	Pagamento fatura 12/2024	2024-12-04	5846.81	2024-12-18	5	REAL
4963	DA COMGAS 48353698	2024-12-18	11.39	2024-12-13	5	REAL
4964	RSCSS ITALVA PAES	2024-12-18	26.16	2024-11-25	5	REAL
4965	ITALVA PAES	2024-12-18	36.31	2024-11-25	5	REAL
4966	UBER	2024-12-18	44.92	2024-11-25	5	REAL
4967	GUARUCOOP TA2311 GUARUCOOP TAXIS	2024-12-18	215.14	2024-11-25	5	REAL
4969	IFD RESTAUR	2024-12-18	35.99	2024-11-25	5	REAL
4970	UBER	2024-12-18	19.97	2024-11-25	5	REAL
4971	UBER	2024-12-18	8.97	2024-11-25	5	REAL
4972	BESTGO	2024-12-18	19.90	2024-11-25	5	REAL
4973	CARREFOUR SP2311	2024-12-18	106.03	2024-11-25	5	REAL
4974	UBER	2024-12-18	23.95	2024-11-25	5	REAL
4975	ON IFD 55 452	2024-12-18	20.99	2024-11-25	5	REAL
4976	SERVICOS CL	2024-12-18	30.00	2024-11-25	5	REAL
4977	UBER	2024-12-18	43.15	2024-11-26	5	REAL
4978	PIX QRS MARIA AUXIL	2024-12-18	250.00	2024-11-26	5	REAL
4979	UBER	2024-12-18	41.74	2024-11-26	5	REAL
4980	RSCSS PANIFICADORA	2024-12-18	26.80	2024-11-26	5	REAL
4981	RSCSS BETO PAIXAO 2611 BETO PAIXAO	2024-12-18	45.00	2024-11-26	5	REAL
4982	UBER	2024-12-18	35.19	2024-11-26	5	REAL
4983	ON IFD RESTAUR	2024-12-18	25.98	2024-11-26	5	REAL
4984	ON IFD DAKI CD	2024-12-18	92.90	2024-11-26	5	REAL
4985	ON IFD XANGAI	2024-12-18	54.10	2024-11-26	5	REAL
4986	RSCSS GF QUATRO	2024-12-18	56.00	2024-11-27	5	REAL
4987	LFT	2024-12-18	189.80	2024-11-27	5	REAL
4988	RSCSS VO BELMIRA	2024-12-18	22.00	2024-11-27	5	REAL
4989	PIX TRANSF JANUARI	2024-12-18	54.00	2024-11-27	5	REAL
4990	DA  ELETROPAULO	2024-12-18	22.76	2024-11-29	5	REAL
4991	PIX TRANSF ALTO	2024-12-18	4000.00	2024-12-02	5	REAL
4992	PIX TRANSF ALEXAND	2024-12-18	30.00	2024-12-02	5	REAL
4993	PIX TRANSF Natalin	2024-12-18	56.00	2024-12-02	5	REAL
4994	PAY GIRAFFAS	2024-12-18	54.50	2024-12-02	5	REAL
4995	RSCSS MP  ANDERSON0212 MP *ANDERSON	2024-12-18	51.00	2024-12-02	5	REAL
4996	HideoHarada	2024-12-18	116.69	2024-12-03	5	REAL
4997	POTENCIAL TECNOLOGIA	2024-12-18	127.69	2024-12-03	5	REAL
4998	ON IFD RESTAUR	2024-12-18	22.99	2024-12-03	5	REAL
4999	RSCCS CDB  CENTRO0312 CDB  CENTRO DE DIAGNO	2024-12-18	240.00	2024-12-03	5	REAL
5000	BLZ ESTACIONAMENTOS	2024-12-18	20.00	2024-12-03	5	REAL
5001	CARREFOUR SPA 10	2024-12-18	171.02	2024-12-03	5	REAL
5002	ON IFD BAR E L	2024-12-18	39.79	2024-12-03	5	REAL
5003	TAR PACOTE ITAU NOV/24	2024-12-18	71.90	2024-12-03	5	REAL
5004	MOBILE PAG TIT 775324902000	2024-12-18	664.00	2024-12-04	5	REAL
5005	RSCSS YOSHIDA COMP0412 YOSHIDA COMPUTERS CO	2024-12-18	35.00	2024-12-04	5	REAL
5006	ON IFD RESTAUR	2024-12-18	28.98	2024-12-04	5	REAL
5007	ON IFD XANGAI	2024-12-18	54.10	2024-12-04	5	REAL
5008	PAY CARRECARREFOUR SPA 10	2024-12-18	82.45	2024-12-05	5	REAL
5009	PIX QRS ESTOK DISTR	2024-12-18	94.90	2024-12-05	5	REAL
5010	Administradora	2024-12-18	20.00	2024-12-05	5	REAL
5011	ON IFD ROBINFO	2024-12-18	25.98	2024-12-05	5	REAL
5012	ON IFD CASSIA	2024-12-18	20.99	2024-12-05	5	REAL
5013	CARREFOUR SPA 10	2024-12-18	197.55	2024-12-09	5	REAL
5014	IFD JOSE RO	2024-12-18	24.98	2024-12-09	5	REAL
5015	IFD MALZ CO	2024-12-18	38.90	2024-12-09	5	REAL
5016	BusgerSantoAndre	2024-12-18	10.00	2024-12-09	5	REAL
5017	LeveduraComercio	2024-12-18	52.00	2024-12-09	5	REAL
5018	PARADA DO ACAI	2024-12-18	21.00	2024-12-10	5	REAL
5019	PAES E DOCES MONTE CA	2024-12-18	17.10	2024-12-10	5	REAL
5020	ON IFD RESTAUR	2024-12-18	35.99	2024-12-11	5	REAL
5021	RSCSS ITALVA PAES 1212 ITALVA PAES E DOCES LT	2024-12-18	4.60	2024-12-12	5	REAL
5022	RAIA280	2024-12-18	33.48	2024-12-12	5	REAL
5023	ON IFD NATHALI	2024-12-18	25.98	2024-12-12	5	REAL
5024	PAY KA'NA 12/12 KA'NALU POKE	2024-12-18	39.80	2024-12-12	5	REAL
5025	ITALVA PAES E DOCES LT	2024-12-18	49.19	2024-12-13	5	REAL
5026	CARREFOUR 388 PAN	2024-12-18	257.01	2024-12-13	5	REAL
5027	ON IFD BRUNO D	2024-12-18	29.98	2024-12-13	5	REAL
5028	CARREFOUR SPA 10	2024-12-18	158.39	2024-12-16	5	REAL
5029	ITALVA PAES E DOCES LT	2024-12-18	7.84	2024-12-16	5	REAL
5030	PANIFICADORA LINDO PAO	2024-12-18	29.90	2024-12-16	5	REAL
5031	PIX TRANSF ANGELIN	2024-12-18	0.01	2024-12-16	5	REAL
5032	IFD RESTAUR	2024-12-18	35.99	2024-12-16	5	REAL
5033	PIX TRANSF Debora	2024-12-18	33.00	2024-12-16	5	REAL
5034	IFD Osnir Ha1412 IFD*Osnir Hamburger	2024-12-18	145.20	2024-12-16	5	REAL
5035	DA  VIVO FIXO 9324810660	2024-12-18	148.99	2024-12-16	5	REAL
5036	DA  COMGAS 48353698	2024-12-18	11.39	2024-12-16	5	REAL
5037	PAY CONST CONSTRUDECOR S A	2024-12-18	95.69	2024-12-17	5	REAL
5038	PAY CARRE CARREFOUR SPA 10	2024-12-18	178.64	2024-12-17	5	REAL
5039	ON IFD RESTAUR 1	2024-12-18	35.99	2024-12-17	5	REAL
5040	ON IFD RESTAUR 2	2024-12-18	35.99	2024-12-18	5	REAL
4908	Salario Dezembro 2024	\N	5597.00	2024-12-28	3	EURO
5041	EDP	2024-12-29	88.16	2024-12-26	3	EURO
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
33	102	450.00	2024-05-01 00:00:00	2024-05-31 23:59:59.999
34	301	250.00	2024-05-01 00:00:00	2024-05-31 23:59:59.999
35	102	450.00	2024-06-01 00:00:00	2024-06-30 23:59:59.999
36	301	250.00	2024-06-01 00:00:00	2024-06-30 23:59:59.999
37	102	450.00	2024-07-01 00:00:00	2024-07-31 23:59:59.999
38	301	250.00	2024-07-01 00:00:00	2024-07-31 23:59:59.999
39	102	350.00	2024-10-01 00:00:00	2024-10-31 23:59:59.999
40	301	250.00	2024-10-01 00:00:00	2024-10-31 23:59:59.999
\.


--
-- Data for Name: parametros; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.parametros (nome, valor, tipo) FROM stdin;
IOF	0.38	PORCENTAGEM
SPOT	0.003	DECIMAL
EURO.REAL	https://economia.uol.com.br/cotacoes/cambio/euro-uniao-europeia/	TEXTO
DEBITAVEL_PRINCIPAL	3	DECIMAL
IGNORE_WORDS	DE COMPRA BR NL	TEXTO
\.


--
-- Data for Name: receita; Type: TABLE DATA; Schema: despesas_db; Owner: despesas
--

COPY despesas_db.receita (depositado, id, tipo_receita_id, investimento_id) FROM stdin;
t	44	109	\N
t	55	109	\N
t	61	109	\N
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
t	2612	109	\N
t	2701	109	\N
t	2774	109	\N
t	2896	109	\N
t	2974	111	\N
t	3006	111	\N
t	2989	109	\N
t	3081	109	\N
t	3197	109	\N
t	3175	109	\N
t	3200	109	\N
t	3489	111	\N
t	3402	109	\N
t	3640	111	\N
t	3641	111	\N
t	3642	111	\N
t	3494	109	\N
t	3735	111	\N
t	3607	109	\N
t	3818	109	\N
t	3889	109	\N
t	92	109	\N
t	125	109	\N
t	3890	109	\N
t	4046	109	\N
t	4161	109	\N
t	4354	111	\N
t	4494	111	\N
t	4321	109	\N
t	4436	109	\N
t	4569	109	\N
t	4748	111	\N
t	4718	109	\N
t	4830	109	\N
f	4908	109	\N
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
D	4	#8f5151	Contas
D	3	#4a1ad6	Casa
D	107	#a1a1a1	Carro
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
2663	4	1000.00
2711	6	195.30
2806	6	251.99
2817	4	500.00
2889	5	36149.40
2978	6	202.30
3003	6	208.30
3095	6	297.30
3096	4	2000.00
3191	6	348.13
3276	6	783.10
3381	5	35141.40
3432	6	783.05
3602	6	3157.88
3639	6	10747.59
3733	4	300.00
3734	4	400.00
4018	6	2127.05
4032	6	1654.43
4045	6	1329.11
4173	6	396.04
4191	6	401.04
4224	4	200.00
4315	5	39599.00
4353	6	521.66
4481	6	541.03
4488	4	2000.00
4632	6	463.44
4731	6	555.35
4873	6	3707.69
4962	6	5846.81
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

SELECT pg_catalog.setval('despesas_db.fatura_id_seq', 88, true);


--
-- Name: meta_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.meta_id_seq', 37, true);


--
-- Name: movimentacao_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.movimentacao_id_seq', 5041, true);


--
-- Name: orcamento_id_seq; Type: SEQUENCE SET; Schema: despesas_db; Owner: despesas
--

SELECT pg_catalog.setval('despesas_db.orcamento_id_seq', 40, true);


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

