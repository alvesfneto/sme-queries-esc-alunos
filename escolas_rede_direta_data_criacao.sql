--ATOS DE CRIAÇÃO

		--|---------------------------------------------------------------------------------------------------------------------------------|
		--|tp_ocorrencia_historica|dc_tipo_ocorrencia_historica |dt_atualizacao_tabela	|cd_operador|dt_cancelamento|in_utilizacao_historico|
		--|-----------------------|---------------------------- |-----------------------|-----------|---------------|-----------------------|
		--|	1					  |CRIACAO DE ESCOLAS	        |2007-05-25 14:38:08.000|		1   |		NULL	|		S				|
		--|	2					  |CONSOLIDA CRIACAO DE ESCOLAS |2007-05-25 14:38:08.000|		1   |		NULL	|		S				|
		--|	9					  |INSTALACAO DE ESCOLAS	    |2007-05-25 14:38:08.000|		1   |		NULL	|		S				|
		--|	18					  |DATA DE INAUGURACAO DA ESCOLA|2007-05-25 14:38:08.000|		1   |		NULL	|		S				|
		--|	27					  |CRIACAO						|2007-05-25 14:38:08.000|		1   |		NULL	|		S				|
		--|---------------------------------------------------------------------------------------------------------------------------------|
		--SELECT * FROM D_TIPO_ESCOLA
--==========================================================================================================
--REDE DIRETA
--==========================================================================================================
----------------------------------------------------------------------------------
--CRIA LISTA DE UNIDADES CRIADAS COM O TP_ATO IN (1,2)
----------------------------------------------------------------------------------
--DROP TABLE ##ATOS_CRIACAO
SELECT DISTINCT
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.tp_ocorrencia_historica AS TP_ATO,
C.dc_tipo_ocorrencia_historica AS TIPO_OCORRENCIA,
A.cd_ato AS ATO_CRIACAO,
A.nr_ato AS NR_ATO,
A.dt_publicacao_dom AS DT_PUBL,
A.dt_inicio_ocorrencia_unidade AS DT_CRIACAO,
A.dt_atualizacao_tabela AS DT_REGISTRO,
A.dc_ato AS NM_CRIACAO,
A.tp_atualizacao_registro AS TP_ATUALIZACAO,
A.cd_operador AS OPERADOR,
D.dc_tipo_situacao_unidade AS SITUACAO,
CONVERT(VARCHAR, B.CRDATE-1, 103) AS [DATA BASE]
INTO ##ATOS_CRIACAO
FROM D_HISTORICO_UNIDADE A
JOIN SME_ESCOLA_DIARIO B ON A.cd_unidade_educacao=B.CD_ESCOLA
JOIN tipo_ocorrencia_historica C ON A.tp_ocorrencia_historica=C.tp_ocorrencia_historica
JOIN [tipo_situacao_unidade] D ON B.CD_SIT=D.tp_situacao_unidade
WHERE A.tp_ocorrencia_historica IN (1,2) AND B.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,23,25,27,28,31,38)
--SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA IN (400115,093947,400496,092126,091090)
--------------------------------------------------------------------------------------------------------
--LOCALIZA REGISTROS DUPLICADOS - TABELA ATOS_CRIACAO
--------------------------------------------------------------------------------------------------------
SELECT
CD_ESCOLA,
COUNT (CD_ESCOLA) AS QTDE
FROM 
##ATOS_CRIACAO
GROUP BY
CD_ESCOLA
HAVING (COUNT (CD_ESCOLA)>1)
ORDER BY 1

