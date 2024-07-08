/*
IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_tipo_dispositivo_comunicacao')
DROP TABLE D_tipo_dispositivo_comunicacao
SELECT *, GETDATE() AS CRDATE INTO D_tipo_dispositivo_comunicacao FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[tipo_dispositivo_comunicacao]
GO

*/

--drop table ##descartar
select cd_dispositivo_comunicacao_aluno,dc_dispositivo into ##descartar from DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] where dt_fim is not null
select cd_dispositivo_comunicacao_aluno,dc_dispositivo from DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] where dc_dispositivo ='0'
union
select cd_dispositivo_comunicacao_aluno,dc_dispositivo from DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] where dc_dispositivo like '00%'
union
select cd_dispositivo_comunicacao_aluno,dc_dispositivo from DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] where len(dc_dispositivo)<8

--select * from ##descartar

IF EXISTS 
	(SELECT 'TRUE' FROM SYSOBJECTS WHERE NAME = 'D_dispositivo_comunicacao_aluno')
DROP TABLE D_dispositivo_comunicacao_aluno
SELECT 
A.cd_dispositivo_comunicacao_aluno AS cd_dispositivo_comunicacao_aluno,
D.cd_dispositivo_comunicacao_aluno AS cd_dispositivo_comunicacao_aluno_descartados,
A.cd_aluno,
dc_tipo_dispositivo_comunicacao, 
cd_ddd, 
A.dc_dispositivo,
nm_contato,
in_autoriza_envio_sms,
tx_relacionamento_contato,
dc_responsavel_dispositivo_comunicacao, 
GETDATE() AS CRDATE 

INTO D_dispositivo_comunicacao_aluno

FROM DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[dispositivo_comunicacao_aluno] A
JOIN DB_EDUCACAO_1_PRODAM.se1426_ss.[dbo].[tipo_dispositivo_comunicacao] B ON A.tp_dispositivo_comunicacao=B.tp_dispositivo_comunicacao
JOIN tipo_responsavel_contato C ON A.tp_responsavel_dispositivo_comunicacao= C.tp_responsavel_dispositivo_comunicacao COLLATE SQL_Latin1_General_CP1_CI_AI
JOIN D_MATRICULA E ON A.cd_aluno=E.cd_aluno
left JOIN ##descartar D ON A.cd_dispositivo_comunicacao_aluno=D.cd_dispositivo_comunicacao_aluno 
where A.cd_dispositivo_comunicacao_aluno is not null AND E.an_letivo = 2024 and E.cd_tipo_programa is null

GO

--SELECT count(cd_aluno)  FROM D_dispositivo_comunicacao_aluno    12.980.491 registros

--SELECT  *   FROM D_dispositivo_comunicacao_aluno order by 3
--SELECT * FROM D_tipo_dispositivo_comunicacao


--select * from D_MATRICULA where an_letivo = 2024 and cd_tipo_programa is null







