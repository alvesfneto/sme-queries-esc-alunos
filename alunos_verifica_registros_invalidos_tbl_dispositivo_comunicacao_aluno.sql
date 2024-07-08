
DROP TABLE D_dispositivo_comunicacao_aluno
SELECT A.*, EXCLUIR_REGISTRO, GETDATE() AS CRDATE INTO D_dispositivo_comunicacao_aluno FROM 
DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] A

JOIN (
select 
B.AN_LETIVO,
A.cd_dispositivo_comunicacao_aluno,
A.dc_dispositivo,
A.dt_fim,


CASE WHEN DT_FIM IS NOT NULL THEN 'S'
     WHEN dc_dispositivo ='0' THEN 'S'
	 WHEN dc_dispositivo IS NULL THEN 'S' 
	 WHEN dc_dispositivo like '00%' THEN 'S'
	 WHEN len(dc_dispositivo)<8 THEN 'S'
ELSE NULL END AS 'EXCLUIR_REGISTRO'


from DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] A
JOIN DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].MATRICULA B ON A.CD_ALUNO=B.CD_ALUNO

WHERE B.an_letivo=YEAR(GETDATE()) AND B.cd_serie_ensino IS NOT NULL) B ON A.cd_dispositivo_comunicacao_aluno=B.cd_dispositivo_comunicacao_aluno

--SELECT * FROM D_dispositivo_comunicacao_aluno