﻿
/*

Solicitamos arquivo com todos os dados dos alunos, incluindo endereço completo com CEP e escolas próximas.

Motivo: fechamento da Unidade.      

309386 - CR.P.CONV - YVONNE BOTROS GOMES DOS SANTOS
*/

drop table ##alunos_unidade_309386_distancia_escolas_proximas_ate_1500M
SELECT 
A.DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOME_ESCOLA,
A.ETAPA,
A.SERIE_ANO,
A.CD_TURMA_ESCOLA,
A.COD_ALUNO,
A.NOME_ALUNO,
CONCAT(A.TP_LOGRADOURO,' ',A.ENDEREÇO) AS ENDEREÇO,
A.NR,
A.COMPL,
A.BAIRRO,
A.CEP,
CONCAT(B.CD_ESCOLA,' ',B.SG_TP_ESCOLA,' ',B.NOMESC) AS ESCOLA_PROXIMA,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (B.CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (B.CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6) AS DIST_ESCOLA_PROXIMA,
A.CRDATE AS DT_BASE

into ##alunos_unidade_309386_distancia_escolas_proximas_ate_1500M

FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR A, SME_ESCOLA_DIARIO B

WHERE 

A.CD_ESCOLA = 309386 AND B.CD_ESCOLA<>309386

AND B.TP_ESCOLA IN(10,11,12,18,28,31)
AND FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (B.CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO*1000000  - (B.CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6)<=1500

--SELECT * FROM ##alunos_unidade_309386_distancia_escolas_proximas_ate_1500M


 