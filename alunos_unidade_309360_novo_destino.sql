
/*
Solicitamos estudo de ponto a ponto das crian�as do CEI Abra�ar para o endere�o:
Rua Dom Manuel de Andrade, 222 
Vila Gumercindo 
CEP 04134-040
(-23.60511072915534, -46.62550772263756)
*/

----select * from [dbo].[VW_ALUNOS_ENDERECOS_DISTRITO_SETOR] where CD_ESCOLA=309360

select * from SME_ESCOLA_DIARIO where NOMESC like '%abracar%'

DROP TABLE ##ALUNOS_UNIDADE_309360_NOVO_DESTINO
SELECT 
nm_aluno AS 'NOME DO ALUNO',
COD_ALUNO AS 'EOL DO ALUNO',
CONCAT (UPPER (TP_LOGRADOURO),' ',ENDERE�O) AS ENDERE�O,
NR AS N�MERO,
COMPL AS COMPLEMENTO,
BAIRRO,
DIST_ESCOLA AS 'DIST�NCIA ESCOLA',
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - (-23.60511072915534  * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (-46.62550772263756 * 1000000)),2)) / 10)/0.6) AS 'DIST Rua Dom Manuel de Andrade, 222',

TEG AS 'USO DO TEG'
INTO ##ALUNOS_UNIDADE_309360_NOVO_DESTINO
FROM VW_ALUNOS_ENDERECOS A
LEFT JOIN (SELECT 
	       CD_ESCOLA,
		   CD_ALUNO,
		   TEG FROM ALUNOS_COM_TEG WHERE CD_ESCOLA=019536) B ON A.COD_ALUNO=B.CD_ALUNO
WHERE A.cd_escola=309360

--SELECT * FROM ##ALUNOS_UNIDADE_309360_NOVO_DESTINO
