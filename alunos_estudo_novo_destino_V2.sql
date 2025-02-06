/*
Solicitamos o estudo ponto a ponto dos endere�os dos alunos matriculados na CR.P.CONV - PACAEMBU - 306870 em rela��o as creches at� 3,0 km.
*/

--> Definindo as unidades de destino das matriculas

DROP TABLE ##destino
SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
CONCAT(CD_ESCOLA,' ',SG_TP_ESCOLA,' ', NOMESC) AS DESTINO, 
CD_COORDENADA_GEO_Y,
CD_COORDENADA_GEO_X 
INTO ##destino
FROM SME_ESCOLA_DIARIO 
WHERE CD_ESCOLA<>306870 -->ELIMINA A UNIDADE DE MATRICULA DO ALUNO
AND TP_ESCOLA IN (10,11,12,18,28,31) -->DEFINE OS TIPOS DE ESCOLA DESTINO
AND CD_SIT=1 --> APENAS UNIDADES ATIVAS
--SELECT * FROM ##destino


/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
--> Filtrando as matriculas da unidade origem

DROP TABLE ##origem
SELECT
cd_escola,
SG_TP_ESCOLA,
NOME_ESCOLA,
NOME_ALUNO,
COD_ALUNO AS CD_ALUNO,
ETAPA,
SERIE_ANO,
CONCAT (UPPER (TP_LOGRADOURO),' ',ENDERE�O) AS ENDERE�O,
NR AS N�MERO,
COMPL AS COMPLEMENTO,
BAIRRO,
DIST_ESCOLA,
LAT_ALUNO,
LON_ALUNO

INTO ##origem
FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS

WHERE cd_escola=306870 
---SELECT * FROM ##origem


/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
--> GERA A TABELA ##alunos_origem

DROP TABLE ##alunos_origem
SELECT 
CONCAT (A.CD_ESCOLA,' ',A.SG_TP_ESCOLA,' ',A.NOME_ESCOLA) AS ESCOLA_ORIGEM,
NOME_ALUNO,
CD_ALUNO,
ETAPA,
SERIE_ANO,
ENDERE�O,
N�MERO,
COMPLEMENTO,
BAIRRO,
DIST_ESCOLA,
CONCAT(B.CD_ESCOLA,' ',B.SG_TP_ESCOLA,' ',NOMESC) AS NOVO_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6) AS DISTANCIA
INTO ##alunos_origem
FROM ##origem A, ##destino B
WHERE FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6)<=3000 -->LIMITA A DIST�NCIA M�XIMA

--SELECT * FROM ##alunos_origem

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
 --> TRATANDO OS DADOS DA TABELA GERADA ##alunos_origem LIMITANDO AT� 10 ESCOLAS MAIS PROXIMAS DOS SEUS ENDERRE�OS - cria-se a tabela ##alunos_origem10 QUE DEVE SER DIVULGADA.
  
 DROP TABLE ##alunos_origem10

SELECT TOP 0 *

             INTO ##alunos_origem10

             FROM ##alunos_origem   

CREATE INDEX INDEX_CD_ALUNO ON ##alunos_origem10 (CD_ALUNO)

 --select * from ##alunos_origem10

DROP TABLE ##alunos_origem_CD_ALUNO 

SELECT DISTINCT CD_ALUNO INTO ##alunos_origem_CD_ALUNO  FROM ##alunos_origem 

CREATE INDEX INDEX_CD_ALUNO ON ##alunos_origem_CD_ALUNO (CD_ALUNO)

 --select * from ##alunos_origem_CD_ALUNO

            

/*2. LER ORIGEM DADOS PROCESSADOS*/

    DECLARE @COUNT INT, @QTDEFILES INT

    SET @COUNT = 1

    SET @QTDEFILES = (SELECT COUNT(DISTINCT(CD_ALUNO)) FROM ##alunos_origem_CD_ALUNO)

 

    WHILE @COUNT <= @QTDEFILES

          BEGIN

 

                    DECLARE @CD_ALUNO INT

                    IF (SELECT MIN(CD_ALUNO) FROM ##alunos_origem_CD_ALUNO) > 0

 

      

                    SET @CD_ALUNO = (SELECT  MIN(CD_ALUNO) FROM ##alunos_origem_CD_ALUNO 

                                                      WHERE CD_ALUNO > ISNULL((SELECT MAX(CD_ALUNO) FROM ##alunos_origem10 ),0))

                           ELSE

                           SET @CD_ALUNO = (SELECT  MIN(CD_ALUNO) FROM ##alunos_origem_CD_ALUNO )

                          

                          

                    DROP TABLE ##alunos_origem_10 

                    SELECT TOP 10 * INTO ##alunos_origem_10  FROM ##alunos_origem --> OP��O PARA N�METO M�XIMO DE POSSIBILIDADES: NESTE CASO TOP 10. CADA MATRICULA TEM AT� 10 POSSIVEIS ENCAMINHAMENTOS

                    WHERE CD_ALUNO = @CD_ALUNO

                    ORDER BY CD_ALUNO, DISTANCIA; 

 

                    DELETE A FROM ##alunos_origem A WHERE CD_ALUNO = (SELECT MAX(CD_ALUNO) FROM ##alunos_origem_10)

                    DELETE A FROM ##alunos_origem_CD_ALUNO A WHERE CD_ALUNO = (SELECT MAX(CD_ALUNO) FROM ##alunos_origem_10 )

                    --TAMBEM � POSSIVEL FAZER ATRAVES DE BULK INSERT --HA MODELO NA PASTA SCRIPT PRODAM

                    --EXEC @SQL;

 

                    INSERT  ##alunos_origem10  SELECT * FROM ##alunos_origem_10 

                    --PRINT @NM_ARQUIVO_CSV

                SET @COUNT = @COUNT + 1

          END


--SELECT * FROM ##alunos_origem10