/*SELECT * FROM ##ATOS_CRIACAO 
WHERE CD_ESCOLA IN (

019230
,019249
,019537
,019714
,019740
,091901
,094404
,095583
,097691
,097705
,400152
,400223
,400224
,400227
,400230
,400296)
ORDER BY CD_ESCOLA

*/
--------------------------------------------------------------------------------------------------------
--CRIA TABELA ##ACERTOS (LISTA DE REGISTROS VÁLIDOS CONFORME REGRAS INDIVIDUAIS) 
--------------------------------------------------------------------------------------------------------
--DROP TABLE ##ACERTOS
SELECT * INTO ##ACERTOS 
FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '097705' AND NM_CRIACAO ='COHAB CIDADE TIRADENTES  - UNIDADE IV' -->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '097691' AND NM_CRIACAO ='VILA PROGRESSO'
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '019249' AND NM_CRIACAO ='JARDIM JOAO XXIII'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '095583' AND NM_CRIACAO ='COHAB JARDIM SAPOPEMBA - UNID I'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '019230' AND NM_CRIACAO ='VILA GERMAINE'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '091901' AND tp_ato=1-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '094404' AND tp_ato=1-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '097691' AND nr_ato ='21.537'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '097705' AND nr_ato ='21.536'
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '400152' AND nr_ato ='24.405'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '400223' AND nr_ato ='24.765'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '400224' AND nr_ato ='21.968'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '400227' AND nr_ato ='24.498'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '400230' AND nr_ato ='20.719'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '400296' AND nr_ato ='42195'-->
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '019537' AND TP_ATO=1
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '019714' AND TP_ATO=1
UNION
SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA = '019740' AND TP_ATO=1
--SELECT * FROM ##ACERTOS
-------------------------------------------------------------------------------------------------------------
--EXCLUI DA TABELA ##ATOS_CRIACAO OS REGISTROS DUPLICADOS
-------------------------------------------------------------------------------------------------------------
DELETE FROM ##ATOS_CRIACAO
WHERE CD_ESCOLA IN ('019230','019249','091901','094404','095583','097691','097705','400152','400223','400224','400227','400230','400296','019537','019714','019740')
-------------------------------------------------------------------------------------------------------------
--INCLUI TABELA ##ACERTOS NA TABELA ##ATOS_CRIACAO
-------------------------------------------------------------------------------------------------------------
INSERT INTO ##ATOS_CRIACAO SELECT * FROM ##ACERTOS
---------------------------------------------------------------------------------------
--SELECIONA UNIDADES CRIADAS POR TIPO DE OCORRENCIA: 9 - INSTALAÇÃO DE ESCOLAS 
---------------------------------------------------------------------------------------
--DROP TABLE ##ATO_9
SELECT 
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
C.tp_ocorrencia_historica AS TP_ATO,
D.dc_tipo_ocorrencia_historica AS TIPO_OCORRENCIA,
C.cd_ato AS ATO_CRIACAO,
C.nr_ato AS NR_ATO,
C.dt_publicacao_dom AS DT_PUBL,
C.dt_inicio_ocorrencia_unidade AS DT_CRIACAO,
C.dt_atualizacao_tabela AS DT_REGISTRO,
C.dc_ato AS NM_CRIACAO,
C.tp_atualizacao_registro AS TP_ATUALIZACAO,
C.cd_operador AS OPERADOR,
E.dc_tipo_situacao_unidade AS SITUACAO,
CONVERT(VARCHAR, B.CRDATE-1, 103) AS [DATA BASE]
INTO ##ATO_9
FROM ##ATOS_CRIACAO A
RIGHT JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_HISTORICO_UNIDADE C ON B.CD_ESCOLA=C.cd_unidade_educacao
JOIN tipo_ocorrencia_historica D ON C.tp_ocorrencia_historica=D.tp_ocorrencia_historica
JOIN [tipo_situacao_unidade] E ON B.CD_SIT=E.tp_situacao_unidade
WHERE B.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,23,25,27,28,31,38) AND A.CD_ESCOLA IS NULL AND C.tp_ocorrencia_historica  = 9
--SELECT * FROM ##ATO_9
-------------------------------------------------------------------------------------------------------------
--INCLUI TABELA ##ATO_9 NA TABELA ##ATOS_CRIACAO
-------------------------------------------------------------------------------------------------------------
INSERT INTO ##ATOS_CRIACAO SELECT * FROM ##ATO_9
-------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--SELECIONA OS CASOS DE TIPO DE OCORRENCIA = 27 CRIAÇÃO DE ESCOLA
------------------------------------------------------------------------------------------------------------------------
--DROP TABLE ##ATO_27
SELECT 
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
C.tp_ocorrencia_historica AS TP_ATO,
D.dc_tipo_ocorrencia_historica AS TIPO_OCORRENCIA,
C.cd_ato AS ATO_CRIACAO,
C.nr_ato AS NR_ATO,
C.dt_publicacao_dom AS DT_PUBL,
C.dt_inicio_ocorrencia_unidade AS DT_CRIACAO,
C.dt_atualizacao_tabela AS DT_REGISTRO,
C.dc_ato AS NM_CRIACAO,
C.tp_atualizacao_registro AS TP_ATUALIZACAO,
C.cd_operador AS OPERADOR,
E.dc_tipo_situacao_unidade AS SITUACAO,
CONVERT(VARCHAR, B.CRDATE-1, 103) AS [DATA BASE]
INTO ##ATO_27
FROM ##ATOS_CRIACAO A
RIGHT JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_HISTORICO_UNIDADE C ON B.CD_ESCOLA=C.cd_unidade_educacao
JOIN tipo_ocorrencia_historica D ON C.tp_ocorrencia_historica=D.tp_ocorrencia_historica
JOIN [tipo_situacao_unidade] E ON B.CD_SIT=E.tp_situacao_unidade
WHERE B.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,23,25,27,28,31,38) AND A.CD_ESCOLA IS NULL AND C.tp_ocorrencia_historica  = 27
--SELECT * FROM ##ATO_27
-------------------------------------------------------------------------------------------------------------
--INCLUI TABELA ##ATO_27 NA TABELA ##ATOS_CRIACAO
-------------------------------------------------------------------------------------------------------------
INSERT INTO ##ATOS_CRIACAO SELECT * FROM ##ATO_27
-------------------------------------------------------------------------------------------------------------
--ESGOTADOS OS TIPOS QUE TRATAM DE CRIAÇÃO - UTILIZA-SE O ATO TIPO 18 - INAUGURAÇÃO DA ESCOLA
-------------------------------------------------------------------------------------------------------------
--DROP TABLE ##ATO_18
SELECT 
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
C.tp_ocorrencia_historica AS TP_ATO,
D.dc_tipo_ocorrencia_historica AS TIPO_OCORRENCIA,
C.cd_ato AS ATO_CRIACAO,
C.nr_ato AS NR_ATO,
C.dt_publicacao_dom AS DT_PUBL,
C.dt_inicio_ocorrencia_unidade AS DT_CRIACAO,
C.dt_atualizacao_tabela AS DT_REGISTRO,
C.dc_ato AS NM_CRIACAO,
C.tp_atualizacao_registro AS TP_ATUALIZACAO,
C.cd_operador AS OPERADOR,
E.dc_tipo_situacao_unidade AS SITUACAO,
CONVERT(VARCHAR, B.CRDATE-1, 103) AS [DATA BASE]
INTO ##ATO_18
FROM ##ATOS_CRIACAO A
RIGHT JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_HISTORICO_UNIDADE C ON B.CD_ESCOLA=C.cd_unidade_educacao
JOIN tipo_ocorrencia_historica D ON C.tp_ocorrencia_historica=D.tp_ocorrencia_historica
JOIN [tipo_situacao_unidade] E ON B.CD_SIT=E.tp_situacao_unidade
WHERE B.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,23,25,27,28,31,38) AND A.CD_ESCOLA IS NULL AND C.tp_ocorrencia_historica  = 18
--SELECT * FROM ##ATO_18
/*SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA IN (
094455
,095117
,095257
,092835
,094331
,093530
,093971
,095311
,093858
,092070
,093963
,094064
,094102
,095478
,090824
,091006
,092690
,091723
,094820
,093408
,095184
,095346
,090778
,092541
,093416
,094994
,095397
,091171
,094579
,095141
,092118
,092576
,093173
,094854
,094943
,095133
,400493)
*/
-------------------------------------------------------------------------------------------------------------
--INCLUI TABELA ##ATO_18 NA TABELA ##ATOS_CRIACAO
-------------------------------------------------------------------------------------------------------------
INSERT INTO ##ATOS_CRIACAO SELECT * FROM ##ATO_18
-------------------------------------------------------------------------------------------------------------
--SELECT * FROM ##ATOS_CRIACAO WHERE SITUACAO ='ESCOLA ATIVA'
-------------------------------------------------------------------------------------------------------------
--CRIA TABELA DE ESCOLAS COM ATOS DE CRIAÇÃO
-------------------------------------------------------------------------------------------------------------
--DROP TABLE SME_ESCOLAS_ATOS_CRIACAO
SELECT *
INTO SME_ESCOLAS_ATOS_CRIACAO
FROM ##ATOS_CRIACAO
--SELECT * FROM SME_ESCOLAS_ATOS_CRIACAO
------------------------------------------------------------------------------------------------------------
/* CORRECAO: UNIDADES QUE NÃO FORAM INCLUIDAS NA TABELA SME_ESCOLAS_ATOS_CRIACAO
INCLUINDO ESTAS ESCOLAS (094528,400171,400164,400008,092584)
*/
SELECT DISTINCT
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.tp_ocorrencia_historica AS TP_ATO,
C.dc_tipo_ocorrencia_historica AS TIPO_OCORRENCIA,
A.cd_ato AS ATO_CRIACAO,
A.nr_ato AS NR_ATO,
A.dt_publicacao_dom AS DT_PUBL,
A.dt_inicio_ocorrencia_unidade AS DT_CRIACAO,
A.dt_atualizacao_tabela AS DT_REGISTRO,
A.dc_ato AS NM_CRIACAO,
A.tp_atualizacao_registro AS TP_ATUALIZACAO,
A.cd_operador AS OPERADOR,
D.dc_tipo_situacao_unidade AS SITUACAO,
CONVERT(VARCHAR, B.CRDATE-1, 103) AS [DATA BASE]
INTO ##ATOS_CRIACAO7
FROM D_HISTORICO_UNIDADE A
JOIN SME_ESCOLA_DIARIO B ON A.cd_unidade_educacao=B.CD_ESCOLA
JOIN tipo_ocorrencia_historica C ON A.tp_ocorrencia_historica=C.tp_ocorrencia_historica
JOIN [tipo_situacao_unidade] D ON B.CD_SIT=D.tp_situacao_unidade
WHERE A.TP_OCORRENCIA_HISTORICA = 7 AND B.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,23,25,27,28,31,38) AND B.CD_ESCOLA IN (092584,094528,400008,400164,400171)

