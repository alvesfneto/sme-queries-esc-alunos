
--ESTUDO CPF ALUNO E RESPNSAVEL

SELECT DISTINCT
A.cd_aluno,
nm_aluno,
CONVERT(VARCHAR,dt_nascimento_aluno,103) AS dt_nascimento_aluno,
DATEDIFF(yy,dt_nascimento_aluno,GETDATE()) AS Idade_aluno,
nm_mae_aluno,
nm_pai_aluno,
nm_responsavel,
cd_cpf_aluno,
in_cpf_validado_receita_federal,
cd_cpf_responsavel,
in_cpf_responsavel_confere,
CASE WHEN nm_mae_aluno=nm_responsavel THEN 'MÂE'
     WHEN nm_pai_aluno=nm_responsavel THEN 'PAI'
	 WHEN nm_aluno=nm_responsavel THEN 'ALUNO'
	 ELSE B.nm_responsavel END AS [RESPONSAVEL?]
FROM D_ALUNO A
     JOIN (select
           cd_aluno,
           tp_pessoa_responsavel,
           nm_responsavel,
           nm_mae_responsavel,
           cd_cpf_responsavel,
		   in_cpf_responsavel_confere
           from D_RESPONSAVEL_ALUNO ) B ON A.cd_aluno=B.cd_aluno




