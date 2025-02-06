/*Seria possível nos encaminhar um relatório dos aluno de MGII/2024, sem encaminhamento para EMEI em 2025?
Alunos que podem estar sem inscrição de continuidade e sem encaminhamento para EMEI, ou rematriculado 2025.
No relatório deve constar:

Nome do aluno;
Unidade de matrícula;
Endereço completo (separado por coluna: rua, numero e CEP);
Agrupamento;
*/
DROP TABLE ##LISTA_ALUNOS_MGII_DRE_CS
select * INTO ##LISTA_ALUNOS_MGII_DRE_CS from [dbo].[LISTA_ALUNOS_MGII_DIR_CONV] WHERE DRE ='DRE - CS'

--SELECT * FROM ##LISTA_ALUNOS_MGII_DRE_CS ORDER BY 2