SELECT * FROM ##ATOS_CRIACAO WHERE CD_ESCOLA IN (092584,094528,400008,400164,400171)

INSERT INTO SME_ESCOLAS_ATOS_CRIACAO SELECT * FROM ##ATOS_CRIACAO7




------------------------------------------------------------------------------------------------------------------------------------
 --INSERE OS CECI NA TABELA
SELECT DISTINCT
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.tp_ocorrencia_historica AS TP_ATO,
C.dc_tipo_ocorrencia_historica AS TIPO_OCORRENCIA,
A.cd_ato AS ATO_CRIACAO,
A.nr_ato AS NR_ATO,
A.dt_publicacao_dom AS DT_PUBL,
A.dt_inicio_ocorrencia_unidade AS DT_CRIACAO,
A.dt_atualizacao_tabela AS DT_REGISTRO,
A.dc_ato AS NM_CRIACAO,
A.tp_atualizacao_registro AS TP_ATUALIZACAO,
A.cd_operador AS OPERADOR,
D.dc_tipo_situacao_unidade AS SITUACAO,
CONVERT(VARCHAR, B.CRDATE-1, 103) AS [DATA BASE]
INTO ##ATOS_CRIACAO_CECI
FROM D_HISTORICO_UNIDADE A
JOIN SME_ESCOLA_DIARIO B ON A.cd_unidade_educacao=B.CD_ESCOLA
JOIN tipo_ocorrencia_historica C ON A.tp_ocorrencia_historica=C.tp_ocorrencia_historica
JOIN [tipo_situacao_unidade] D ON B.CD_SIT=D.tp_situacao_unidade
WHERE  B.TP_ESCOLA IN (20,30) AND A.tp_ocorrencia_historica=1

