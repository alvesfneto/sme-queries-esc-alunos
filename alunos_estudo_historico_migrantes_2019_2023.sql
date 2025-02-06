


DROP TABLE ##migrantes_2019_2023
SELECT DISTINCT
A.an_letivo,
A.cd_matricula,
A.dt_status_matricula,
A.st_matricula,
A.tp_matricula,
A.cd_escola,
A.cd_aluno,
A.cd_serie_ensino,
B.tp_raca_cor,
B.cd_pais_mec,	
C.nm_pais_mec	
into ##migrantes_2019_2023			
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA A
JOIN DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.aluno B ON A.CD_ALUNO=B.CD_ALUNO
JOIN DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.pais_mec C ON B.cd_pais_mec=C.cd_pais_mec
JOIN(select DISTINCT
	 year(dt_situacao_aluno) as ANO, 
	 cd_matricula,
	 cd_situacao_aluno 
	 from DB_EDUCACAO_1_PRODAM.SE1426_SS.DBO.HISTORICO_MATRICULA_TURMA_ESCOLA 
     WHERE cd_situacao_aluno in (1,5,6,10,13)
     AND 
     (dt_situacao_aluno between '2019-01-01' and '2019-05-31' or
      dt_situacao_aluno between '2020-01-01' and '2020-05-31' or
      dt_situacao_aluno between '2021-01-01' and '2021-05-31' or
      dt_situacao_aluno between '2022-01-01' and '2022-05-31' or
      dt_situacao_aluno between '2023-01-01' and '2023-05-31' )) D ON A.cd_matricula=D.cd_matricula
WHERE A.DT_STATUS_MATRICULA <='2023-05-31' AND A.ST_MATRICULA=1 AND A.CD_SERIE_ENSINO IS NOT NULL AND A.AN_LETIVO between 2019 and 2023 AND B.cd_pais_mec<>10
--SELECT * FROM ##migrantes_2019_2023 where cd_aluno = 6033327


					  SELECT
					  an_letivo,
                      cd_aluno,
                      COUNT (cd_aluno) AS QTDE
                      FROM 
                      ##migrantes_2019_2023
                      GROUP BY
                      cd_aluno,
					  an_letivo
                      HAVING (COUNT (cd_aluno)>1)
                      ORDER BY 1
					  