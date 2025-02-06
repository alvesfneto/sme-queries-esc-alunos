/*Prezados, boa tarde!

Informamos que estamos em trâmites para abertura de novo licitatório envolvendo contratação de serviços para os CEUs.
Desta forma, solicitamos a gentileza de nos encaminhar código EOL dos 58 CEUs (CEU Gestão), conforme relação abaixo.
*/
DROP TABLE ##CEUS_CEUS_ATCOMPL
SELECT DISTINCT
TP_UNIDADE,
DRE,
CD_UNIDADE_EDUCACAO AS CD_ESCOLA,
SG_TP_ESCOLA AS TIPO,
NM_UNIDADE_EDUCACAO AS NOMESC,
UPPER(CONCAT(DC_TP_LOGRADOURO,' ',NM_LOGRADOURO,', ',NR,' - ',BAIRRO)) AS ENDERECO,
SITUACAO,
DT_BASE
INTO ##CEUS_CEUS_ATCOMPL
FROM [dbo].[vw_unidades_diretas_setores_internos_sme_dre_ceus] WHERE SG_TP_ESCOLA IN ('CEU','CEU AT COMPL')

--SELECT * FROM ##CEUS_CEUS_ATCOMPL
