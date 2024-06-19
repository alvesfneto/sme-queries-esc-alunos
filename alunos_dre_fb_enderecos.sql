
DROP TABLE ##ALUNOS_FB_ENDERECOS
SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
ETAPA,
SERIE_ANO,
A.CD_TURMA_ESCOLA AS TURMA,
dc_tipo_turno AS TURNO,
COD_ALUNO,
NOME_ALUNO,
TP_LOGRADOURO,
ENDEREÇO,
NR,
COMPL,
BAIRRO,
CEP,
CRDATE

INTO ##ALUNOS_FB_ENDERECOS

FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR A

JOIN (select DISTINCT A.CD_TURMA_ESCOLA, B.CD_TIPO_TURNO,C.dc_tipo_turno 
      from SME_ALUNOS_DIARIO A
      JOIN SME_CLASSES_DIARIO B ON A.CD_TURMA_ESCOLA=B.CD_TURMA_ESCOLA
      JOIN tipo_turno C ON B.CD_TIPO_TURNO=C.cd_tipo_turno) B ON A.CD_TURMA_ESCOLA=B.CD_TURMA_ESCOLA
 WHERE DRE = 'DRE - FB'

--SELECT * FROM ##ALUNOS_FB_ENDERECOS



/*O arquivo encaminhado indica que são alunos já atendidos pelo TEG, o que precisamos é de todas as UES e matriculados para analisar o atendimento das matriculas.
Precisamos no arquivo:

Unidade de matricula
Nome do aluno 
Turma da matricula 
Turno
Endereço completo

*/

select top 5 * from VW_ALUNOS_ENDERECOS_DISTRITO_SETOR