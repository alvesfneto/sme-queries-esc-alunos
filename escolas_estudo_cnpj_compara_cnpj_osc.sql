
select distinct
C.DRE,
C.SG_TP_ESCOLA,
C.NOMESC,
A.cd_escola,
--A.cd_cnpj_entidade_executora, 
FORMAT( A.cd_cnpj_entidade_executora, '00000000000000') as CNPJ_EOL,
B.CNPJ_OSC
FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[escola] A
JOIN (SELECT 
	  cd_escola,	
	  A.cd_instituicao,
	  cd_cnpj AS CNPJ_OSC 
	  FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[INSTITUICAO] A
	  JOIN DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[convenio_creche_escola] B ON A.cd_instituicao=B.cd_instituicao
	  WHERE cd_situacao_instituicao = 1 AND dt_cancelamento is null AND cd_situacao_convenio=2) B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN SME_ESCOLA_DIARIO C ON A.cd_escola=C.CD_ESCOLA
WHERE LEFT(CNPJ_OSC,8)<>LEFT(FORMAT( A.cd_cnpj_entidade_executora, '00000000000000'),8)

AND A.tp_escola IN (11,12) AND C.CD_SIT=1 ORDER BY 1,4


--SELECT * FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[INSTITUICAO] WHERE CD_SITUACAO_INSTITUICAO=1
--SELECT * FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[convenio_creche_escola] WHERE CD_SITUACAO_CONVENIO=2
--SELECT * FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[situacao_convenio]
--SELECT * FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[situacao_instituicao]

/*cd_situacao_convenio
       1	Em Análise
       2	Aprovado
       3	Reprovado
       4	Encerrado
       5	Análise de SME
cd_situacao_instituicao
       1	Apto
       2	Não apto
       3	Em análise
*/

select distinct
C.DRE,
C.SG_TP_ESCOLA,
C.NOMESC,
A.cd_escola,
--A.cd_cnpj_entidade_executora, 
FORMAT( A.cd_cnpj_entidade_executora, '00000000000000') as CNPJ_EOL,
B.CNPJ_OSC
FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[escola] A
JOIN (SELECT 
	  cd_escola,	
	  A.cd_instituicao,
	  cd_cnpj AS CNPJ_OSC 
	  FROM DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[INSTITUICAO] A
	  JOIN DB_EDUCACAO_1_PRODAM.SE1426.[dbo].[convenio_creche_escola] B ON A.cd_instituicao=B.cd_instituicao
	  WHERE cd_situacao_instituicao = 1 AND dt_cancelamento is null AND cd_situacao_convenio=2) B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN SME_ESCOLA_DIARIO C ON A.cd_escola=C.CD_ESCOLA
WHERE (LEFT(CNPJ_OSC,8)=LEFT(FORMAT( A.cd_cnpj_entidade_executora, '00000000000000'),8) AND

RIGHT(CNPJ_OSC,6)<>RIGHT(FORMAT( A.cd_cnpj_entidade_executora, '00000000000000'),6))

AND A.tp_escola IN (11,12) AND C.CD_SIT=1 ORDER BY 1,4
