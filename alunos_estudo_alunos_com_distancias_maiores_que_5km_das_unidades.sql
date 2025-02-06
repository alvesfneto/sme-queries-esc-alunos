/*
Entre os questionamentos do SEI em epígrafe precisamos responder os itens abaixo:
(c) quantos alunos percorrem mais do que 5km entre suas residências e as escolas? 
Apresentar justificativa para a existência de aluno percorrendo mais de 65km e
ntre sua residência e a escola, com esclarecimento do tempo de viagem, 
e dos demais alunos que percorram mais de 5km;

(d) indique, por meio do setor técnico competente (não a COGED), 
o índice de evasão e infrequência escolar relacionado à falta de TEG no Município;
*/


SELECT 
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
COD_ALUNO,
nm_aluno AS NM_ALUNO,
UPPER(CONCAT(TP_LOGRADOURO,' ',ENDEREÇO)) AS ENDERECO,
A.NR,
A.COMPL,
A.BAIRRO,
DIST_ESCOLA,
TEG

 FROM VW_ALUNOS_ENDERECOS A
 JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA
 
 WHERE DIST_ESCOLA>=5000 


 