INSERT INTO SME_ESCOLAS_ATOS_CRIACAO SELECT * FROM ##ATOS_CRIACAO_CECI

------------------------------------------------------------------------------------------------------------------------------------

SELECT
CD_ESCOLA,
COUNT (CD_ESCOLA) AS QTDE
FROM 
SME_ESCOLAS_ATOS_CRIACAO
GROUP BY
CD_ESCOLA
HAVING (COUNT (CD_ESCOLA)>1)
ORDER BY 1

SELECT * FROM SME_ESCOLAS_ATOS_CRIACAO
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

/*
Pesquisa de escolas da rede municipal criadas por gestão
*/

DROP TABLE SME_ESCOLAS_ATOS_CRIACAO_GESTAO
SELECT DISTINCT

*,
CASE 
	WHEN DT_CRIACAO <'1951-02-01' THEN 'ANTERIOR A 01/02/1951'
	--Ulimo prefeito da Era Vargas e Quarta República: prefeitos nomeados (1930–1953)
	WHEN DT_CRIACAO BETWEEN '1951-02-01' AND '1953-04-07' THEN 'ARMANDO DE ARRUDA PEREIRA'
	--Fase democrática da Quarta República e últimas eleições na ditadura (1953–1969)
	WHEN DT_CRIACAO BETWEEN '1953-04-08' AND '1955-01-30' THEN 'JANIO QUADROS 1'
	WHEN DT_CRIACAO BETWEEN '1955-01-31' AND '1955-06-21' THEN 'WILLIAN SALEM'
	WHEN DT_CRIACAO BETWEEN '1955-06-22' AND '1956-04-12' THEN 'JUVENALO LINO DE MATOS'
	WHEN DT_CRIACAO BETWEEN '1956-04-13' AND '1957-04-07' THEN 'VLADIMIR DE TOLODO PIZA'
	WHEN DT_CRIACAO BETWEEN '1957-04-08' AND '1961-04-07' THEN 'ADEMAR DE BARROS'
	WHEN DT_CRIACAO BETWEEN '1961-04-08' AND '1965-04-07' THEN 'PRESTES MAIA'
	WHEN DT_CRIACAO BETWEEN '1965-04-08' AND '1969-04-07' THEN 'JOSE VICENTE FARIA LIMA'
	--Ditadura militar: prefeitos biônicos (1969–1986)
	WHEN DT_CRIACAO BETWEEN '1969-04-08' AND '1971-04-07' THEN 'PAULO MALUF 1'
	WHEN DT_CRIACAO BETWEEN '1971-04-08' AND '1973-08-21' THEN 'JOSE CARLOS DE FIGUEIREDO FERRAZ'
	WHEN DT_CRIACAO BETWEEN '1973-08-22' AND '1973-08-27' THEN 'BRASIL VITA'
    WHEN DT_CRIACAO BETWEEN '1973-08-28' AND '1975-08-16' THEN 'MIGUEL COLASUONNO'
	WHEN DT_CRIACAO BETWEEN '1975-08-17' AND '1979-06-11' THEN 'OLAVO SETUBAL'
	WHEN DT_CRIACAO BETWEEN '1979-06-12' AND '1982-05-14' THEN 'REINALDO DE BARROS'
	WHEN DT_CRIACAO BETWEEN '1982-05-15' AND '1983-03-14' THEN 'ANTONIO SALIM CURIATTI'
	WHEN DT_CRIACAO BETWEEN '1983-03-15' AND '1983-05-10' THEN 'FRANCISCO ALTINO LIMA
