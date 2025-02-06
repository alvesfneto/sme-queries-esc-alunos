/*Prezados, bom dia.

Por gentileza, enviar o estudo ponto a ponto 

dos endereços das crianças matriculadas na EMEI Patrícia Galvão - 091855 
em relação as seguintes unidades:

EMEI Alberto de Oliveira - 091839
EMEI Ângelo Martino - 091847
EMEI Alceu Maynard - 091898
EMEI Armando de Arruda - 091871
EMEI Ana Rosa de Araujo - 092410
EMEI Antônio Figueiredo Amaral - 017736
EMEI Feijó - 091821
EMEI Gabriel Prestes - 091863
EMEI Heitor Villa Lobos - 092401
EMEI João Theodoro - 091880
EMEI Monteiro Lobato - 090425
EMEI São Bento - 019675


CEI Bela Vista - 400316
CEI Cantinho dos Tesouros - 400487
CEI Içami Tiba - 400505


Creche Betty Lafer - 306397
Creche Jose Ho - 309771
Creche Liberdade - 306409
Creche Mãe Achiropita - 306740
Creche Olga Lopes - 309035
Creche Paula Maria - 308250
Creche Quintal da Criança - 306729
Creche Ruach - 309296
Creche São Francisco de Assis - 306521
*/
drop table ##escolas_destino
select A.*,CONCAT(B.SG_TP_ESCOLA,B.NOMESC) AS DESTINO,B.CD_COORDENADA_GEO_Y,B.CD_COORDENADA_GEO_X 
INTO ##escolas_destino
FROM  [dbo].[amostra_escolas] A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA COLLATE Latin1_General_CI_AS
--select * from ##escolas_destino

drop table ##IP_DESTINO
SELECT 
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOME_ESCOLA,
CD_TURMA_ESCOLA,
COD_ALUNO,
NOME_ALUNO,
ETAPA,
SERIE_ANO,
B.DESTINO,
--CONCAT(B.CD_ESCOLA,' ',B.SG_TP_ESCOLA,' ',NOMESC) AS NOVO_DESTINO,
FLOOR(FLOOR(SQRT(POWER((LAT_ALUNO * 1000000 - ( CD_COORDENADA_GEO_Y * 1000000) ),2) +  POWER((LON_ALUNO * 1000000  - (CD_COORDENADA_GEO_X * 1000000)),2)) / 10)/0.6) AS DISTANCIA
INTO ##IP_DESTINO

 FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR A, ##escolas_destino B  
 WHERE A.CD_ESCOLA=091855 --AND DESTINO LIKE '%EMEI%'
