/*
Para avaliação do processo de municipalização das 25 unidades escolares, 
estamos trabalhando em uma pesquisa através do atendimento 156, da 
SMIT- Secretaria Municipal de inovação e Tecnologia.
Para tanto, gostaríamos de requerer através deste, o 
banco de dados (nome e contato celular) dos 
pais/responsáveis das referidas unidades municipalizadas.
*/


DROP TABLE ##alunos_municipalizadas_com_responsaveis
SELECT DISTINCT
ANO_MUNIC,
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.CD_ALUNO,
A.NM_ALUNO,
A.CD_TURMA_ESCOLA,
SG_ETAPA,
A.SG_SERIE_ENSINO,
C.RESPONSÁVEL,
C.TEL_CELULAR,
C.TEL_FIXO,
C.EMAIL_RESPONSAVEL,
CONVERT(VARCHAR,A.CRDATE-1,103) AS DT_BASE
INTO ##alunos_municipalizadas_com_responsaveis
 FROM SME_ALUNOS_DIARIO A
JOIN (SELECT 
      ANO_MUNIC,
	  DRE,
	  CD_ESCOLA,
	  SG_TP_ESCOLA,
	  NOMESC 
	  FROM [dbo].[VW_ESCOLAS_MUNICIPALIZADAS_COM_TURMAS_MATRICUALS]) B ON A.cd_escola=B.CD_ESCOLA
JOIN (SELECT * 
      FROM [dbo].[VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS]) C ON A.CD_ALUNO=C.COD_ALUNO
WHERE SG_ETAPA IS NOT NULL
--SELECT * FROM ##alunos_municipalizadas_com_responsaveis