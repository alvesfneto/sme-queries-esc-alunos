
/*
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_INSTITUICAO')
DROP TABLE D_INSTITUICAO
SELECT *, GETDATE() AS CRDATE INTO DB_CONVENIOS.DBO.D_INSTITUICAO						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[instituicao]
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_convenio_creche_escola')
DROP TABLE D_convenio_creche_escola
SELECT *, GETDATE() AS CRDATE INTO DB_CONVENIOS.DBO.D_convenio_creche_escola						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[convenio_creche_escola]
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_situacao_convenio')
DROP TABLE D_situacao_convenio
SELECT *, GETDATE() AS CRDATE INTO DB_CONVENIOS.DBO.D_situacao_convenio						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[situacao_convenio]
GO


IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_ESCOLA')
DROP TABLE D_ESCOLA
SELECT *, GETDATE() AS CRDATE INTO DB_CONVENIOS.DBO.D_ESCOLA						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[escola]
GO

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_UNIDADE_EDUCACAO')
DROP TABLE D_UNIDADE_EDUCACAO
SELECT *, GETDATE() AS CRDATE INTO DB_CONVENIOS.DBO.D_UNIDADE_EDUCACAO						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[unidade_educacao]
GO

SELECT * INTO DB_CONVENIOS.DBO.situacao_instituicao						
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[situacao_instituicao]

SELECT * INTO DB_CONVENIOS.DBO.tipo_convenio					
FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[tipo_convenio]

[dbo].[tipo_convenio]
*/

          --SELECT
          --[CD_ESCOLA],
          --COUNT ([CD_ESCOLA]) AS QTDE
          --FROM 
          --##CNPJ_CRECHES
          --GROUP BY
          --[CD_ESCOLA]
          --HAVING (COUNT ([CD_ESCOLA])>1)
          --ORDER BY 1

DROP TABLE ##CNPJ_CRECHES
SELECT
DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
C.cd_instituicao,
C.cd_cnpj,
B.cd_cnpj_unidade_privada,
B.cd_cnpj_entidade_executora,
CASE WHEN (C.cd_cnpj = B.cd_cnpj_entidade_executora AND C.cd_cnpj = B.cd_cnpj_unidade_privada) THEN 'OK'
     ELSE 'CORRIGIR CNPJ' END AS OBSERVACAO
INTO ##CNPJ_CRECHES
FROM Db_Local..SME_ESCOLA_DIARIO A

JOIN(SELECT DISTINCT 
      B.CD_ESCOLA,
      cd_cnpj_entidade_executora,
      cd_cnpj_unidade_privada 
      FROM Db_Local..D_ESCOLA A
      JOIN Db_Local..SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA
      WHERE A.tp_escola IN(11,12) AND B.CD_SIT=1) B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN(SELECT 
      A.cd_instituicao,
      cd_cnpj,
      B.cd_escola,
	  MAX(B.dt_fim_convenio) AS DT_FIM_CONVENIO
      FROM
      Db_local..d_instituicao A 
      JOIN Db_local..D_convenio_creche_escola B ON A.cd_instituicao=B.cd_instituicao
	  WHERE cd_situacao_instituicao=1 AND B.cd_situacao_convenio=2
	  GROUP BY 
	  A.cd_instituicao,
	  cd_cnpj,
	  B.cd_escola) C ON A.CD_ESCOLA=C.CD_ESCOLA
WHERE A.TP_ESCOLA IN (11,12)

--SELECT * FROM ##CNPJ_CRECHES where observacao ='ok'

--SELECT * FROM D_INSTITUICAO where nm
--SELECT * FROM D_convenio_creche_escola
--SELECT * FROM D_situacao_convenio
--SELECT * FROM D_ESCOLA
--SELECT * FROM D_UNIDADE_EDUCACAO WHERE CD_UNIDADE_ADMINISTRATIVA_REFERENCIA IN (108100,108200,108300,108400,108500,108600,108700,108800,108900,109000,109100,109200,109300) AND TP_SITUACAO_UNIDADE=1
--SELECT * FROM situacao_instituicao
--SELECT * FROM tipo_convenio

SELECT * FROM D_INSTITUICAO A
JOIN D_convenio_creche_escola B ON A.CD_INSTITUICAO=B.CD_INSTITUICAO
WHERE B.CD_SITUACAO_CONVENIO = 2

