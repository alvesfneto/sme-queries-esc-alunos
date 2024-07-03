/*
Visando o in�cio do planejamento de salas para o ano letivo de 2025, solicitamos os 
bons pr�stimos de encaminhar uma planilha contendo 
c�digo eol , 
nome completo, 
data de nascimento, 
filia��o 1 e 
endere�o completo e
ducandos matriculados nos 
1�'s aos 8�'s anos da 
EMEF Theodomiro Monteiro do Amaral (EOL 087319) e dos educandos de 
5�'s anos das EMEF M
aria Berenice dos Santos (EOL019712 ) e 
C�sar Y�zigi (EOL 019717).
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
M�E_ALUNO AS 'FILIA��O 1',
CONCAT(TP_LOGRADOURO,' ',ENDERE�O)AS ENDERECO,
NR,
COMPL,
BAIRRO,
CRDATE AS DT_BASE

INTO ##alunos_ues_087319_019712_019717_fund

FROM VW_ENDERECOS_ALUNOS_COM_RESPONSAVEIS

WHERE 
(CD_ESCOLA =087319 AND SERIE_ANO IN ('1� ANO','2� ANO','3� ANO','4� ANO','5� ANO','6� ANO','7� ANO','8� ANO'))
OR
(CD_ESCOLA IN (019712, 019717) AND SERIE_ANO = '5� ANO')
ORDER BY CD_ESCOLA
--SELECT * FROM ##alunos_ues_087319_019712_019717_fund
