USE [Db_local]
GO

/****** Object:  StoredProcedure [dbo].[BI_ESCOLA_AMBIENTE]    Script Date: 20/06/2024 13:58:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--DROP PROC [dbo].[BI_ESCOLA_AMBIENTE]
CREATE PROCEDURE [dbo].[BI_ESCOLA_AMBIENTE]

AS



IF EXISTS (SELECT * FROM TEMPDB.DBO.SYSOBJECTS WHERE NAME = '##TELFIN') DROP TABLE ##TELFIN

SELECT DISTINCT 
	CD_UNIDADE_EDUCACAO, 
	CONVERT(NVARCHAR(4),NULL) AS DDD,  
	CONVERT(NVARCHAR(12),NULL) AS FONE1,  
	CONVERT(NVARCHAR(12),NULL) AS FONE2,
	CONVERT(NVARCHAR(12),NULL) AS FAX,
	CONVERT(NVARCHAR(100),NULL) AS EMAIL
INTO ##TELFIN 
FROM DB_LOCAL.DBO.D_DISPOSITIVO_COMUNICACAO_UNIDADE
WHERE DT_FIM IS NULL
ORDER BY CD_UNIDADE_EDUCACAO
UPDATE A SET DDD = 11, FONE1 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 1 --TELEFONE FIXO DE VOZ
UPDATE A SET DDD = 11, FONE2 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 2 --PABX      
UPDATE A SET DDD = 11, FAX =   DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 3 --FAX
UPDATE A SET DDD = 11, FONE2 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 6  AND FONE2 IS NULL AND LEN(DC_DISPOSITIVO)= 8
UPDATE A SET DDD = 11, FONE2 = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 6  AND FONE2 IS NULL AND LEN(DC_DISPOSITIVO)= 9
UPDATE A SET		   EMAIL = DC_DISPOSITIVO FROM ##TELFIN A JOIN D_DISPOSITIVO_COMUNICACAO_UNIDADE B ON A.CD_UNIDADE_EDUCACAO = B.CD_UNIDADE_EDUCACAO AND DT_FIM IS NULL WHERE DT_FIM IS NULL AND TP_DISPOSITIVO_COMUNICACAO = 9  

IF EXISTS (SELECT * FROM TEMPDB.DBO.SYSOBJECTS WHERE NAME = '##ESCOLA_AMBIENTES') DROP TABLE ##ESCOLA_AMBIENTES

SELECT 

	L.DC_TIPO_DEPENDENCIA_ADMINISTRATIVA AS NOMEDEP, 
	REDE =	CASE 
				WHEN C.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,20,23,25,27,28,30)THEN 'DIR'
				WHEN C.TP_ESCOLA IN (11,12,22,26) THEN 'CONV'
			END,
	B.NM_EXIBICAO_UNIDADE AS DRE ,
	B.NM_UNIDADE_EDUCACAO, 
	LEFT(G.CD_SETOR_DISTRITO,2) AS CD_DIST, 
	LEFT(G.NM_MICRO_REGIAO,CHARINDEX('SETOR', G.NM_MICRO_REGIAO)-1) AS DISTR,
	RIGHT(G.NM_MICRO_REGIAO,2) SETOR,
	C.TP_ESCOLA, 
	SG_TP_ESCOLA, 
	A.NM_UNIDADE_EDUCACAO AS NOMESC, 
	A.CD_UNIDADE_EDUCACAO AS CD_ESCOLA, 
	A.CD_cie_UNIDADE_EDUCACAO AS CD_ESCOLA_MEC, 
	LTRIM(RTRIM(UPPER (DC_TP_LOGRADOURO))) + ' ' + LTRIM(RTRIM(UPPER (NM_LOGRADOURO))) AS ENDERECO, 
	CD_NR_ENDERECO AS NR, 
	DC_COMPLEMENTO_ENDERECO AS COMPL, 
	NM_BAIRRO AS BAIRRO, 
	CEP = CASE WHEN LEN(CD_CEP) < 8 THEN REPLICATE('0', 8 - LEN(CD_CEP)) + RTRIM(CD_CEP) ELSE CONVERT(NVARCHAR(8), CD_CEP) END,
	DDD, 
	FONE1, 
	FONE2, 
	FAX, 
	UPPER(EMAIL) AS EMAIL, 
	TP_LOCALIZACAO_ENDERECO AS ZONA, 
	J.CD_SUB_PREFEITURA, 
	J.DC_SUB_PREFEITURA,
	DC_TIPO_AMBIENTE, 
	COUNT(CD_AMBIENTE_ESCOLA)QT_AMBIENTE,
	A.CRDATE
INTO ##ESCOLA_AMBIENTES
	 FROM DB_LOCAL.DBO.D_UNIDADE_EDUCACAO A
LEFT JOIN DB_LOCAL.DBO.D_UNIDADE_EDUCACAO B ON A.CD_UNIDADE_ADMINISTRATIVA_REFERENCIA = B.CD_UNIDADE_EDUCACAO
LEFT JOIN DB_LOCAL.DBO.D_ESCOLA C ON A.CD_UNIDADE_EDUCACAO = C.CD_ESCOLA
LEFT JOIN DB_LOCAL.DBO.D_TIPO_ESCOLA D ON C.TP_ESCOLA = D.TP_ESCOLA
LEFT JOIN DB_LOCAL.DBO.D_ENDERECO E ON A.CI_ENDERECO = E.CI_ENDERECO
LEFT JOIN DB_LOCAL.DBO.D_MICRO_REGIAO G ON E.CD_MICRO_REGIAO = G.CD_MICRO_REGIAO AND G.CD_MICRO_REGIAO > 0 
LEFT JOIN DB_LOCAL.DBO.D_TIPO_LOGRADOURO H ON E.TP_LOGRADOURO = H.TP_LOGRADOURO
LEFT JOIN ##TELFIN I ON A.CD_UNIDADE_EDUCACAO = I.CD_UNIDADE_EDUCACAO
LEFT JOIN DB_LOCAL.DBO.D_SUB_PREFEITURA J ON E.CD_SUB_PREFEITURA = J.CD_SUB_PREFEITURA
LEFT JOIN DB_LOCAL.DBO.D_TIPO_DEPENDENCIA_ADMINISTRATIVA L ON D.TP_DEPENDENCIA_ADMINISTRATIVA = L.TP_DEPENDENCIA_ADMINISTRATIVA
LEFT JOIN D_AMBIENTE_ESCOLA M ON A.CD_UNIDADE_EDUCACAO = M.CD_ESCOLA AND M.DT_FIM IS NULL
LEFT JOIN DB_LOCAL.DBO.D_TIPO_AMBIENTE N	WITH (NOLOCK) ON M.TP_AMBIENTE = N.TP_AMBIENTE AND N.DT_CANCELAMENTO IS NULL
WHERE 
	A.TP_UNIDADE_EDUCACAO = 1
	AND A.TP_SITUACAO_UNIDADE = 1
	AND M.DT_FIM IS NULL
	AND N.DT_CANCELAMENTO IS NULL
	GROUP BY L.DC_TIPO_DEPENDENCIA_ADMINISTRATIVA,
	CASE 
				WHEN C.TP_ESCOLA IN (1,2,3,4,10,13,14,16,17,18,20,23,25,27,28,30)THEN 'DIR'
				WHEN C.TP_ESCOLA IN (11,12,22,26) THEN 'CONV'
			END,
	B.NM_EXIBICAO_UNIDADE ,
	B.NM_UNIDADE_EDUCACAO, 
	LEFT(G.CD_SETOR_DISTRITO,2), 
	LEFT(G.NM_MICRO_REGIAO,CHARINDEX('SETOR', G.NM_MICRO_REGIAO)-1),
	RIGHT(G.NM_MICRO_REGIAO,2) ,
	C.TP_ESCOLA, 
	SG_TP_ESCOLA, 
	A.NM_UNIDADE_EDUCACAO, 
	A.CD_UNIDADE_EDUCACAO, 
	A.cd_cie_unidade_educacao,
	LTRIM(RTRIM(UPPER (DC_TP_LOGRADOURO))) + ' ' + LTRIM(RTRIM(UPPER (NM_LOGRADOURO))), 
	CD_NR_ENDERECO , 
	DC_COMPLEMENTO_ENDERECO, 
	NM_BAIRRO, 
	CASE WHEN LEN(CD_CEP) < 8 THEN REPLICATE('0', 8 - LEN(CD_CEP)) + RTRIM(CD_CEP) ELSE CONVERT(NVARCHAR(8), CD_CEP) END,
	DDD, 
	FONE1, 
	FONE2, 
	FAX, 
	UPPER(EMAIL), 
	TP_LOCALIZACAO_ENDERECO, 
	J.CD_SUB_PREFEITURA, 
	J.DC_SUB_PREFEITURA,
	DC_TIPO_AMBIENTE,
	A.CRDATE



IF EXISTS (SELECT * FROM TEMPDB.DBO.SYSOBJECTS WHERE NAME = '##ESCOLA_AMBIENTES_LINEAR') DROP TABLE ##ESCOLA_AMBIENTES_LINEAR

SELECT	* 
		INTO ##ESCOLA_AMBIENTES_LINEAR
		FROM ##ESCOLA_AMBIENTES AS A 
		PIVOT (
			SUM(QT_AMBIENTE) FOR 
			DC_TIPO_AMBIENTE IN (
									[SALA DE AULA PROPRIA],
									[SALA DE AULA ADAPTADA],
									[SALA DE ED. INFANTIL PROPRIA],
									[SALA DE ED. INFANTIL ADAPTADA],
									[SALA DE ED. ESPECIAL PROPRIA],
									[SALA DE ED. ESPECIAL ADAPTADA],
									[SALA DE AULA OCIOSA],
									[SALA DE EDUCACAO ARTISTICA],
									[SALA DE LEITURA],
									[SALA DE DATILOGRAFIA],
									[SALA DE COMPUTACAO],
									[SALA DE PROJECAO/VIDEO],
									[SALA DE REUNIOES],
									[SALA DE DIRETOR],
									[SALA DE ASSISTENTE DO DIRETOR],
									[SALA DE COORD. PEDAGOGICO],
									[SALA DE PROFESSORES],
									[SECRETARIA],
									[ARQUIVO],
									[ALMOXARIFADO],
									[DESPENSA /DEPOSITO ALIMENTOS],
									[DEPOSITO],
									[AUDITORIO],
									[PALCO],
									[LABORATORIO DE CIENCIAS],
									[LABORATORIO DE FISICA],
									[LABORATORIO DE QUIMICA],
									[LABORATORIO DE BIOLOGIA],
									[LABORATORIO DE PROTESE],
									[OFICINA],
									[GABINETE DENTARIO],
									[GABINETE MEDICO],
									[COZINHA],
									[REFEITORIO],
									[GALPAO],
									[SANITARIO ALUNOS - MASCULINO],
									[SANITARIO ALUNOS - FEMININO],
									[SANIT.FUNCIONARIOS-MASCULINO],
									[SANIT.FUNCIONARIOS-FEMININO],
									[VESTIARIO MASCULINO],
									[VESTIARIO FEMININO],
									[SALA DE EDUCACAO FISICA],
									[SL. MAT.DESPORTIVO/FANFARRA],
									[QUADRA COBERTA],
									[QUADRA DESCOBERTA],
									[PATIO COBERTO],
									[PATIO DESCOBERTO],
									[PISO CIMENTADO],
									[ZELADORIA],
									[GUARITA],
									[CASA DE MAQUINAS],
									[QUIOSQUE],
									[PISCINA],
									[AREA DE SERVICO],
									[PLAY GROUND],
									[SANITARIO ALUNOS - MISTO],
									[SANIT.FUNCIONARIOS - MISTO],
									[SANIT.ANEXO SL.AULA-MISTO],
									[VESTIARIO DE FUNCIONARIOS],
									[SL. AULA FORA ESC.- EMERGENCIA],
									[DEPOSITO MAT. DIDATICO/PEDAG.],
									[CAMARIM],
									[SALA DE PSICOLOGO],
									[SALA RECUPERACAO/APOIO PEDAG.],
									[CANTINA],
									[ESTACIONAMENTO],
									[SALA PARA INSTIT.AUXILIARES],
									[SALA DE AULA DESATIVADA],
									[OUTRO AMBIENTE/SALA DE AULA],
									[SALA DE RECREACAO],
									[SL. TREINAMENTO/RITMICO/CORPOR],
									[SL. TREINAMENTO/FONO/AUDIO],
									[SL. TREINAMENTO INDIVIDUAL],
									[LABORATORIO DE INFORMATICA],
									[SAP],
									[SAPNE],
									[CADASTRO DE VAGA DE EVENTUAL],
									[RAMPA DE ACESSO P/ DEFICIENTES],
									[SANITARIO PARA DEFICIENTES],
									[BERCARIO],
									[ELEVADOR],
									[SALA DE ESTUDO/PESQUISAS],
									[BRINQUEDOTECA],
									[LACTARIO],
									[SALA DE ENFERMAGEM],
									[LAVANDERIA],
									[SOLARIO],
									[TROCADOR],
									[FOYER / EXPOSICOES],
									[TEATRO],
									[ATELIE],
									[ESTUDIO],
									[ANTECAMARA],
									[RECEPCAO],
									[SALA DE DANCA / GINASTICA],
									[AREA DE BANHO],
									[PRACA DO CAFE],
									[PADARIA - ESCOLA],
									[BIBLIOTECA],
									[TELECENTRO],
									[ANFITEATRO],
									[CAMPO DE FUTEBOL],
									[PISTA DE SKATE],
									[VIDEOTECA],
									[SALA PARA TV/VIDEO],
									[GINASIO DE ESPORTES],
									[PARQUE INFANTIL],
									[DORMITORIO],
									[FRALDARIO],
									[SANITARIO FUNC FORA DO PREDIO],
									[SANITARIO ALUNO FORA DO PREDIO],
									[SANITARIO ADEQUADO PRE-ESCOLA],
									[DEPEN/VIAS ADEQUADAS ALUNO NEE],
									[CONTAINER],
									[SALA EM UNIDADE FUNCIONAL],
									[SALA RECURSOS MULTIFUNCIONAIS],
									[SALA DE PESQUISA],
									[SANITARIO ALUNOS COM CHUVEIRO],
									[AREA VERDE],
									[SALA DE MUSICA CORAL],
									[SALA MULTIUSO MUSICA DANCA ART])
				) AS DC_TIPO_AMBIENTE
ORDER BY CD_ESCOLA


GO

