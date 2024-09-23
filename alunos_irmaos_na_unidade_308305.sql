/*
Seria poss�vel um arquivo com os alunos matriculados no CEI NOVA VIDA que possuam irm�os na mesma Unidade?
*/
DROP TABLE ##ALUNOS_IRMAOS_NA_UNIDADE_308305
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
M�E_ALUNO,
RESPONS�VEL,
A.CD_CPF_RESPONSAVEL
INTO ##ALUNOS_IRMAOS_NA_UNIDADE_308305
FROM [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS] A

JOIN (SELECT 
      CD_ESCOLA,
      CD_CPF_RESPONSAVEL, 
      COUNT(COD_ALUNO) AS ALUNOS
      FROM [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS]
      WHERE CD_ESCOLA=308305
      GROUP BY CD_ESCOLA,CD_CPF_RESPONSAVEL) B ON A.CD_CPF_RESPONSAVEL=B.CD_CPF_RESPONSAVEL
WHERE A.CD_ESCOLA=308305 AND B.ALUNOS>1
ORDER BY A.CD_CPF_RESPONSAVEL

--SELECT * FROM ##ALUNOS_IRMAOS_NA_UNIDADE_308305

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

--ALUNOS_IRM�OS_TODA_REDE
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
M�E_ALUNO,
RESPONS�VEL,
A.CD_CPF_RESPONSAVEL

FROM [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS] A

JOIN (SELECT 
      CD_ESCOLA,
      CD_CPF_RESPONSAVEL, 
      COUNT(distinct COD_ALUNO) AS ALUNOS
      FROM [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS]
      WHERE CD_CPF_RESPONSAVEL IS NOT NULL 
      GROUP BY CD_ESCOLA,CD_CPF_RESPONSAVEL) B ON A.CD_CPF_RESPONSAVEL=B.CD_CPF_RESPONSAVEL
WHERE B.ALUNOS>1
ORDER BY A.CD_CPF_RESPONSAVEL
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
