/*Seria poss�vel nos encaminhar um relat�rio dos aluno de MGII/2024, sem encaminhamento para EMEI em 2025?
Alunos que podem estar sem inscri��o de continuidade e sem encaminhamento para EMEI, ou rematriculado 2025.
No relat�rio deve constar:

Nome do aluno;
Unidade de matr�cula;
Endere�o completo (separado por coluna: rua, numero e CEP);
Agrupamento;
*/
DROP TABLE ##LISTA_ALUNOS_MGII_DRE_CS
select * INTO ##LISTA_ALUNOS_MGII_DRE_CS from [dbo].[LISTA_ALUNOS_MGII_DIR_CONV] WHERE DRE ='DRE - CS'

--SELECT * FROM ##LISTA_ALUNOS_MGII_DRE_CS ORDER BY 2