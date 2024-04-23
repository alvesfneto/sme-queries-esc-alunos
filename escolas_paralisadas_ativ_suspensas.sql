--estudo situação de escolas particulares - atividades suspensas ou paralisadas
drop table ##PARALISADAS
SELECT DISTINCT
--CD_SIT,
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
ENDERECO,
NR,
BAIRRO,
dc_tipo_ocorrencia_historica AS OCORRENCIA,
dc_ato,
CONVERT(VARCHAR,dt_publicacao_dom,103) AS DT_DOC,
CONVERT (VARCHAR,CRDATE-1,103) AS DT_BASE
INTO ##PARALISADAS
FROM SME_ESCOLA_DIARIO A
JOIN(
     SELECT 
     cd_unidade_educacao,
     B.dc_tipo_ocorrencia_historica,
     dc_ato,
     dt_publicacao_dom
	 from D_HISTORICO_UNIDADE A
     JOIN tipo_ocorrencia_historica B ON A.tp_ocorrencia_historica=B.tp_ocorrencia_historica
     WHERE (DC_ATO ='ATIVIDADES SUSPENSAS' OR DC_ATO LIKE '%PARALISA%')) C ON A.CD_ESCOLA=C.cd_unidade_educacao
WHERE CD_SIT IN (5,6)-- AND TP_ESCOLA = 15
--select * from ##PARALISADAS 

--SELECT * FROM SME_ESCOLA_DIARIO WHERE CD_SIT IN (5,6) AND TP_ESCOLA=15

/********************************************************************************************************************/

select distinct DRE,CD_ESCOLA,SG_TP_ESCOLA,NOMESC,dc_ato, A.DT_DOC from ##PARALISADAS A
JOIN 
DB_EDUCACAO_1_PRODAM.SE1426.DBO.UNIDADE_EDUCACAO B ON A.CD_ESCOLA=B.CD_UNIDADE_EDUCACAO

WHERE B.TP_SITUACAO_UNIDADE IN (5,6) order by SG_TP_ESCOLA

/********************************************************************************************************************/

--SELECT * FROM SME_ESCOLA_DIARIO WHERE ENDERECO LIKE '%RIO PEQUENO%'










