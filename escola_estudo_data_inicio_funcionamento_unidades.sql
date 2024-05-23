/*Pesquisa de datas de criação de turmas para consolidar data de inicio de funcionamento das unidades*/

SELECT --[cd_turma_escola]
      --,[cd_tipo_periodicidade]
       [an_letivo]
      ,[cd_escola]
	  ,[cd_turma_escola]
      ,[dc_turma_escola]
      --,[cd_ambiente_escola]
      --,[cd_tipo_atendimento]
      --,[cd_tipo_turma]
      --,[cd_tipo_programa]
      --,[qt_vaga_oferecida]
      ,[st_turma_escola]
      --,[ho_entrada]
      --,[ho_saida]
      ,[dt_inicio_turma]
      ,[dt_fim_turma]
      --,[dt_inicio]
      --,[dt_fim]
     --,[dt_atualizacao_tabela]
     --,[cd_operador]
      ,[cd_tipo_turno]
      ,[cd_duracao]
      --cd_correspondencia_serie]
      --,[dt_status_turma_escola]
      --,[cd_turma_prodesp]
      --,[cd_tipo_turno_texto]
  FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[turma_escola]

  WHERE CD_ESCOLA= 019227 AND CD_TIPO_PROGRAMA IS NULL ORDER BY DT_INICIO_TURMA
GO


------------------------------------------------------------------------------
SELECT DISTINCT
        A.[CD_ESCOLA]
	   ,MIN([dt_inicio_turma]) AS PRIMEIRA_TURMA
      
  FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[turma_escola] A
  JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
  WHERE CD_TIPO_PROGRAMA IS NULL AND CD_SIT=1
  GROUP BY
  
 A.[CD_ESCOLA]


 ORDER BY 2
