
/*
Considerando as matrículas dos CCAs digitadas no sistema EOL, 
solicito cruzamento das informações de 08 CCAs (abaixo identificados) 
com as matrículas nas EMEFs, organizando arquivo nominal 
com a informação da matrícula do CCA e da EMEF.

nome do estudante
data de nascimento 
código eol
DRE do CCA de matrícula
nome do CCA de matrícula
turno CCA
DRE da EMEF de matrícula
nome da EMEF de matrícula
turno EMEF

Ressalto que os dados serão posteriormente 
cruzados com o SGP, portanto, 
caso entendam necessária a inserção de outros dados que 
auxiliem nessa identificação, por favor, incluam.


DRE - BT 200270 CCA  LIGA SOLIDARIA - UNIDADE SABIA
DRE - CL 200348 CCA  OBRA DO BECO - NOSSA VIDA NOSSA ARTE
DRE - BT 200381 CCA  ASA PRIMAVERA
DRE - BT 200400 CCA  RECANTO DOS PASSAROS
DRE - BT 200403 CCA  INSTITUTO ANA ROSA
DRE - BT 200415 CCA  RECANTO SANTA MONICA
DRE - BT 200904 CCA  LIGA SOLIDARIA
DRE - BT 200905 CCA  BEIJA-FLOR
*/

SELECT 
B.DRE,
A.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
NM_ALUNO,
CONVERT(DATE,DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
A.CD_ALUNO,
A.CD_TURMA_ESCOLA AS TURMA_CCA,
C.dc_tipo_turno AS TURNO_CCA
INTO ##LISTA_ALUNOS_CCA
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
JOIN (SELECT 
      CD_TURMA_ESCOLA,
      B.dc_tipo_turno
      FROM SME_CLASSES_DIARIO A
      JOIN tipo_turno B ON A.CD_TIPO_TURNO=B.cd_tipo_turno
      WHERE CD_ESCOLA IN (200270,200348,200381,200400,200403,200415,200904,200905)) C ON A.CD_TURMA_ESCOLA=C.CD_TURMA_ESCOLA
WHERE A.CD_ESCOLA IN (200270,200348,200381,200400,200403,200415,200904,200905)

--SELECT * FROM ##LISTA_ALUNOS_CCA


DROP TABLE ##alunos_cca_matriculas_escolarizacao
SELECT DISTINCT
C.*,
A.DRE AS DRE_EMEF,
--A.CD_ESCOLA,
CONCAT (A.SG_TP_ESCOLA,'',A.NOMESC) AS UNIDADE_MATRICULA,
B.SG_ETAPA,
B.SG_SERIE_ENSINO,
B.CD_TURMA_ESCOLA AS TURMA_EMEF,
B.dc_tipo_turno AS TURNO_EMEF
INTO ##alunos_cca_matriculas_escolarizacao
FROM SME_ESCOLA_DIARIO A

JOIN (SELECT 
      A.CD_ESCOLA,
      CD_ALUNO,
	  A.SG_ETAPA,
	  A.SG_SERIE_ENSINO,
      A.CD_TURMA_ESCOLA,
      C.dc_tipo_turno
      FROM SME_ALUNOS_DIARIO A
      JOIN SME_CLASSES_DIARIO B ON A.CD_TURMA_ESCOLA=B.CD_TURMA_ESCOLA
      JOIN tipo_turno C ON B.CD_TIPO_TURNO=C.cd_tipo_turno
      WHERE A.CD_ETAPA_ENSINO IN (5,13)) B ON A.CD_ESCOLA=B.CD_ESCOLA
RIGHT JOIN ##LISTA_ALUNOS_CCA C ON B.CD_ALUNO=C.CD_ALUNO
--SELECT * FROM##alunos_cca_matriculas_escolarizacao


