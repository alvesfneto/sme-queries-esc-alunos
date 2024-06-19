/*

É possível um arquivo com endereços dos alunos matriculados em todas as nossa Unidades, com prioridade para os setores da Brasilândia?

*/

DROP TABLE ##alunos_estudo_analise_teg_dre_fb_distrito_setor
SELECT DISTINCT
DRE,
cd_escola,
SG_TP_ESCOLA,
NOME_ESCOLA,
DISTR AS DISTR_ESCOLA,
SETOR SETOR_ESCOLA,
ETAPA,
SERIE_ANO,
COD_ALUNO,
NOME_ALUNO,
CONCAT (TP_LOGRADOURO,' ',ENDEREÇO,', ', NR,' ',COMPL,'-',BAIRRO) AS ENDEREÇO,
DIST_SETOR AS DISTR_ALUNO,
CD_DIST_SETOR AS SETOR_ALUNO,
DIST_ESCOLA,
DIST_CARRO,
CRDATE AS DT_BASE
INTO ##alunos_estudo_analise_teg_dre_fb_distrito_setor

FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR


WHERE DRE = 'DRE - FB' 

--SELECT * FROM ##alunos_estudo_analise_teg_dre_fb_distrito_setor WHERE COD_ALUNO=6156671

select * from SME_ALUNOS_DIARIO where CD_ALUNO = 5805990
select * from VW_ALUNOS_ENDERECOS_DISTRITO_SETOR where COD_ALUNO = 5805990