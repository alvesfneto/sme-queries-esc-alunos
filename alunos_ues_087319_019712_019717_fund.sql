/*
Visando o início do planejamento de salas para o ano letivo de 2025, solicitamos os 
bons préstimos de encaminhar uma planilha contendo 
código eol , 
nome completo, 
data de nascimento, 
filiação 1 e 
endereço completo e
ducandos matriculados nos 
1º's aos 8º's anos da 
EMEF Theodomiro Monteiro do Amaral (EOL 087319) e dos educandos de 
5º's anos das EMEF M
aria Berenice dos Santos (EOL019712 ) e 
César Yázigi (EOL 019717).
*/

drop table ##alunos_ues_087319_019712_019717_fund
SELECT 
DRE,
CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
CONVERT(DATE,DT_NASCIMENTO_ALUNO,103) AS DT_NASCIMENTO,
MÃE_ALUNO AS 'FILIAÇÃO 1',
CONCAT(TP_LOGRADOURO,' ',ENDEREÇO)AS ENDERECO,
NR,
COMPL,
BAIRRO,
CRDATE AS DT_BASE

INTO ##alunos_ues_087319_019712_019717_fund

FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS

WHERE 
(CD_ESCOLA =087319 AND SERIE_ANO IN ('1º ANO','2º ANO','3º ANO','4º ANO','5º ANO','6º ANO','7º ANO','8º ANO'))
OR
(CD_ESCOLA IN (019712, 019717) AND SERIE_ANO = '5º ANO')
ORDER BY CD_ESCOLA
--SELECT * FROM ##alunos_ues_087319_019712_019717_fund
