/*
Precisamos de um arquivo com os matriculados com idade de 0 a 3 anos que moram 
até 1,2km do endereço Avenida General Penha Brasil, 3300 (de todas unidades da RME).
*/
drop table ##alundos_ate_3_anos_distantes_ate_3km_cei_ziraldo
SELECT DISTINCT
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
CD_TURMA_ESCOLA
CD_ALUNO,
A.NM_ALUNO,
CONVERT(varchar,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
DATEDIFF(YY,DT_NASCIMENTO_ALUNO,GETDATE()) AS IDADE,
'CEI Ziraldo Alves Pinto - Avenida General Penha Brasil, 3300' AS DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.449296573631976 * 1000000) ),2) +  
                 POWER((LON_ALUNO*1000000  - (-46.68008860566761 * 1000000)),2)) / 10)/0.6) AS DIST_DESTINO
into ##alundos_ate_3_anos_distantes_ate_1200m_cei_ziraldo
FROM VW_ALUNOS_ENDERECOS A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN SME_ALUNOS_DIARIO C ON A.COD_ALUNO=C.CD_ALUNO

WHERE FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.449296573631976 * 1000000) ),2) +  
                 POWER((LON_ALUNO*1000000  - (-46.68008860566761 * 1000000)),2)) / 10)/0.6)<=1200
AND DATEDIFF(YY,DT_NASCIMENTO_ALUNO,GETDATE())<=3

--select * from ##alundos_ate_3_anos_distantes_ate_3km_cei_ziraldo
------------------------------------------------------------------------------------------------------------------
/*
Num segundo arquivo os matriculados na EMEI Arlindo Veiga dos Santos que 
moram até 1,2km do mesmo endereço: Avenida General Penha Brasil, 3300 

*/
drop table ##alunso_emei_arlindo_com_distancia_a_cei_ziraldo
SELECT DISTINCT
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
CD_TURMA_ESCOLA
CD_ALUNO,
A.NM_ALUNO,
CONVERT(varchar,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
DATEDIFF(YY,DT_NASCIMENTO_ALUNO,GETDATE()) AS IDADE,
'CEI Ziraldo Alves Pinto - Avenida General Penha Brasil, 3300' AS DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.449296573631976 * 1000000) ),2) +  
                 POWER((LON_ALUNO*1000000  - (-46.68008860566761 * 1000000)),2)) / 10)/0.6) AS DIST_DESTINO
into ##alunso_emei_arlindo_com_distancia_a_cei_ziraldo
FROM VW_ALUNOS_ENDERECOS A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN SME_ALUNOS_DIARIO C ON A.COD_ALUNO=C.CD_ALUNO

WHERE 
A.CD_ESCOLA=098957 

--AND
--FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO*1000000 - (-23.449296573631976 * 1000000) ),2) +  
--                POWER((LON_ALUNO*1000000  - (-46.68008860566761 * 1000000)),2)) / 10)/0.6) <=1200
select * from ##alunso_emei_arlindo_com_distancia_a_cei_ziraldo