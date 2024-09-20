--DROP VIEW VW_ESCOLAS_INF_GERAIS

CREATE VIEW VW_ESCOLAS_INF_GERAIS AS 

select 
ESCOLA AS CD_ESCOLA,
B.Sigla AS 'Muro de Fecho',
Area_Edificada AS '햞ea Edificada',
Area_Ocupada AS '햞ea Ocupada',
Area_Para_Ampli AS '햞ea p/Ampliar',
Area_Terreno as '햞ea do Terreno',
rua_pavimentada AS 'Rua Pavimentada',
rua_iluminada AS 'Rua Iluminada',
C.qt_arvore_escola AS 'Qtde_햞vores na Escola'
--Num_Pavimentos AS 'Num Pavimentos',
--Ano_Costrucao AS 'Ano Constru豫o'

from [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Escola_Inf_Gerais] A
JOIN [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Tabela_Tipo_Muro_Fecho] B ON A.muro_fecho=B.codigo
left JOIN (SELECT 
	  cd_unidade_educacao,
	  qt_arvore_escola 
	  FROM D_UNIDADE_EDUCACAO
	  WHERE tp_situacao_unidade=1) C ON A.ESCOLA=C.cd_unidade_educacao



