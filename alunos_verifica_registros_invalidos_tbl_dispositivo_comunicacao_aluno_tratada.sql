


--DROP VIEW VW_DISPOSITIVOS_COMUNICACAO_ALUNO
CREATE VIEW VW_DISPOSITIVOS_COMUNICACAO_ALUNO AS
SELECT 
an_letivo AS AN_LETIVO,
A.cd_aluno AS CD_ALUNO,
cd_ddd AS DDD,
dc_dispositivo AS DC_DISPOSITIVO,

CASE WHEN tp_responsavel_dispositivo_comunicacao='A' THEN	'ALUNO(DADOS ANTIGOS)'
     WHEN tp_responsavel_dispositivo_comunicacao='C' THEN	'CONTATO DE RECADOS'
     WHEN tp_responsavel_dispositivo_comunicacao='I' THEN	'RELACIONADO AO ENDEREÇO INDICATIVO'
     WHEN tp_responsavel_dispositivo_comunicacao='M' THEN	'MÃE'
     WHEN tp_responsavel_dispositivo_comunicacao='P' THEN	'PAI'
     WHEN tp_responsavel_dispositivo_comunicacao='R' THEN	'RESPONSAVEL (DADO ANTIGO)'
ELSE NULL END AS CONTATO,
nm_contato AS NM_CONTATO,

CASE
    WHEN tp_dispositivo_comunicacao='1' THEN	'TELEFONE FIXO DE VOZ'
    WHEN tp_dispositivo_comunicacao='2' THEN	'PABX'      
    WHEN tp_dispositivo_comunicacao='3' THEN	'FAX'       
    WHEN tp_dispositivo_comunicacao='4' THEN	'RPE-PONTO' 
    WHEN tp_dispositivo_comunicacao='5' THEN	'EOL-DADOS' 
    WHEN tp_dispositivo_comunicacao='6' THEN	'PUBLICO'   
    WHEN tp_dispositivo_comunicacao='7' THEN	'CELULAR'   
    WHEN tp_dispositivo_comunicacao='8' THEN	'PARA SURDO'
    WHEN tp_dispositivo_comunicacao='9' THEN	'EMAIL'
    WHEN tp_dispositivo_comunicacao='10' THEN	'EMAIL ALERTA PARCERIAS'
    WHEN tp_dispositivo_comunicacao='11' THEN	'BLOG'
    WHEN tp_dispositivo_comunicacao='12' THEN	'EMAIL INSTITUCIONAL'
    WHEN tp_dispositivo_comunicacao='13' THEN	'CONTATO EMERGENCIA ESCOLA'
    WHEN tp_dispositivo_comunicacao='14' THEN	'CONTATO EMERGENCIA CASA'
ELSE NULL END AS TP_DISPOSITIVO_CONTATO,

CASE --WHEN DT_FIM IS NOT NULL THEN 'VERIFICAR' --> NA IMPORTAÇÃO DA TABELA D_dispositivo_comunicacao_aluno DIARIA JÁ TEM UMA TRAVA PARA REGISTROS DE DT_FIM IS NULL
     WHEN dc_dispositivo ='0' THEN 'VERIFICAR'
	 WHEN dc_dispositivo IS NULL THEN 'VERIFICAR' 
	 WHEN dc_dispositivo like '00%' THEN 'VERIFICAR'
	 WHEN len(dc_dispositivo)<8 THEN 'VERIFICAR'
ELSE 'OK' END AS 'OBSERVACAO',
CONVERT(DATE,A.CRDATE, 103) AS DT_BASE

FROM D_dispositivo_comunicacao_aluno A
JOIN D_MATRICULA B ON A.cd_aluno=B.cd_aluno
WHERE B.an_letivo = YEAR(GETDATE()) -->CONSIDERAR APENAS REGISTRO DE ALUNOS MATRICULADOS NO ANO CORRENTE
AND cd_tipo_programa IS NULL --> CONSIDERAR APENAS MATRICULAS DE ESCOLARIZACAO

--DROP TABLE ##dispositivos_conunicacao_alunos
SELECT DISTINCT
DRE,
C.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
B.CD_ALUNO,
NM_ALUNO,
A.DDD,
DC_DISPOSITIVO,
CONTATO,
NM_CONTATO,
TP_DISPOSITIVO_CONTATO,
OBSERVACAO,
DT_BASE
INTO ##dispositivos_conunicacao_alunos
FROM VW_DISPOSITIVOS_COMUNICACAO_ALUNO A
JOIN SME_ALUNOS_DIARIO B ON A.CD_ALUNO=B.CD_ALUNO
JOIN SME_ESCOLA_DIARIO C ON B.CD_ESCOLA=C.CD_ESCOLA
WHERE OBSERVACAO='OK'
--SELECT * FROM ##dispositivos_conunicacao_alunos

/*SELECT DISTINCT
DRE,
C.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
SG_ETAPA,
SG_SERIE_ENSINO,
B.CD_ALUNO,
NM_ALUNO,
A.DDD,
DC_DISPOSITIVO,
CONTATO,
NM_CONTATO,
TP_DISPOSITIVO_CONTATO,
OBSERVACAO,
DT_BASE

FROM VW_DISPOSITIVOS_COMUNICACAO_ALUNO A
JOIN SME_ALUNOS_DIARIO B ON A.CD_ALUNO=B.CD_ALUNO
JOIN SME_ESCOLA_DIARIO C ON B.CD_ESCOLA=C.CD_ESCOLA

WHERE OBSERVACAO<>'OK'
*/