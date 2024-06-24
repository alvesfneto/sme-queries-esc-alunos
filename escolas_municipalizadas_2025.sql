
--ATRIBUINDO CÓDIGOS EOL PARA AS NOVAS UNIDADES EMEF MUNICIPALIZADAS

--https://dba-pro.com/incluir-numeros-nas-linhas-do-select/ -->FONTE DE CONSULTA

--SELECT * FROM [dbo].[tratadas$] - TABELA ORIGINAL


--select * from VW_COMPARA_CODIGOS where cd_escola like '019%' order by cd_escola desc --> verifica qual o último código utilizado para as emefs.
-- Criando sequencia
if object_id('sLinhas') is not null drop sequence sLinhas
create sequence sLinhas as int start with 019741

DROP TABLE tbl_escolas_municipalizadas_2025 
select
    A.DRE,
	CONCAT('0',next value for sLinhas) as CD_ESCOLA,
    [CODIGO CIE],
	A.DE,
	DISTRITO,
	A.SETOR,
	NOME_ESCOLA,
	ENDESC,
    NUMESC,
    BAIESC,
    CONCAT(CODCEP,COMPCEP) AS CEP 
INTO tbl_escolas_municipalizadas_2025

from [dbo].[tratadas$] A ---------------------------------->base recebida: escolas municipalizadas
JOIN [dbo].[SE_ESCOLAS] B ON A.[CODIGO CIE] =B.COD_ESC ---->[SE_ESCOLAS]: lista de escola do estado
WHERE ANO=2025

--SELECT * FROM tbl_escolas_municipalizadas_2025
--==============================================================================================================================


/*
utilizei o código abaixo inicialmente mas o processo atual é mais direto, e rápido
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--SELECT * FROM [dbo].[tratadas$]

--selecionar um range de códigos EOL para ser utilizado atribuindo um indice
select TOP 25 *,row_number() OVER (ORDER BY [COD]) AS INDICE INTO ##base1 from Db_Local..base_sequencia where COD>019740
--select * from ##base1
--organizar lista de escolas que serão municipalizadas
select *, ROW_NUMBER() over(ORDER BY [CODIGO CIE]) AS INDICE INTO ##lista1 from [dbo].[tratadas$] WHERE ANO =2025 
--select * from ##lista1
--drop table tbl_municipalizadas_2025
SELECT 
DRE,
DE,
DISTRITO,
SETOR,
'EMEF' AS SG_TP_ESCOLA,
NOME_ESCOLA,
[CODIGO CIE],
COD AS CD_ESCOLA
INTO tbl_municipalizadas_2025
FROM ##lista1 A
JOIN ##base1 B ON A.INDICE=B.INDICE ORDER BY COD
--select * from tbl_municipalizadas_2025 ORDER BY CD_ESCOLA


--INCLUINDO O ENDEREÇO DAS ESCOLAS COM BASE NA TABELA DE ESCOLAS DO ESTADO - [SE_ESCOLAS]
--drop table tbl_escolas_municipalizadas_2025
SELECT 
A.*, 
ENDESC,
NUMESC,
BAIESC,
CONCAT(CODCEP,COMPCEP) AS CEP 
INTO tbl_escolas_municipalizadas_2025
FROM tbl_municipalizadas_2025 A
JOIN [dbo].[SE_ESCOLAS] B ON A.[CODIGO CIE] =B.COD_ESC
--select * from tbl_escolas_municipalizadas_2025



--https://www.youtube.com/watch?v=v_06ORjZgsY

--DROP SEQUENCE base_sequencia
CREATE SEQUENCE base_sequencia
	START WITH 19741
	INCREMENT BY 1
	MINVALUE 19741
	MAXVALUE 19800
	NO CACHE

SELECT NEXT  VALUE  FOR base_sequencia AS SEQ


