--DROP VIEW VW_ESCOLAS_INF_GERAIS

CREATE VIEW VW_ESCOLAS_INF_GERAIS AS 

select 
CD_ESCOLA,
B.Sigla AS 'Muro de Fecho',
qt_area_edificada AS '햞ea Edificada',
qt_area_ocupada AS '햞ea Ocupada',
area_para_ampli AS '햞ea p/Ampliar',
qt_area_total as '햞ea do Terreno',
in_rua_pavimentada AS 'Rua Pavimentada',
in_rua_iluminada AS 'Rua Iluminada',
C.qt_arvore_escola AS 'Qtde_햞vores na Escola'
--qt_pavimento AS 'Num Pavimentos',
--Ano_Costrucao AS 'Ano Constru豫o'

from [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[escola] A
JOIN [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Tabela_Tipo_Muro_Fecho] B ON A.tp_muro_fecho=B.codigo
LEFT JOIN (SELECT 
	  cd_unidade_educacao,
	  qt_arvore_escola 
	  FROM D_UNIDADE_EDUCACAO
	  WHERE tp_situacao_unidade=1) C ON A.cd_escola=C.cd_unidade_educacao

LEFT JOIN (SELECT 
      ESCOLA,
      Area_Para_Ampli
	  
      FROM [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Escola_Inf_Gerais]) D ON A.CD_ESCOLA=D.ESCOLA



--SELECT * FROM VW_ESCOLAS_INF_GERAIS

--SELECT * FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[escola]
--select * FROM D_UNIDADE_EDUCACAO
--
--SELECT * FROM [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Escola_Inf_Gerais]



