USE [Db_local]
GO

/****** Object:  StoredProcedure [dbo].[GERA_ESCOLAS_DIARIO]    Script Date: 20/06/2024 13:56:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[GERA_ESCOLAS_DIARIO]

AS


--GERA ARQUIVO LINEAR DE TELEFONE
IF EXISTS (
			SELECT * FROM TEMPDB.DBO.SYSOBJECTS 
			WHERE NAME = '##TELFIN'
			) 
DROP TABLE ##TELFIN


SELECT	DISTINCT 
		CD_UNIDADE_EDUCACAO, 
		CONVERT(NVARCHAR(4),NULL) AS DDD,  
		CONVERT(NVARCHAR(12),NULL) AS FONE1,  
		CONVERT(NVARCHAR(12),NULL) AS FONE2,
		CONVERT(NVARCHAR(12),NULL) AS FAX,
		CONVERT(NVARCHAR(100),NULL) AS EMAIL
		INTO ##TELFIN 
		FROM D_DISPOSITIVO_COMUNICACAO_UNIDADE
		WHERE DT_FIM IS NULL
		ORDER BY CD_UNIDADE_EDUCACAO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE A SET DDD = 11, FONE1 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 1 --TELEFONE FIXO DE VOZ
UPDATE A SET DDD = 11, FONE2 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 2 --PABX      
UPDATE A SET DDD = 11, FAX =   DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 3 --FAX
UPDATE A SET DDD = 11, FONE2 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 6 AND FONE2 IS NULL AND LEN(DC_DISPOSITIVO)= 8
UPDATE A SET DDD = 11, FONE2 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 6 AND FONE2 IS NULL AND LEN(DC_DISPOSITIVO)= 9
UPDATE A SET		   EMAIL = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 9 AND DC_DISPOSITIVO LIKE '%PREFEITURA%' --ATUALIZANDO EM DUAS ETAPAS D� PREFERENCIA AO EMAIL INSTITUCIONAL
UPDATE A SET		   EMAIL = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 9 AND EMAIL IS NULL
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (
			SELECT * FROM Db_Local.DBO.SYSOBJECTS 
			WHERE NAME = 'SME_ESCOLA_DIARIO'
			) 
DROP TABLE SME_ESCOLA_DIARIO

SELECT	A.TP_SITUACAO_UNIDADE AS CD_SIT, 
		C.TP_DEPENDENCIA_ADMINISTRATIVA AS DEPADM, 
		L.DC_TIPO_DEPENDENCIA_ADMINISTRATIVA AS NOMEDEP,
		REDE = CASE WHEN C.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,20,23,25,27,28,31,30)THEN 'DIR'
					WHEN C.TP_ESCOLA IN (11,12,22,26) THEN 'CONV'
					END ,
		B.NM_EXIBICAO_UNIDADE AS DRE ,
		B.NM_UNIDADE_EDUCACAO, 
		F.CD_DISTRITO_MEC AS CD_DIST, 
		NM_DISTRITO_MEC AS DISTR, 
		RIGHT(NM_MICRO_REGIAO,2) AS SETOR,
		C.TP_ESCOLA, 
		SG_TP_ESCOLA, 
		A.NM_UNIDADE_EDUCACAO AS NOMESC, 
		A.CD_UNIDADE_EDUCACAO AS CD_ESCOLA, 
		'0'+RIGHT(A.CD_CIE_UNIDADE_EDUCACAO,6) AS COD_ESC,
		A.CD_CIE_UNIDADE_EDUCACAO AS CODESCMEC, 
		'0'+RIGHT(A.CD_UNIDADE_EDUCACAO_PRODESP,6) AS CD_CIE_UNID, 
		LTRIM(RTRIM(UPPER (DC_TP_LOGRADOURO))) + ' ' + LTRIM(RTRIM(UPPER (NM_LOGRADOURO))) AS ENDERECO, 
		CD_NR_ENDERECO AS NR, 
		DC_COMPLEMENTO_ENDERECO AS COMPL, 
		NM_BAIRRO AS BAIRRO, 
		CEP = CASE WHEN LEN(CD_CEP) < 8 THEN REPLICATE('0', 8 - LEN(CD_CEP)) + RTRIM(CD_CEP) ELSE CONVERT(NVARCHAR(8), CD_CEP) END,
		E.CD_COORDENADA_GEO_Y,
		E.CD_COORDENADA_GEO_X, 
		DDD, 
		FONE1, 
		FONE2, 
		FAX, 
		UPPER(EMAIL) AS EMAIL, 
		TP_LOCALIZACAO_ENDERECO AS ZONA, 
		J.CD_SUB_PREFEITURA, 
		J.DC_SUB_PREFEITURA,
		GETDATE() AS CRDATE
		INTO	  Db_Local.DBO.SME_ESCOLA_DIARIO
		FROM	  D_UNIDADE_EDUCACAO A
		LEFT JOIN D_UNIDADE_EDUCACAO B ON A.CD_UNIDADE_ADMINISTRATIVA_REFERENCIA = B.CD_UNIDADE_EDUCACAO
		LEFT JOIN D_ESCOLA C ON A.CD_UNIDADE_EDUCACAO = C.CD_ESCOLA
		LEFT JOIN D_TIPO_ESCOLA D ON C.TP_ESCOLA = D.TP_ESCOLA
		LEFT JOIN D_ENDERECO E ON A.CI_ENDERECO = E.CI_ENDERECO
		LEFT JOIN D_DISTRITO_MEC F ON E.CD_DISTRITO_MEC = F.CD_DISTRITO_MEC AND F.CD_MUNICIPIO = 3550308
		LEFT JOIN D_MICRO_REGIAO G ON E.CD_MICRO_REGIAO = G.CD_MICRO_REGIAO AND G.CD_MICRO_REGIAO > 0
		LEFT JOIN D_TIPO_LOGRADOURO H ON E.TP_LOGRADOURO = H.TP_LOGRADOURO
		LEFT JOIN ##TELFIN I ON A.CD_UNIDADE_EDUCACAO = I.CD_UNIDADE_EDUCACAO
		LEFT JOIN D_SUB_PREFEITURA J ON E.CD_SUB_PREFEITURA = J.CD_SUB_PREFEITURA
		LEFT JOIN D_TIPO_DEPENDENCIA_ADMINISTRATIVA L ON D.TP_DEPENDENCIA_ADMINISTRATIVA = L.TP_DEPENDENCIA_ADMINISTRATIVA
		WHERE 
			A.TP_UNIDADE_EDUCACAO = 1
			AND CD_ESCOLA <> 888888 /*ESCOLA DE TESTE PRODAM*/
			--AND A.TP_SITUACAO_UNIDADE = 1

CREATE INDEX INDEX_CD_ESCOLA							ON Db_Local.DBO.SME_ESCOLA_DIARIO (CD_ESCOLA)

UPDATE A SET NOMEDEP =	'MUNICIPAL', DEPADM = 3 FROM SME_ESCOLA_DIARIO A WHERE TP_ESCOLA = 20

GO