'	WHEN DT_CRIACAO BETWEEN '1983-05-11' AND '1985-12-31' THEN 'MARIO COVAS'
    --Sexta República (1986–2023)
	WHEN DT_CRIACAO BETWEEN '1986-01-01' AND '1988-12-31' THEN 'JANIO QUADROS 2'
	WHEN DT_CRIACAO BETWEEN '1989-01-01' AND '1992-12-31' THEN 'LUIZA ERUNDINA'
	WHEN DT_CRIACAO BETWEEN '1993-01-01' AND '1996-12-31' THEN 'PAULO MALUF 2'
	WHEN DT_CRIACAO BETWEEN '1997-01-01' AND '2000-12-31' THEN 'CELSO PITTA'
	WHEN DT_CRIACAO BETWEEN '2001-01-01' AND '2004-12-31' THEN 'MARTA SUPLICY'
	WHEN DT_CRIACAO BETWEEN '2005-01-01' AND '2006-03-31' THEN 'JOSE SERRA'
	WHEN DT_CRIACAO BETWEEN '2006-04-01' AND '2008-12-31' THEN 'GILBERTO KASSAB 1'
	WHEN DT_CRIACAO BETWEEN '2009-01-01' AND '2012-12-31' THEN 'GILBERTO KASSAB 2'
	WHEN DT_CRIACAO BETWEEN '2013-01-01' AND '2016-12-31' THEN 'FERNANDO HADDAD'
	WHEN DT_CRIACAO BETWEEN '2017-01-01' AND '2018-04-05' THEN 'JOÃO DORIA'
	WHEN DT_CRIACAO BETWEEN '2018-04-06' AND '2021-05-16' THEN 'BRUNO COVAS 1'
	WHEN DT_CRIACAO >'2021-05-17'THEN 'RICARDO NUNES'
