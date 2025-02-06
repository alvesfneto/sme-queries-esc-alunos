 /*Solicitamos   com a urg�ncia que o caso requer, uma planilha com todos os dados pessoais , 
 c�digo EOL, 
 endere�o completo, 
 das crian�as matr�culadas no CEI Estrelinhas de Parais�polis, c�d escola 309558 ,
 para estudo do atendimento das crian�as em outra unidade escolar devido o pr�dio 
 da mesma ter sido prejudicado com as recorrentes chuvas em S�o Paulo. 
 A unidade n�o tem condi��es de receber os alunos no in�cio das aulas previsto para dia 05/02, 
 por isso a urg�ncia da planilha, para que  os alunos  n�o  tenham  preju�zo.
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
 UPPER (CONCAT(TP_LOGRADOURO,ENDERE�O)) AS ENDERECO,
 NR,
 COMPL,
 BAIRRO
 
 INTO ##alunos_unidade_309558
 FROM VW_ALUNOS_ENDERECOS_DISTRITO_SETOR WHERE CD_ESCOLA=309558
 --SELECT * FROM ##alunos_unidade_309558
