select 
DRE,
CD_UNIDADE_EDUCACAO AS CD_ESCOLA,
SG_TP_ESCOLA,
NM_UNIDADE_EDUCACAO AS NOMESC,
SITUACAO,
UPPER(CONCAT(DC_TP_LOGRADOURO,' ',NM_LOGRADOURO)) AS ENDERECO,
NR,
BAIRRO,
DISTRITO,
SUBPREF,
DT_BASE

from [dbo].[vw_unidades_diretas_setores_internos_sme_dre_ceus] where SG_TP_ESCOLA like '%ceu%'

SELECT 
DRE,
CEU,
CODESC,
TIPOESC,
NOMESC,
ENDERECO,
NUMERO,
BAIRRO,
DISTRITO,
SITUACAO,
NOME_ANT,
[DATABASE]



FROM [dbo].[VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL] WHERE CEU IS NOT NULL