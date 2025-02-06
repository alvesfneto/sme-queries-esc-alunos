/*Prezados, bom dia!

Por gentileza, podem nos enviar a rela��o das UEs municipalizadas em 2024 e 2025 
por DRE, atualizada? Precisamos dos dados para elabora��o de planejamento 
de forma��o com os docentes dessas UEs. Se poss�vel, constando os 
dados de atendimento (n�mero de turmas/estudantes por ano).

Grata, desde j�.

*/
EXEC GERA_MISME_DIARIO

DROP TABLE ##escolas_municipalizadas_com_turmas_matriculas

SELECT
C.ANO_MUNIC,
A.DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
D.ENDERECO,
D.NR,
D.BAIRRO,
D.CEP,
CL_FUND AS TURMAS,
MT_FUND AS MATR_FUND,
MT_F1 AS '1� ANO',
MT_F2 AS '2� ANO',
MT_F3 AS '3� ANO',
MT_F4 AS '4� ANO',
MT_F5 AS '5� ANO',
MT_F6 AS '6� ANO',
MT_F7 AS '7� ANO',
MT_F8 AS '8� ANO',
MT_F9 AS '9� ANO',
A.CRDATE
INTO ##escolas_municipalizadas_com_turmas_matriculas

 FROM D_MISME_ESCOLA_TOTAL A
 JOIN (SELECT 
       cd_unidade_educacao,
       dt_atualizacao_tabela,
       CASE WHEN dt_atualizacao_tabela<'2024-06-30' THEN '2024'
            WHEN dt_atualizacao_tabela>'2024-06-30' THEN '2025'
       ELSE NULL END AS ANO_MUNIC
       FROM D_HISTORICO_UNIDADE WHERE tp_ocorrencia_historica=1 AND CD_ato LIKE '%MUNIC%') C ON A.CD_ESCOLA=C.cd_unidade_educacao
JOIN SME_ESCOLA_DIARIO D ON  A.CD_ESCOLA=D.CD_ESCOLA
 GROUP BY
 C.ANO_MUNIC,
 A.DRE,
 A.CD_ESCOLA,
 A.SG_TP_ESCOLA,
 A.NOMESC,
 D.ENDERECO,
 D.NR,
 D.BAIRRO,
 D.CEP,
 MT_FUND,
 MT_F1,
 MT_F2,
 MT_F3,
 MT_F4,
 MT_F5,
 MT_F6,
 MT_F7,
 MT_F8,
 MT_F9,
 CL_F1,
 CL_F2,
 CL_F3,
 CL_F4,
 CL_F5,
 CL_F6,
 CL_F7,
 CL_F8,
 CL_F9,
 CL_FUND,
 A.CRDATE
 --select * from ##escolas_municipalizadas_com_turmas_matriculas
 ---------------------------------------------------------------------------------------------