 /*Solicitamos   com a urgência que o caso requer, uma planilha com todos os dados pessoais , 
 código EOL, 
 endereço completo, 
 das crianças matrículadas no CEI Estrelinhas de Paraisópolis, cód escola 309558 ,
 para estudo do atendimento das crianças em outra unidade escolar devido o prédio 
 da mesma ter sido prejudicado com as recorrentes chuvas em São Paulo. 
 A unidade não tem condições de receber os alunos no início das aulas previsto para dia 05/02, 
 por isso a urgência da planilha, para que  os alunos  não  tenham  prejuízo.
 */
 drop table ##alunos_unidade_309558
 SELECT
 DRE,
 CD_ESCOLA,
 SG_TP_ESCOLA
 NOME_ESCOLA,
 ETAPA,
 SERIE_ANO,
 COD_ALUNO,
 NOME_ALUNO,
 UPPER (CONCAT(TP_LOGRADOURO,ENDEREÇO)) AS ENDERECO,
 NR,
 COMPL,
 BAIRRO
 
 INTO ##alunos_unidade_309558
 FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR WHERE CD_ESCOLA=309558
 --SELECT * FROM ##alunos_unidade_309558
