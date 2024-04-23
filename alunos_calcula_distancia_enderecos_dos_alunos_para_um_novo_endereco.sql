

--CONSULTA QUE CALCULA A DIST�NCIA DOS ENDERE�OS DOS ALUNOS DE UMA DETERMINADA ESCOLA PARA UM NOVO ENDERE�O
USE Db_Local_0


/*DROP TABLE ##END_DESTINO
CREATE TABLE ##END_DESTINO (
	ID  INT IDENTITY(0,1),
	ENDERECO NVARCHAR(200) NULL,
	LAT FLOAT NULL,
	LON FLOAT NULL,
	DATA_GERACAO DATETIME NULL	)*/
TRUNCATE TABLE ##END_DESTINO

--ENDERE�O 1
DECLARE @END NVARCHAR(200) SET @END ='Avenida J�lio Buono, 1018 - CEP 02201-000'--FORNECER O ENDERE�O
DECLARE @LAT_Y FLOAT SET @LAT_Y = -23.490010372489 				    --INFORMAR A LATITUDE DO ENDERE�O(GOOGLE  MAPS)
DECLARE	@LON_X FLOAT SET @LON_X = -46.595340187325306               --INFORMAR A LONGITUDE DO ENDERE�O(GOOGLE  MAPS)
INSERT INTO ##END_DESTINO  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO
--------------------------------------------------------------------------------
--SELECT * FROM ##END_DESTINO
--SELECT TOP 1 * FROM TBL_ENDERECOS_ALUNOS

DROP TABLE ##ALUNOS_NOVO_DESTINO
SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
M�E_ALUNO,
RESPONS�VEL,
DDD,
TEL_CELULAR,
TEL_FIXO,
TP_LOGRADOURO,
B.ENDERE�O,
NR,
COMPL,
BAIRRO,
FLOOR(DIST_ALU_ESCOLA) AS DIST_ESCOLA,
A.ENDERECO AS END_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (LAT * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (LON * 1000000)),2)) / 10)/0.6) AS DIST_DESTINO,
B.CRDATE

INTO ##ALUNOS_NOVO_DESTINO

FROM ##END_DESTINO A, TBL_ENDERECOS_ALUNOS B

WHERE B.CD_ESCOLA = '308018' -- INFORMAR O CD_ESCOLA DA UNIDADE DE MATRICULA DOS ALUNOS
--AND 
--FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (LAT * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (LON * 1000000)),2)) / 10)/0.6)<=1500
--SELECT * FROM ##ALUNOS_NOVO_DESTINO

SELECT * FROM TBL_ENDERECOS_ALUNOS WHERE CD_ESCOLA=308018