/*LISTA DAS DRE*/
SELECT cd_unidade_educacao AS CD_DRE, nm_exibicao_unidade AS DRE, nm_unidade_educacao AS NM_DRE into tbl_dre from D_UNIDADE_EDUCACAO
WHERE cd_unidade_educacao in (108100,108200,108300,108400,108500,108600,108700,108800,108900,109000,109100,109200,109300) ORDER BY 1

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

--RESUMO INSTITUIÇÕES PARCEIRAS APTAS COM CONVENIOS APROVADOS
SELECT distinct
A.CD_INSTITUICAO,
--B.CD_UNIDADE_EDUCACAO,
B.NM_UNIDADE_EDUCACAO,
A.CD_CNPJ,
--A.CD_SITUACAO_INSTITUICAO,
C.dc_situacao_instituicao,
E.DC_SITUACAO_CONVENIO,
F.sg_tipo_convenio AS SG_TP_ESCOLA,
COUNT (DISTINCT D.CD_ESCOLA) AS UNIDADES,
SUM(D.qt_vaga_bercario) AS VG_BERCARIO,
SUM(D.qt_vaga_contratada) AS VG_CONTRATADA,
CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
FROM D_INSTITUICAO A
JOIN D_UNIDADE_EDUCACAO B ON A.CD_INSTITUICAO=B.CD_UNIDADE_EDUCACAO
JOIN D_convenio_creche_escola D ON A.CD_INSTITUICAO=D.CD_INSTITUICAO
JOIN SITUACAO_INSTITUICAO C ON A.CD_SITUACAO_INSTITUICAO=C.CD_SITUACAO_INSTITUICAO
JOIN D_situacao_convenio E ON D.CD_SITUACAO_CONVENIO = E.CD_SITUACAO_CONVENIO
join tipo_convenio F ON D.cd_tipo_convenio=F.cd_tipo_convenio
where A.CD_SITUACAO_INSTITUICAO = 1 AND D.CD_SITUACAO_CONVENIO=2
GROUP BY
A.CD_INSTITUICAO,
B.NM_UNIDADE_EDUCACAO,
A.CD_CNPJ,
C.dc_situacao_instituicao,
E.DC_SITUACAO_CONVENIO,
F.sg_tipo_convenio,
A.CRDATE
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

--LISTA DAS INSTITUIÇÕES PARCEIRAS APTAS COM CONVENIOS APROVADOS*/
SELECT distinct
G.DRE,
A.CD_INSTITUICAO,
--B.CD_UNIDADE_EDUCACAO,
B.NM_UNIDADE_EDUCACAO,
A.CD_CNPJ,
--A.CD_SITUACAO_INSTITUICAO,
C.dc_situacao_instituicao,
E.DC_SITUACAO_CONVENIO,
F.sg_tipo_convenio AS SG_TP_ESCOLA,
D.CD_ESCOLA,
nm_creche AS NOMESC,
--D.qt_vaga_bercario AS VG_BERC,
--D.qt_vaga_contratada AS VG_CONTRATADA,
CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
FROM D_INSTITUICAO A
JOIN D_UNIDADE_EDUCACAO B ON A.CD_INSTITUICAO=B.CD_UNIDADE_EDUCACAO
JOIN D_convenio_creche_escola D ON A.CD_INSTITUICAO=D.CD_INSTITUICAO
JOIN SITUACAO_INSTITUICAO C ON A.CD_SITUACAO_INSTITUICAO=C.CD_SITUACAO_INSTITUICAO
JOIN D_situacao_convenio E ON D.CD_SITUACAO_CONVENIO = E.CD_SITUACAO_CONVENIO
JOIN tipo_convenio F ON D.cd_tipo_convenio=F.cd_tipo_convenio
JOIN (SELECT cd_unidade_educacao AS CD_DRE, nm_exibicao_unidade AS DRE, nm_unidade_educacao AS NM_DRE from D_UNIDADE_EDUCACAO
WHERE cd_unidade_educacao in (108100,108200,108300,108400,108500,108600,108700,108800,108900,109000,109100,109200,109300)) G ON D.cd_dre=G.CD_DRE
where A.CD_SITUACAO_INSTITUICAO = 1 AND D.CD_SITUACAO_CONVENIO=2
/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
