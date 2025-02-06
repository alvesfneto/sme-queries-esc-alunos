/*Prezados, boa tarde.

Por gentileza, enviar o estudo ponto a ponto dos endereços das crianças matriculadas na EMEI Patrícia Galvão - 091855 em relação os seguintes endereços:

Rua: São Domingos, 54 -23.552316277414835, -46.64281661888314

Rua: Gravataí, 54 -23.548472094926822, -46.64788975936927

Atenciosamente,

Fabiana Lemes
*/

DROP TABLE ##patricia_galvao
SELECT DISTINCT
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
--B.CD_ESCOLA AS COD_DESTINO,
--B.SG_TP_ESCOLA AS TP_DESTINO,
--B.NOMESC,

FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( -23.552316277414835 * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.64281661888314 * 1000000)),2)) / 10)/0.6) AS 'R São Domingos',

FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( -23.548472094926822 * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.64788975936927 * 1000000)),2)) / 10)/0.6)  AS 'R Gravataí'
--TEG AS 'USO DO TEG'
INTO ##patricia_galvao
FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS A, SME_ESCOLA_DIARIO B

WHERE A.cd_escola=091855  
--SELECT * FROM ##patricia_galvao
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