/*Bom dia

Considerando fechamento iminente do CEI VENHA CONOSCO II, pedimos relatório dos alunos matriculados com distância de 1000  metros lineares para transferência em lote. 

 No relatório deve constar

NOME DO ALUNO
EOL DO ALUNO
AGRUPAMENTO
TURMA 
ENDEREÇO (SEPARADO POR COLUNAS rua/bairro)
ESCOLA DESTINO A MENOS DE 1.000 METROS
DISTÂNCIA
*/

DROP TABLE ##alunos_origem
SELECT
CONCAT (A.cd_escola,' ',A.SG_TP_ESCOLA,' ',A.NOME_ESCOLA) AS ESCOLA_ORIGEM, 
NOME_ALUNO AS 'NOME DO ALUNO',
CONVERT(INT,COD_ALUNO)  AS CD_ALUNO,
A.ETAPA,
A.SERIE_ANO,
CONCAT (UPPER (TP_LOGRADOURO),' ',ENDEREÇO) AS ENDEREÇO,
A.NR AS NÚMERO,
A.COMPL AS COMPLEMENTO,
A.BAIRRO,
DIST_ESCOLA,
B.CD_ESCOLA AS COD_DESTINO,
B.SG_TP_ESCOLA AS TP_DESTINO,
B.NOMESC,
--CONCAT(B.CD_ESCOLA,' ',B.SG_TP_ESCOLA,' ',NOMESC) AS NOVO_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6) AS DISTANCIA

--TEG AS 'USO DO TEG'
INTO ##alunos_origem
FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS A, SME_ESCOLA_DIARIO B

WHERE A.cd_escola=306804  AND B.CD_ESCOLA<>306804

AND TP_ESCOLA IN (10,11,12,18,28,31) 
AND FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6)<5000
--SELECT * FROM ##alunos_origem
----------------------------------------------------------------------------------
 
  
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

                    SELECT TOP 10 * INTO ##alunos_origem_10  FROM ##alunos_origem 

                    WHERE CD_ALUNO = @CD_ALUNO

                    ORDER BY CD_ALUNO, DISTANCIA; 

 

                    DELETE A FROM ##alunos_origem A WHERE CD_ALUNO = (SELECT MAX(CD_ALUNO) FROM ##alunos_origem_10)

                    DELETE A FROM ##alunos_origem_CD_ALUNO A WHERE CD_ALUNO = (SELECT MAX(CD_ALUNO) FROM ##alunos_origem_10 )

                    --TAMBEM É POSSIVEL FAZER ATRAVES DE BULK INSERT --HA MODELO NA PASTA SCRIPT PRODAM

                    --EXEC @SQL;

 

                    INSERT  ##alunos_origem10  SELECT * FROM ##alunos_origem_10 

                    --PRINT @NM_ARQUIVO_CSV

                SET @COUNT = @COUNT + 1

          END


--SELECT * FROM ##alunos_origem10