
/*
Prezados (as), bom dia!
Precisamos de uma lista de todas as nossas Unidades Educacionais que t�m EJA, 
das 25 unidades que foram municipalizadas neste ano e 
das 25 unidades que ser�o municipalizadas no ano de 2025.

*/
EXEC GERA_MISME_DIARIO
drop table ##escolas_com_eja
SELECT 
A.DRE,
A.CD_ESCOLA,
A.SG_TP_ESCOLA,
A.NOMESC,
B.ENDERECO,
B.NR,
B.BAIRRO,
B.CEP,
A.MT_EJA AS MATR_EJA,
A.CL_EJA AS TURMAS_EJA,
A.CRDATE AS DT_BASE
INTO ##escolas_com_eja
FROM D_MISME_ESCOLA_TOTAL A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE MT_EJA >0
--select * from ##escolas_com_eja 

--------------------------------------------------------
drop table ##escolas_municipalizadas_2024_2025_com_turmas_matriculas
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

INTO ##escolas_municipalizadas_2024_2025_com_turmas_matriculas

 FROM D_MISME_ESCOLA_TOTAL A
 --JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
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
 CL_FUND,
 A.CRDATE

 --select * from ##escolas_municipalizadas_2024_2025_com_turmas_matriculas