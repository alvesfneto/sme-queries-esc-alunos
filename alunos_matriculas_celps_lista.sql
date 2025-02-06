
/*Para informar os dados referentes a meta 27 para a UPGE precisamos de dados complementares. 
Gostaríamos se solicitar uma planilha com todas as turmas de CELP abertas neste 
segundo semestre com o descritivo de todos os estudantes neles matriculados.

Sendo assim, necessitamos:
DRE;
EOL do CEU ou do CEU POLO;
Nome CEU ou CEU POLO;
Cod  turm escola
Componente Curricular;
nome de cada estudante matriculado
série/ano a qual o estudante faz parte na rede.
*/

DROP TABLE ##alunos_matriculas_celps_lista
SELECT 
DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
CONVERT(VARCHAR,DT_INICIO_TURMA,103) AS DT_INICIO_TUR_CELP,
A.CD_TURMA_ESCOLA AS CD_TURMA_CELP,
C.dc_tipo_programa AS TURMA_CELP,
D.CD_TURMA_ESCOLA AS TURMA_ESCOLARIZACAO,
D.SG_ETAPA,
D.SG_SERIE_ENSINO,
A.CD_ALUNO,
A.NM_ALUNO


--INTO ##alunos_matriculas_celps_lista

FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA 
JOIN (SELECT * FROM D_TIPO_PROGRAMA 
      WHERE sg_tipo_programa LIKE 'CELP%'AND dt_cancelamento IS NULL ) C ON A.CD_TIPO_PROGRAMA=C.CD_TIPO_PROGRAMA
JOIN (SELECT 
      CD_ALUNO,SG_ETAPA,
      SG_SERIE_ENSINO, 
	  CD_TURMA_ESCOLA FROM SME_ALUNOS_DIARIO WHERE SG_ETAPA IS NOT NULL) D ON A.CD_ALUNO=D.CD_ALUNO
JOIN (SELECT 
      CD_TURMA_ESCOLA,
      DT_INICIO_TURMA FROM SME_CLASSES_DIARIO A
	  JOIN D_TIPO_PROGRAMA B ON A.CD_TIPO_PROGRAMA=B.cd_tipo_programa
	  WHERE DC_TIPO_PROGRAMA LIKE 'CELP%' AND DT_INICIO_TURMA>='2024-07-01') E ON A.CD_TURMA_ESCOLA=E.CD_TURMA_ESCOLA


--SELECT * FROM ##alunos_matriculas_celps_lista

--select * from SME_CLASSES_DIARIO