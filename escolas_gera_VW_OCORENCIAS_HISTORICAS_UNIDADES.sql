--drop view VW_OCORENCIAS_HISTORICAS_UNIDADES
CREATE VIEW VW_OCORENCIAS_HISTORICAS_UNIDADES AS
SELECT 
cd_historico_unidade,
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
A.tp_ocorrencia_historica,
C.dc_tipo_ocorrencia_historica,
cd_ato,
nr_ato,
dc_ato,
dt_publicacao_dom,
A.tp_atualizacao_registro,
dt_inicio_ocorrencia_unidade,
A.dt_atualizacao_tabela,
B.CRDATE



FROM D_HISTORICO_UNIDADE A1	105927	DRE - PJ	307907	CR.P.CONV   	SANTANA	12	SITUACAO DAS ESCOLAS	DESPACHO	00	ESCOLA EXTINTA             	2024-07-31 00:00:00	NULL	2024-07-31 00:00:00.000	2024-08-01 13:58:18.203
2	105926	DRE - CS	308073	ESC.PART.   	EDUCAR E CRESCER, E.E.I.	12	SITUACAO DAS ESCOLAS	PORTARIA DRE	184	ESCOLA EXTINTA             	2023-08-03 00:00:00	NULL	2023-08-10 00:00:00.000	2024-08-01 10:52:34.150
3	105925	DRE - CS	309310	ESC.PART.   	PANDA, E.E.I.	12	SITUACAO DAS ESCOLAS	PORTARIA DRE	185	ESCOLA EXTINTA             	2023-08-03 00:00:00	NULL	2023-08-10 00:00:00.000	2024-08-01 10:46:42.950
4	105924	DRE - CS	304344	ESC.PART.   	URUPES E.E.I.	12	SITUACAO DAS ESCOLAS	PORTARIA DRE	183	ESCOLA EXTINTA             	2023-08-03 00:00:00	NULL	2023-08-10 00:00:00.000	2024-08-01 10:35:23.497
5	105922	DRE - IP	308799	CR.P.CONV   	PIPAS V	20	APROVACAO REGIMENTO ESCOLAR	PORTARIA DRE	221	FICA APROVADO O REGIMENTO EDUCACIONAL	2024-06-24 00:00:00	NULL	2024-07-31 00:00:00.000	2024-08-01 10:22:30.970
6	105921	DRE - IP	308799	CR.P.CONV   	PIPAS V	7	AUTORIZACAO DE FUNCIONAMENTO	PORTARIA DRE	220	FICA AUTORIZADO O FUNCIONAMENTO	2024-06-24 00:00:00	NULL	2024-07-31 00:00:00.000	2024-08-01 10:21:56.843
7	105920	DRE - BT	306089	ESC.PART.   	PIPOQUINHA BERC. E ESCOLA	12	SITUACAO DAS ESCOLAS	PORTARIA DRE	103	ESCOLA EXTINTA             	2023-04-11 00:00:00	NULL	2023-04-13 00:00:00.000	2024-08-01 08:36:40.707
8	105919	DRE - BT	304735	ESC.PART.   	DOM RATINHO JARDIM ESCOLA	12	SITUACAO DAS ESCOLAS	PORTARIA DRE	01	ESCOLA EXTINTA             	2010-01-18 00:00:00	NULL	2010-01-22 00:00:00.000	2024-08-01 08:27:17.473
JOIN SME_ESCOLA_DIARIO B ON A.cd_unidade_educacao=B.CD_ESCOLA
JOIN tipo_ocorrencia_historica c on A.tp_ocorrencia_historica=c.tp_ocorrencia_historica

/*
SELECT * FROM VW_OCORENCIAS_HISTORICAS_UNIDADES 
ORDER BY dt_atualizacao_tabela DESC
*/