ELSE NULL END AS GESTAO

INTO SME_ESCOLAS_ATOS_CRIACAO_GESTAO
FROM SME_ESCOLAS_ATOS_CRIACAO
--SELECT * FROM SME_ESCOLAS_ATOS_CRIACAO_GESTAO
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
--RESUMO ATIVAS
DROP TABLE SME_ESCOLAS_ATOS_CRIACAO_GESTAO_RESUMO
SELECT DISTINCT
DT_INI,
GESTAO AS PREFEITO,
COUNT (Distinct Case When SG_TP_ESCOLA = 'EMEF' THEN CD_ESCOLA ELSE NULL END) AS EMEF,
COUNT (Distinct Case When SG_TP_ESCOLA = 'CEU EMEF' THEN CD_ESCOLA ELSE NULL END) AS [CEU EMEF],
COUNT (Distinct Case When SG_TP_ESCOLA = 'EMEFM' THEN CD_ESCOLA ELSE NULL END) AS EMEFM,
COUNT (Distinct Case When SG_TP_ESCOLA = 'EMEI' THEN CD_ESCOLA ELSE NULL END) AS EMEI,
COUNT (Distinct Case When SG_TP_ESCOLA = 'CEU EMEI' THEN CD_ESCOLA ELSE NULL END) AS [CEU EMEI],
COUNT (Distinct Case When SG_TP_ESCOLA = 'CEI DIRET' THEN CD_ESCOLA ELSE NULL END) AS [CEI DIRET],
COUNT (Distinct Case When SG_TP_ESCOLA = 'CEU CEI' THEN CD_ESCOLA ELSE NULL END) AS [CEU CEI],
COUNT (Distinct Case When SG_TP_ESCOLA = 'CEMEI' THEN CD_ESCOLA ELSE NULL END) AS CEMEI,
COUNT (Distinct Case When SG_TP_ESCOLA = 'CEU CEMEI' THEN CD_ESCOLA ELSE NULL END) AS [CEU CEMEI],
COUNT (Distinct Case When SG_TP_ESCOLA = 'EMEBS' THEN CD_ESCOLA ELSE NULL END) AS EMEBS,
COUNT (Distinct Case When SG_TP_ESCOLA = 'CCI/CIPS' THEN CD_ESCOLA ELSE NULL END) AS [CCI/CIPS],
COUNT (Distinct Case When SG_TP_ESCOLA = 'CIEJA' THEN CD_ESCOLA ELSE NULL END) AS CIEJA,
COUNT (Distinct Case When SG_TP_ESCOLA = 'CMCT' THEN CD_ESCOLA ELSE NULL END) AS CMCT,
COUNT (Distinct Case When SG_TP_ESCOLA = 'CECI' THEN CD_ESCOLA ELSE NULL END) AS CECI,
COUNT (Distinct Case When SG_TP_ESCOLA = 'E TEC' THEN CD_ESCOLA ELSE NULL END) AS [E TEC],
Count (Distinct CD_ESCOLA) AS 'TOTAL'
INTO SME_ESCOLAS_ATOS_CRIACAO_GESTAO_RESUMO
FROM SME_ESCOLAS_ATOS_CRIACAO_GESTAO A
JOIN [dbo].[prefeitos] B ON A.GESTAO=B.PREFEITO
WHERE SITUACAO='ESCOLA ATIVA'

GROUP BY DT_INI,GESTAO

ORDER BY 1

--SELECT * FROM SME_ESCOLAS_ATOS_CRIACAO_GESTAO_RESUMO ORDER BY 1
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/


INSERT INTO [dbo].[prefeitos] (DT_INI,PREFEITO) VALUES ('01/02/1951','ARMANDO DE ARRUDA PEREIRA')

SELECT * FROM [dbo].[prefeitos] ORDER BY 1

UPDATE [dbo].[prefeitos] SET PREFEITO = 'ARMANDO DE ARRUDA PEREIRA'
WHERE DT_INI ='1951-02-01 00:00:00.000' 
DELETE FROM [dbo].[prefeitos] WHERE DT_INI ='1951-02-01 00:00:00.000' 