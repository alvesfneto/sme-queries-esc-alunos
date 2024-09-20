

SELECT DISTINCT
B.DRE, 
B.CD_ESCOLA, 
B.SG_TP_ESCOLA AS TIPO, 
B.NOMESC, 
--A.tp_ambiente, 
c.dc_tipo_ambiente, 
A.nr_sala, 
A.qt_ideal_pessoa, 
A.qt_real_pessoa, 
A.qt_area_util,
--A.LOCALIZA AS LOCALIZACAO, 
--A.[STATUS], 
--A.padrao AS PADRAO, 
A.in_utilizacao_sala_aula, 
convert(varchar,B.CRDATE-1, 103) AS DT_BASE
INTO ##AMBIENTES_POR_UE
FROM D_AMBIENTE_ESCOLA A
INNER JOIN SME_ESCOLA_DIARIO B ON A.cd_escola = B.CD_ESCOLA
JOIN D_TIPO_AMBIENTE C ON A.tp_ambiente=C.tp_ambiente
WHERE (((A.dt_fim) Is Null)) and B.TP_ESCOLA IN (1,2,3,4,10,11,12,13,16,17,18,28,30,31) AND B.CD_SIT=1
--select * from ##AMBIENTES_POR_UE
----------------------------------------------------------------------------------------------------------
DROP TABLE ##CADASTRO_ESCOLAS_DIVULGACAO_FORMA_OCUPACAO
select *
INTO ##CADASTRO_ESCOLAS_DIVULGACAO_FORMA_OCUPACAO
from VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL A
LEFT JOIN (
SELECT
		A.CD_ESCOLA,
		C.dc_tipo_proprietario AS PROPRIETÁRIO,
		B.dc_tipo_forma_ocupacao_predio AS [FORMA OCUPAÇÃO],
		A.CRDATE AS [DATA BASE]
		FROM SME_ESCOLA_DIARIO A
		left JOIN D_ESCOLA AA ON A.CD_ESCOLA=AA.cd_escola
		left JOIN [tipo_forma_ocupacao_predio] B ON AA.tp_forma_ocupacao_predio = B.tp_forma_ocupacao_predio
		left JOIN [tipo_proprietario] C ON AA.tp_proprietario = C.tp_proprietario
		WHERE A.TP_ESCOLA IN (1,2,3,4,10,11,12,13,16,17,18,28,30,31) 
		AND A.CD_SIT=1) B ON A.CODESC=B.CD_ESCOLA

--select * from ##CADASTRO_ESCOLAS_DIVULGACAO_FORMA_OCUPACAO