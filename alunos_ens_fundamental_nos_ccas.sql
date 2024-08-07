
/*

Nome da Organiza��o parceira
nome do equipamento
endere�o
distrito
setor educacional
total de matr�culas no CCA por turno
quantos estudantes por s�rie  (na EMEF) - por exemplo 25 de 1� ano, 32 no 2� ano....
*/



DROP TABLE ##MATRICULAS_FUND_NO_CCA
SELECT DISTINCT
DRE,B.CD_ESCOLA,SG_TP_ESCOLA,NOMESC,DISTR,SETOR,A.CD_ALUNO,D.dc_tipo_turno,E.SG_SERIE_ENSINO
INTO ##MATRICULAS_FUND_NO_CCA
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN SME_CLASSES_DIARIO C ON A.CD_TURMA_ESCOLA=C.CD_TURMA_ESCOLA
JOIN tipo_turno D ON C.CD_TIPO_TURNO=D.cd_tipo_turno
RIGHT JOIN (SELECT CD_ALUNO,SG_SERIE_ENSINO FROM SME_ALUNOS_DIARIO WHERE CD_ETAPA_ENSINO IN (5,13)) E ON A.CD_ALUNO = E.CD_ALUNO
WHERE A.CD_TIPO_PROGRAMA=430
--SELECT * FROM ##MATRICULAS_FUND_NO_CCA WHERE CD_ESCOLA = 200265
--SELECT DISTINCT CD_ALUNO FROM ##MATRICULAS_FUND_NO_CCA WHERE CD_ESCOLA = 200265
ORDER BY SG_SERIE_ENSINO

--SELECT DISTINCT SG_SERIE_ENSINO FROM ##MATRICULAS_FUND_NO_CCA


DROP TABLE ##MATRICULAS_FUND_NO_CCA2
SELECT DISTINCT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
DISTR,
SETOR,
COUNT (DISTINCT CD_ALUNO) AS TOTAL,
--COUNT (DISTINCT CASE WHEN dc_tipo_turno IN ('Manh�','Tarde') THEN CD_ALUNO ELSE NULL END) AS TOTAL,
COUNT (DISTINCT CASE WHEN dc_tipo_turno = 'Manh�' THEN CD_ALUNO ELSE NULL END) AS MANH�,
COUNT (DISTINCT CASE WHEN dc_tipo_turno = 'Tarde' THEN CD_ALUNO ELSE NULL END) AS TARDE,
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '1� ANO' THEN CD_ALUNO ELSE NULL END) AS [1� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '2� ANO' THEN CD_ALUNO ELSE NULL END) AS [2� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '3� ANO' THEN CD_ALUNO ELSE NULL END) AS [3� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '4� ANO' THEN CD_ALUNO ELSE NULL END) AS [4� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '5� ANO' THEN CD_ALUNO ELSE NULL END) AS [5� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '6� ANO' THEN CD_ALUNO ELSE NULL END) AS [6� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '7� ANO' THEN CD_ALUNO ELSE NULL END) AS [7� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '8� ANO' THEN CD_ALUNO ELSE NULL END) AS [8� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = '9� ANO' THEN CD_ALUNO ELSE NULL END) AS [9� ANO],
COUNT (DISTINCT CASE WHEN SG_SERIE_ENSINO = 'FUND I BILINGUE I' THEN CD_ALUNO ELSE NULL END) AS [FUND I BILINGUE I]
INTO ##MATRICULAS_FUND_NO_CCA2
FROM ##MATRICULAS_FUND_NO_CCA
GROUP BY 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
DISTR,
SETOR
--SELECT * FROM ##MATRICULAS_FUND_NO_CCA2 WHERE MANH�+TARDE <>TOTAL ORDER BY DRE



    DROP TABLE ##LISTA_CCAS
	SELECT 

	DC_SUB_PREFEITURA,DRE,CD_ESCOLA,SG_TP_ESCOLA, NOMESC, ENDERECO, NR, COMPL,BAIRRO,FONE1,FONE2,EMAIL, 
	
	CASE WHEN CD_SIT=1 THEN 'ATIVA'
	     WHEN CD_SIT=2 THEN 'EXTINTA'
	ELSE NULL END AS SITUACAO 
	INTO ##LISTA_CCAS
	FROM SME_ESCOLA_DIARIO WHERE TP_ESCOLA=29
	--SELECT * FROM ##LISTA_CCAS
	SELECT * INTO ##LISTA_CCAS_ATIVAS FROM ##LISTA_CCAS WHERE SITUACAO = 'ATIVA'
	--SELECT * FROM ##LISTA_CCAS_ATIVAS
	SELECT * INTO ##LISTA_CCAS_EXTINTAS FROM ##LISTA_CCAS WHERE SITUACAO = 'EXTINTA'
	--SELECT * FROM ##LISTA_CCAS_EXTINTAS

	DROP TABLE ##MATRIC_CCA
	SELECT 
	DRE,
	A.CD_ESCOLA,
	SG_TP_ESCOLA,
	NOMESC,
	CD_ALUNO,
	COUNT(CD_MATRICULA) AS MATRIC,
	CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
	INTO ##MATRIC_CCA
	FROM SME_ALUNOS_DIARIO A
	JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
	WHERE CD_TIPO_PROGRAMA=430
	GROUP BY 
	DRE,
	A.CD_ESCOLA,
	SG_TP_ESCOLA,
	NOMESC,
	CD_ALUNO,
	A.CRDATE
	--SELECT * FROM ##MATRIC_CCA

	
	/*
	
	SELECT 
	DRE,
	A.CD_ESCOLA,
	C.SG_TP_ESCOLA,
	C.NOMESC,
	A.CD_ALUNO,
	A.CD_MATRICULA,
	B.CD_TIPO_TURNO,
	B.QTD_DIAS,
	SEG,
	TER,
	QUA,
	QUI,
	SEX
				
	FROM SME_ALUNOS_DIARIO A
	JOIN SME_CLASSES_DIARIO B ON A.CD_TURMA_ESCOLA=B.CD_TURMA_ESCOLA
	JOIN (SELECT * FROM ##MATRIC_CCA WHERE MATRIC>1) C ON A.CD_ALUNO=C.CD_ALUNO
	ORDER BY A.CD_ALUNO

	*/

	
	
