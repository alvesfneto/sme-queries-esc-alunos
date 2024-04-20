
USE Db_Local
/*
Estamos levantando os dados para a produção de informativo do prefeito. Se possível, conseguem nos ajudar com as atualizações das informações em amarelo, por gentileza?
Os 12 novos CEUs inaugurados na gestão 2017/2020 são focados na Primeira Infância. Oferecem cerca de 6 mil vagas para crianças de até 6 anos. 
Precisamos de um retorno até às 11h de hoje, por favor. 

OS CEUS CRIADO A PARTIR DE 2020 - SÃO 12 CEUS CUJAS UNIDADES EDUCACIONAIS SÃO DO TIPO 'CEU CEMEI'
UTILIZEI A CONSULTA DE ESCOLAS PARA DIVULGAÇÃO(VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL) E A CONSULTA VW_CEUS PARA PESQUISAR AS ESCOLAS VINCULADAS AOS CEUS CRIADOS APARTIR DE 2017 

								SELECT * FROM VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL A
								JOIN VW_CEUS B ON A.CEU=B.NOME COLLATE Latin1_General_CI_AS
								WHERE CEU IS NOT NULL AND [DT CRIACAO EOL] >'2017-01-01'

DAÍ UTILIZEI AS TABELAS SME_ALUNOS_DIARIO E SME_ESCOLA_DIARIO PARA SOMAR AS MATRICULAS DE ALUNOS COM ATÉ 6 ANOS E TIPO DE ESCOLA = 31 - CEU CEMEI
*/

SELECT B.DRE,B.CD_ESCOLA, B.SG_TP_ESCOLA, B.NOMESC,

COUNT (DISTINCT CASE WHEN (DATEDIFF(YY,A.DT_NASCIMENTO_ALUNO,GETDATE())<=6) THEN CD_ALUNO ELSE NULL END) AS MATR
FROM SME_ALUNOS_DIARIO A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA

WHERE B.TP_ESCOLA=31 
GROUP BY B.DRE,B.CD_ESCOLA, B.SG_TP_ESCOLA, B.NOMESC

/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

