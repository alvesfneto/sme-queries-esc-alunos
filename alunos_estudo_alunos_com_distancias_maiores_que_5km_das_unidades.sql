/*
Entre os questionamentos do SEI em ep�grafe precisamos responder os itens abaixo:
(c) quantos alunos percorrem mais do que 5km entre suas resid�ncias e as escolas? 
Apresentar justificativa para a exist�ncia de aluno percorrendo mais de 65km e
ntre sua resid�ncia e a escola, com esclarecimento do tempo de viagem, 
e dos demais alunos que percorram mais de 5km;

(d) indique, por meio do setor t�cnico competente (n�o a COGED), 
o �ndice de evas�o e infrequ�ncia escolar relacionado � falta de TEG no Munic�pio;
*/


SELECT 
DRE,
B.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
COD_ALUNO,
nm_aluno AS NM_ALUNO,
UPPER(CONCAT(TP_LOGRADOURO,' ',ENDERE�O)) AS ENDERECO,
A.NR,
A.COMPL,
A.BAIRRO,
DIST_ESCOLA,
TEG

 FROM VW_ALUNOS_ENDERECOS A
 JOIN SME_ESCOLA_DIARIO B ON A.cd_escola=B.CD_ESCOLA
 
 WHERE DIST_ESCOLA>=5000 


 


