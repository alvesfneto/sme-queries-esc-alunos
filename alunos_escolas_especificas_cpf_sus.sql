/*
Estamos finalizando o atendimento oftalmológico das 4 UE da DRE Santo Amaro em 2024 e em 2025 continuaremos com as demais.
No entanto, solicitamos por gentileza a relação dos estudantes por turma, ano, nome completo, RA, data de nascimento, cartão SUS e CPF.
Segue a relação das UEs:
EMEF Min. Calógeras                     -->095206
EMEF Profª Maria Alves Benetti          -->019419
EMEF Profª Amélia Rodrigues de Oliveira -->019465
EMEF João Sussumu Hirata, Dep.			-->093254
*/
--select * from sme_escola_diario where nomesc like '%HIRATA%'

DROP TABLE alunos_sus
SELECT * 
INTO alunos_sus 
FROM [DB_EDUCACAO_1_PRODAM].[SE1426].DBO.v_aluno_codigo_sus
--SELECT * FROM alunos_sus


DROP TABLE ##alunos_escolas_especificas_cpf_sus
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
RA,
A.CD_ALUNO,
A.NM_ALUNO,
CONVERT(VARCHAR,A.DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
C.cd_cpf_aluno AS CPF,
D.nr_cns AS SUS,
CONVERT(VARCHAR,A.CRDATE,103) AS DT_BASE
INTO ##alunos_escolas_especificas_cpf_sus
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN D_ALUNO C ON A.CD_ALUNO=C.cd_aluno
JOIN alunos_sus D ON A.CD_ALUNO=D.CD_ALUNO
WHERE A.CD_ESCOLA IN (095206,019419,019465,093254) AND SG_ETAPA IS NOT NULL


--SELECT * FROM ##alunos_escolas_especificas_cpf_sus