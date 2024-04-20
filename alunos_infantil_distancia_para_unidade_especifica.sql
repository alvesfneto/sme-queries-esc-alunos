--------------------------------------------------------------------------------------------------------------------------
--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$--

/*Considerando a possibilidade de atendimento de infantil no CEI MARIA AMÉLIA GONÇALVES EOL 309728, 
solicitamos relatório de alunos matriculados no infantil Unificado com endereço cuja distância seja inferior 
a 1000 metros lineares , ou seja, menos de 1,5km do endereço Rua Hermilina Trindade da Silva, 30 
para pesquisa junto aos responsáveis sobre o interesse em transferência para esta unidade. 

O relatório deve conter as seguintes informações: 
nome do aluno
EOL
unidade de matrícula
endereço completo
telefones de contatos
distância para unidade de matrícula
distância para o endereço Rua Hermilina Trindade da silva , 30
*/
--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$--
/*DROP TABLE ##END_DESTINO
CREATE TABLE ##END_DESTINO (
	ID  INT IDENTITY(0,1),
	ENDERECO NVARCHAR(200) NULL,
	LAT FLOAT NULL,
	LON FLOAT NULL,
	DATA_GERACAO DATETIME NULL	)*/


TRUNCATE TABLE TAB_END

--ENDEREÇO 1
DECLARE @END NVARCHAR(200) SET @END ='Rua PIRAJU, 913 - CEI TIO TUTA'
DECLARE @LAT_Y FLOAT SET @LAT_Y =   -23.803069        
DECLARE	@LON_X FLOAT SET @LON_X =   -46.725386
INSERT INTO ##END_DESTINO  
SELECT @END,@LAT_Y, @LON_X,  SYSDATETIME() WHERE @LAT_Y IS NOT NULL
GO
--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$--

DROP TABLE ##ALUNOS_INF_PARA_UE_309729
SELECT 
NOME_ALUNO,
COD_ALUNO,
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
SERIE_ANO,
TP_LOGRADOURO,
ENDEREÇO,
NR,
COMPL,
BAIRRO,
RESPONSÁVEL,
TEL_CELULAR,
TEL_FIXO,
FLOOR(DIST_ALU_ESCOLA) AS DIST_ALU_ESCOLA,
ENDERECO AS ENDERECO_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (LAT * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (LON * 1000000)),2)) / 10)/0.6) AS DIST_DESTINO

INTO ##ALUNOS_INF_PARA_UE_309724

FROM ##END_DESTINO A, TBL_ENDERECOS_ALUNOS B
WHERE SERIE_ANO LIKE 'INFANTIL%'
	  AND CD_ESCOLA<>'309724'--EXCLUEM-SE OS ALUNOS DA ESCOLA DESTINO
AND FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (LAT * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (LON * 1000000)),2)) / 10)/0.6)<=1500

--SELECT * FROM ##ALUNOS_INF_PARA_UE_309724
-----------------------------------------------------------------------------------------