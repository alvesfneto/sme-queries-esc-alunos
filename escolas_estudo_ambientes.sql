

DROP TABLE ##LISTA_AMBIENTES_ESCOLAS_TOTAL
SELECT 
      YEAR(dt_inicio) AS ANO_CADASTRO, 
      A.cd_escola,
      DRE,
      REDE,
      SG_TP_ESCOLA,
      NOMESC,
	  A.cd_ambiente_escola,
      A.tp_ambiente,
      C.dc_tipo_ambiente,
      cd_unidade_educacao_compartilhada,
      nr_sala,
      qt_ideal_pessoa,
      qt_real_pessoa,
      qt_area_util,
      A.dt_atualizacao_tabela,
      A.cd_operador,
      tp_construcao,
      in_utilizacao_sala_aula,
      in_ambiente_real,
      in_utilizacao_tic,
      dt_fim,
      cd_ambiente_escola_prodesp,
	  A.CRDATE
	  INTO ##LISTA_AMBIENTES_ESCOLAS_TOTAL
FROM D_AMBIENTE_ESCOLA A
JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA
JOIN D_TIPO_AMBIENTE C ON A.tp_ambiente=C.tp_ambiente
WHERE TP_ESCOLA IN (1,2,3,4,10,11,12,13,14,16,17,18,28,31,32,33) 
--SELECT * FROM ##LISTA_AMBIENTES_ESCOLAS_TOTAL

SELECT * FROM ##LISTA_AMBIENTES_ESCOLAS_TOTAL WHERE ANO_CADASTRO<2024 AND (dt_fim IS NULL OR dt_fim>'2023-12-31')--CRITÉRIO PARA SEPARAR OS AMBIENTES CRIADOS ATÉ DEZ/2023. 
																						   --SE EXTINÇÃO FOR DE 2024 ESTES AMBIENTES ESTAVAM ATIVAS ATÉ 31/12/2023


--SELECT DISTINCT ANO_CADASTRO FROM ##LISTA_AMBIENTES_ESCOLAS_TOTAL


  