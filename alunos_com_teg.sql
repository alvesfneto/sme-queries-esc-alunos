--O ALUNO TEM QUE ESTAR DENTRO DA VIAGEM PARA SER CONSIDERADO TRANSPORTADO
DROP TABLE ##ALUNO_CLASSIFICADO_TRANSPORTE
      SELECT ACT.* INTO ##ALUNO_CLASSIFICADO_TRANSPORTE FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[ALUNO_CLASSIFICADO_TRANSPORTE] ACT
      JOIN DB_EDUCACAO_1_PRODAM.SE1426_ss.dbo.veiculo_viagem_aluno VVA ON ACT.CD_ALUNO_CLASSIFICADO_TRANSPORTE = VVA.CD_ALUNO_CLASSIFICADO_TRANSPORTE
      WHERE VVA.DT_FIM IS NULL  

-----------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE ##ALUNO_CANDIDATO_TRANSPORTE
      SELECT ACT.* 
INTO ##ALUNO_CANDIDATO_TRANSPORTE 
FROM DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].[ALUNO_CANDIDATO_TRANSPORTE] ACT
WHERE AN_LETIVO = YEAR(GETDATE())
--SELECT * FROM ##ALUNO_CANDIDATO_TRANSPORTE 

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/ 

DROP TABLE ALUNOS_COM_TEG
SELECT  
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.SG_ETAPA,
A.SG_SERIE_ENSINO,
A.CD_ALUNO,
C.qt_distancia AS DIST_ESCOLA,

CASE WHEN C.qt_distancia <= 1500 THEN 'Até 1,5 km'
	 WHEN C.qt_distancia BETWEEN 1501 AND 2000 THEN '1,5 a 2 km' 
     WHEN C.qt_distancia BETWEEN 2001 AND 3000 THEN '2 a 3 km'   
     WHEN C.qt_distancia BETWEEN 3001 AND 4000 THEN '3 a 4 km'   
     WHEN C.qt_distancia BETWEEN 4001 AND 5000 THEN '4 a 5 km'   
     WHEN C.qt_distancia BETWEEN 5001 AND 6000 THEN '5 a 6 km'   
     WHEN C.qt_distancia >6000 THEN 'Mais que 6 km' ELSE NULL END AS FAIXA,
TEG = CASE WHEN EXISTS (
                                          SELECT * FROM ##ALUNO_CLASSIFICADO_TRANSPORTE ACT
                                          WHERE A.CD_MATRICULA = ACT.CD_MATRICULA AND DT_FIM IS NULL
                                          ) THEN      'SIM' ELSE 'NAO' END,
TEG_BARREIRA = CASE WHEN EXISTS (
                                         SELECT * FROM ##ALUNO_CLASSIFICADO_TRANSPORTE ACT
                                         JOIN ##ALUNO_CANDIDATO_TRANSPORTE ACCT ON ACCT.CD_MATRICULA = ACT.CD_MATRICULA AND CD_MOTIVO_TRANSPORTE = 4


                                        WHERE  ACT.CD_MATRICULA = A.CD_MATRICULA  
                                         ) THEN      'SIM' ELSE 'NAO' END,
                                                                                 
R.DC_MOTIVO_TRANSPORTE



-----------------------------------------------------------------------------------------------------------------------------------------------------------
INTO ALUNOS_COM_TEG

FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_MATRICULA C ON A.CD_MATRICULA = C.CD_MATRICULA
LEFT JOIN ##ALUNO_CANDIDATO_TRANSPORTE Q  ON A.CD_MATRICULA = Q.CD_MATRICULA
LEFT JOIN DB_EDUCACAO_1_PRODAM.SE1426_SS.[DBO].motivo_transporte R on Q.cd_MOTIVO_TRANSPORTE = R.CD_MOTIVO_TRANSPORTE

WHERE 
 EXISTS (
                                          SELECT * FROM ##ALUNO_CLASSIFICADO_TRANSPORTE ACT
                                          WHERE A.CD_MATRICULA = ACT.CD_MATRICULA AND DT_FIM IS NULL
                                          )


--SELECT * FROM ALUNOS_COM_TEG