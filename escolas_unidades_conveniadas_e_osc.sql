/*
ESTUDO UNIDADES CONVENIADAS E INSTITUIÇÕES

cd_situacao_convenio
       1	Em Análise
       2	Aprovado
       3	Reprovado
       4	Encerrado
       5	Análise de SME
cd_situacao_instituicao
       1	Apto
       2	Não apto
       3	Em análise

select * from [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[tipo_unidade_educacao]
tp_unidade_educacao	dc_tipo_unidade_educacao
       1	ESCOLA
       2	UNIDADE EXTERNA
       3	UNIDADE ADMINISTRATIVA
       4	INSTITUICAO
*/

SELECT 
    DRE,
	A.cd_instituicao,
	nm_unidade_educacao,
	CONVERT(VARCHAR,dt_inicio_convenio,103) AS DT_INICIO_CONVENIO,
	CONVERT(VARCHAR,dt_fim_convenio,103) AS DT_FIM_CONVENIO,
    cd_escola AS CD_ESCOLA,
	CASE
	    WHEN LEFT(nm_creche,3)='CR.' THEN 'CR.P.CONV'
		WHEN LEFT(nm_creche,3)='CEI' THEN 'CEI INDIR'
	ELSE NULL END AS TP_ESCOLA,
    nm_creche AS NM_CRECHE,
    --qt_vaga_bercario AS VG_BERCARIO,
    qt_vaga_contratada AS VG_CONTRATADA,
	CONVERT(VARCHAR,GETDATE()-1,103) AS DT_BASE

FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[dbo].[convenio_creche_escola] A
JOIN tbl_dre B ON A.cd_dre=B.CD_DRE
JOIN (SELECT 
      cd_unidade_educacao, 
	  nm_unidade_educacao,
	  tp_unidade_educacao 
	  FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[unidade_educacao] 
	  WHERE tp_unidade_educacao=4) C ON A.cd_instituicao=C.cd_unidade_educacao
WHERE cd_situacao_convenio=2 







