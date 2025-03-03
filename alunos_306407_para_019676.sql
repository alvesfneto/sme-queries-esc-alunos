/*Boa tarde!

Solicitamos o estudo ponto a ponto dos alunos de MGII matriculados na CR.P.CONV. Cora��o de Jesus - 306407 em rela��o ao EMEI P FOM Liceu - 019676
*/
drop table ##alunos_306407_PARA_019676
SELECT
CONCAT (cd_escola,' ',SG_TP_ESCOLA,' ',NOME_ESCOLA) AS ESCOLA_ORIGEM, 
NOME_ALUNO AS 'NOME DO ALUNO',
CONVERT(INT,COD_ALUNO)  AS CD_ALUNO,
ETAPA,
SERIE_ANO,
CONCAT (UPPER (TP_LOGRADOURO),' ',ENDERE�O) AS ENDERE�O,
NR AS N�MERO,
COMPL AS COMPLEMENTO,
BAIRRO,
DIST_ESCOLA,
'EMEI P FOM LICEU' AS NOVO_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( -23.532075 * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.643230 * 1000000)),2)) / 10)/0.6) AS DISTANCIA

--TEG AS 'USO DO TEG'
INTO ##alunos_306407_PARA_019676
FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS
WHERE CD_ESCOLA= 306407

--select * from ##alunos_306407_PARA_019676
--SELECT CD_ESCOLA, CD_COORDENADA_GEO_Y,CD_COORDENADA_GEO_X FROM SME_ESCOLA_DIARIO WHERE CD_ESCOLA = 019676