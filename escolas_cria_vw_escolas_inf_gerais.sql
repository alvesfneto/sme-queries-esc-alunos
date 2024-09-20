--DROP VIEW VW_ESCOLAS_INF_GERAIS

CREATE VIEW VW_ESCOLAS_INF_GERAIS AS 

select 
ESCOLA AS CD_ESCOLA,
B.Sigla AS 'Muro de Fecho',
Area_Edificada AS '�rea Edificada',
Area_Ocupada AS '�rea Ocupada',
Area_Para_Ampli AS '�rea p/Ampliar',
Area_Terreno as '�rea do Terreno',
rua_pavimentada AS 'Rua Pavimentada',
rua_iluminada AS 'Rua Iluminada',
C.qt_arvore_escola AS 'Qtde_�rvores na Escola'
--Num_Pavimentos AS 'Num Pavimentos',
--Ano_Costrucao AS 'Ano Constru��o'

from [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Escola_Inf_Gerais] A
JOIN [DB_EDUCACAO_1_PRODAM].[escola_ss].[dbo].[Tabela_Tipo_Muro_Fecho] B ON A.muro_fecho=B.codigo
left JOIN (SELECT 
	  cd_unidade_educacao,
	  qt_arvore_escola 
	  FROM D_UNIDADE_EDUCACAO
	  WHERE tp_situacao_unidade=1) C ON A.ESCOLA=C.cd_unidade_educacao



