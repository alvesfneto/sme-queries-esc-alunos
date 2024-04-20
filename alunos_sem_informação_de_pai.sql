

select  
*
INTO ALUNOS_SEM_INFORMACAO_PAI
 from VW_ALUNOS_ORIGEM_RACA_IDADE WHERE nm_pai_aluno IS NULL

 --SELECT * FROM ALUNOS_SEM_INFORMACAO_PAI
------------------------------------------------------------------------------------------------------------------------------------------
/*
 DROP TABLE ##ALUNOS_SEM_INFORMACAO_PAI_CS
 SELECT DISTINCT 
 A.DRE,A.CD_ESCOLA, A.SG_TP_ESCOLA,A.NOMESC, B.SG_ETAPA, B.SG_SERIE_ENSINO,A.cd_aluno, A.nm_aluno, A.dt_nascimento_aluno, A.cd_sexo_aluno, A.dc_raca_cor,A.IDADE,A.nm_mae_aluno,A.nm_pai_aluno,A.DT_BASE
 INTO ##ALUNOS_SEM_INFORMACAO_PAI_CS
 FROM ALUNOS_SEM_INFORMACAO_PAI A
 JOIN SME_ALUNOS_DIARIO B ON A.cd_aluno=B.CD_ALUNO
 JOIN SME_ESCOLA_DIARIO C ON A.CD_ESCOLA=C.CD_ESCOLA
 WHERE A.DRE = 'DRE - CS' AND B.SG_ETAPA IS NOT NULL AND C.TP_ESCOLA IN (1,2,3,4,10,11,12,13,16,17,18,28,30,31)

 */