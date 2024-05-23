
/*Reenviamos  a solicitação do e-mail abaixo, de uma planilha do CEI Direto Pinheiros (400305), 
com o nome de todos os alunos matriculados por agrupamento constando o 
nome completo dos alunos, 
agrupamento, 
data de nascimento,  
nome da mãe, 
endereço, 
cep, .
contato telefônico
para estudo do Núcleo de Demanda.

Incluímos nesta solicitação, uma planilha do CEI Alegria do Saber II (309547),  
com o nome de todos os alunos matriculados por agrupamento constando o nome completo dos  
alunos, agrupamento, data de nascimento,  nome da mãe, endereço, cep, contato telefônico para estudo do Núcleo de Demanda.
*/

DROP TABLE ##alunos_escola_400305_309547_enderecos_contatos_responsaveis
SELECT 
DRE,
A.cd_escola AS CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
A.nm_aluno AS NOME_ALUNO,
C.SG_ETAPA,
C.SG_SERIE_ENSINO,
CONVERT(VARCHAR,C.DT_NASCIMENTO_ALUNO,103) AS DT_NASC,
C.NM_MAE_ALUNO,
A.ENDEREÇO,
A.NR,
A.COMPL,
A.BAIRRO,
A.CEP,
D.RESPONSÁVEL,
D.TEL_FIXO,
D.TEL_CELULAR,
D.EMAIL_RESPONSAVEL


INTO ##alunos_escola_400305_309547_enderecos_contatos_responsaveis

FROM VW_ALUNOS_ENDERECOS A
JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA 
JOIN SME_ALUNOS_DIARIO C ON A.COD_ALUNO=C.CD_ALUNO
JOIN VW_ALUNOS_RESPONSAVEIS D ON A.COD_ALUNO=D.COD_ALUNO
WHERE A.cd_escola in (400305,309547)

--SELECT * FROM ##alunos_escola_400305_309547_enderecos_contatos_responsaveis