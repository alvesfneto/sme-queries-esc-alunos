DROP TABLE ##CLASSES
SELECT 
CD_ESCOLA,
AN_LETIVO,
CD_TURMA_ESCOLA,
CD_TIPO_PROGRAMA,
ST_TURMA_ESCOLA,
CD_TIPO_TURNO,
CD_ETAPA_ENSINO,
SG_ETAPA,
CD_SERIE_ENSINO, 
DC_SERIE_ENSINO,
QT_VAGA_OFERECIDA,
DC_TIPO_AMBIENTE,
NR_SALA,
ISNULL(QT_AREA_UTIL,0)AS AREA_AMBIENTE,
QT_IDEAL_PESSOA,
QT_REAL_PESSOA,
AL_AT,
CRDATE
INTO ##CLASSES
FROM Db_Local_0_20230531..SME_CLASSES
WHERE CD_TIPO_PROGRAMA IS NULL

--select * from ##CLASSES
SELECT 
COUNT( CASE WHEN AREA_AMBIENTE <20 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '<20 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 20 AND 29 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '20 A 29 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 30 AND 39 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '30 A 39 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 40 AND 49 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '40 A 49 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 50 AND 59 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '50 A 59 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 60 AND 69 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '60 A 69 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 70 AND 79 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '70 A 79 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 80 AND 89 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '80 A 89 M2',
COUNT( CASE WHEN AREA_AMBIENTE BETWEEN 90 AND 99 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '90 A 99 M2',
COUNT( CASE WHEN AREA_AMBIENTE >100 THEN DC_TIPO_AMBIENTE ELSE NULL END) AS '>=100 M2',
COUNT( DC_TIPO_AMBIENTE) AS TOTAL
FROM ##CLASSES

/*
Observação: as áreas das salas de aula/berários tem valores
que devem ser corrigidos no EOL.
Há salas com valores nulos ou zero metros quadrados e valores
bema mais altos, acima de 100 metros quadrados
(Menor valor: 0 maior valor 31770 metros quadrados)

Valores mais frequentes entre 20 a 49 metros quadrados, 50% dos valores tem até 35 metros quadrados(mediana)

AREA(m2) Freq_abs	     Freq_rel       Freq_acum
--------------------------------------------------
AREA	     FREQ_ABS	Freq_rela	Freq_acum
<20 M2	      8542	     13,55%	    13,55%
20 A 29 M2	 13958	     22,14%	    35,69%
30 A 39 M2	 13273	     21,05%	    56,74%
40 A 49 M2	 17332	     27,49%	    84,23%
50 A 59 M2	 7630	     12,10%	    96,33%
60 A 69 M2	  925	      1,47%	    97,80%
70 A 79 M2	  181	      0,29%	    98,09%
80 A 89 M2	   78	      0,12%	    98,21%
90 A 99 M2	   15	      0,02%	    98,24%
>=100 M2	 1099	      1,74%	    99,98%
TOTAL		63046		100,00%	

*/

--SELECT * FROM ##CLASSES

SELECT
DRE,
A.CD_ESCOLA,
SG_TP_ESCOLA,
NOMESC,
DC_TIPO_AMBIENTE,
AREA_AMBIENTE 

FROM ##CLASSES A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE AREA_AMBIENTE <20 OR AREA_AMBIENTE >=100 AND CD_SIT=1





--=========================CRECHE===============================

--1. A Prefeitura municipal oferece Creche? 

--Sim

--1.3. Algum estabelecimento que oferece Creche possui brinquedos no Pátio Infantil? SIM

--1.3.1. Informe quantos estabelecimentos que oferecem Creche possuem: Brinquedos no Pátio Infantil (BPI):

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

SELECT 
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))>2.3) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '>2.30',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 2 AND 2.3) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '2.00 A 2.30',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 1.5 AND 1.99) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '1.50 A 2.00',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))< 1.5) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '<1.50',
COUNT (DISTINCT CD_TURMA_ESCOLA) AS QT_TURMAS
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (1,3,4,6,11,27,28,29,307,308,309,311,321,322) AND AL_AT>0
/*
                  >2.30	   2.00 A 2.30	1.50 A 2.00	    <1.50	   QT_TURMAS
                  24154	       1504	        3117	     5338	     34113
*/
--1.5. Informe a quantidade de turmas de Creche em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 2,30 m² por aluno: 

--1.6. Informe a quantidade de turmas de Creche em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 2,00 m² por aluno e inferior a 2,30 m² por aluno:

--1.7. Informe a quantidade de turmas de Creche em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,50 m² por aluno e inferior a 2,00 m² por aluno:

--1.8. Informe a quantidade de turmas de Creche em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Inferior a 1,50 m² por aluno:


--1.22. A Prefeitura municipal fez uma pesquisa/estudo para levantar o número de crianças que necessitavam de Creches em 2023? COGED

--1.23. Informe: Número de crianças de 0 a 3 anos que solicitaram vaga em creche até 31/12/2023:

SELECT 
SUM(QT_VAGA_OFERECIDA) AS VAGAS,
CONVERT(VARCHAR,CRDATE-1,103) AS DT_BASE
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (1,3,4,6,11,27,28,29,307,308,309,311,321,322)
GROUP BY CRDATE

--1.24. Informe: Número de vagas de creche ofertadas em 2023:

SELECT 
COUNT(DISTINCT CASE WHEN AL_AT<=13 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Até 13 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 14 AND 20 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '14 a 20 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 21 AND 25 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '21 a 25 alunos',
COUNT(DISTINCT CASE WHEN AL_AT>25 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Mais de 25 alunos',
COUNT(DISTINCT CD_TURMA_ESCOLA) AS TOTAL
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (1,3,4,6,11,27,28,29,307,308,309,311,321,322) AND AL_AT<>0

/*
         Até 13 alunos	14 a 20 alunos	21 a 25 alunos	Mais de 25 alunos	TOTAL
            27613	       4565	           1930	             5	            34113
*/

--1.25. Informe a quantidade de turmas de Creche: Até 13 alunos:
-->30631

--1.26. Informe a quantidade de turmas de Creche: De 14 a 20 alunos: 
-->5440

--1.27. Informe a quantidade de turmas de Creche: De 21 a 25 alunos:
-->4038

--1.28. Informe a quantidade de turmas de Creche: Acima de 25 alunos:
-->5425
 

--=======================PRÉ-ESCOLA===================================

--2. A Prefeitura municipal oferece Pré-escola?

--Sim

SELECT 
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))>1.36) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '>1.36',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 1.1 AND 1.36) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '1.10 A 1.36',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 0.9 AND 1.09) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '0.90 A 1.10',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))< 0.9) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '<0.90',
COUNT (DISTINCT CD_TURMA_ESCOLA) AS QT_TURMAS
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (23,24,297,25,26,313,314,319,320) AND AL_AT>0

/*
             >1.36	1.10 A 1.36	  0.90 A 1.10	 <0.90	   QT_TURMAS
             7666	    1659	       93	       696	    10114
*/


--2.3. Informe a quantidade de turmas de Pré-escola em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,36 m² por aluno:

--2.4. Informe a quantidade de turmas de Pré-escola em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,10 m² por aluno e inferior a 1,36 m² por aluno:

--2.5. Informe a quantidade de turmas de Pré-escola em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 0,90 por aluno m² e inferior a 1,10 m² por aluno:

--2.6. Informe a quantidade de turmas de Pré-escola em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Inferior a 0,90 m² por aluno:

--2.20. A Prefeitura municipal fez uma pesquisa/estudo para levantar o número de crianças que necessitavam de Pré-escola em 2023?

--2.21. Informe: Número de crianças de 4 a 5 anos que solicitaram vaga até 31/12/2023:

SELECT 
SUM(QT_VAGA_OFERECIDA) AS VAGAS,
CONVERT(VARCHAR,CRDATE-1,103) AS DT_BASE
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (23,24,297,25,26,313,314,319,320)
GROUP BY CRDATE

--2.22. Informe: Número de vagas de pré-escola ofertadas em 2023:

SELECT 
COUNT(DISTINCT CASE WHEN AL_AT<=22 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Até 22 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 23 AND 25 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '23 a 25 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 26 AND 30 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '26 a 30 alunos',
COUNT(DISTINCT CASE WHEN AL_AT>30 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Mais de 30 alunos',
COUNT(DISTINCT CD_TURMA_ESCOLA) AS TOTAL
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (23,24,297,25,26,313,314,319,320) AND AL_AT<>0

/*
             Até 22 alunos	23 a 25 alunos	26 a 30 alunos	Mais de 30 alunos	TOTAL
                3029	      1669	            4348	        1068	         10114
*/
--2.23. Informe a quantidade de turmas de Pré-escola: Até 22 alunos:

--2.24. Informe a quantidade de turmas de Pré-escola: De 23 a 25 alunos:

--2.25. Informe a quantidade de turmas de Pré-escola: De 26 a 30 alunos:

--2.26. Informe a quantidade de turmas de Pré-escola: Acima de 30 alunos:

 

--ANOS INICIAIS

--3. A Prefeitura Municipal oferece os Anos Iniciais do Ensino Fundamental (1º ao 5º ano)?

SELECT 
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))>1.875) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '>1.875',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 1.2 AND 1.875) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '1.20 A 1.875',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 1.0 AND 1.19) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '1.00 A 1.20',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))<1.0) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '<1.00',
COUNT (DISTINCT CD_TURMA_ESCOLA) AS QT_TURMAS
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (84,250,86,251,88,252,235,253,236,254) AND AL_AT>0

/*
            >1.875	1.20 A 1.875	1.00 A 1.20	    <1.00	QT_TURMAS
              863	   7133	            434	         63	      8493
*/
--3.1. Informe a quantidade de turmas dos Anos Iniciais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,875 m²:

--3.2. Informe a quantidade de turmas dos Anos Iniciais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,20 e inferior a 1,875 m²:

--3.3. Informe a quantidade de turmas dos Anos Iniciais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,00 e inferior a 1,20 m²:

--3.4. Informe a quantidade de turmas dos Anos Iniciais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Inferior a 1,00 m²:

--3.23. A Prefeitura municipal fez uma pesquisa/estudo para levantar o número de crianças que necessitavam dos Anos Iniciais escolar em 2023?

--3.24. Informe: Número de crianças de 6 a 10 anos que solicitaram vaga nos Anos Iniciais até 31/12/2023:

SELECT 
SUM(QT_VAGA_OFERECIDA) AS VAGAS,
CONVERT(VARCHAR,CRDATE-1,103) AS DT_BASE
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (84,250,86,251,88,252,235,253,236,254)
GROUP BY CRDATE



--3.25. Informe: Número de vagas de Anos Iniciais ofertadas em 2023:

SELECT 
SUM(CASE WHEN CD_TIPO_TURNO = 1 THEN AL_AT ELSE NULL END) AS MT_MANHA,
SUM(CASE WHEN CD_TIPO_TURNO = 3 THEN AL_AT ELSE NULL END) AS MT_TARDE,
SUM(CASE WHEN CD_TIPO_TURNO = 5 THEN AL_AT ELSE NULL END) AS MT_NOITE,
SUM(CASE WHEN CD_TIPO_TURNO = 6 THEN AL_AT ELSE NULL END) AS MT_INTEGRAL,
SUM(AL_AT) AS TOTAL
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (84,250,86,251,88,252,235,253,236,254)

/*
           MT_MANHA	 MT_TARDE	MT_NOITE	MT_INTEGRAL	   TOTAL
             83966	  118287	  NULL	       48767	   251020
*/
--3.26. Informe o número de alunos matriculados dos Anos Iniciais por turno: Manhã:

--3.27. Informe o número de alunos matriculados dos Anos Iniciais por turno: Tarde:

SELECT 
COUNT(DISTINCT CASE WHEN AL_AT<=24 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Até 24 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 25 AND 30 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '25 a 30 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 31 AND 33 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '31 a 33 alunos',
COUNT(DISTINCT CASE WHEN AL_AT>33 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Mais de 33 alunos',
COUNT(DISTINCT CD_TURMA_ESCOLA) AS TOTAL
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (84,250,86,251,88,252,235,253,236,254) AND AL_AT<>0

/*
        Até 24 alunos	25 a 30 alunos	31 a 33 alunos	Mais de 33 alunos	TOTAL
            401	          5357	          2660	             75	            8493
*/
--3.28. Informe a quantidade de turmas dos Anos Iniciais: Até 24 alunos:

--3.29. Informe a quantidade de turmas dos Anos Iniciais: De 25 a 30 alunos:

--3.30. Informe a quantidade de turmas dos Anos Iniciais: De 31 a 33 alunos:

--3.31. Informe a quantidade de turmas dos Anos Iniciais: Acima de 33 alunos:

--3.32. Qual foi o número de aulas vagas nos Anos Iniciais durante o ano de 2023?

 

--ANOS FINAIS

--4. A Prefeitura Municipal oferece os Anos Finais do Ensino Fundamental (6º ao 9º ano)?


SELECT 
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))>1.5) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '>1.50',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 1.2 AND 1.50) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '1.20 A 1.50',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))BETWEEN 1.0 AND 1.19) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '1.00 A 1.20',
COUNT (DISTINCT CASE WHEN (cast(cast(AREA_AMBIENTE as decimal(7,2))/AL_AT as decimal(7,2))<1.0) THEN CD_TURMA_ESCOLA ELSE NULL END) AS '<1.00',
COUNT (DISTINCT CD_TURMA_ESCOLA) AS QT_TURMAS
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (232,255,237,256,238,257,239,258) AND AL_AT>0

/*
             >1.50	1.20 A 1.50	 1.00 A 1.20	 <1.00	  QT_TURMAS
              3972	    1695	     318	       69	   6054
*/

--4.1. Informe a quantidade de turmas dos Anos Finais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,5 m²:

--4.2. Informe a quantidade de turmas dos Anos Finais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,20 e inferior a 1,5 m²:

--4.3. Informe a quantidade de turmas dos Anos Finais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Superior ou igual a 1,00 e inferior a 1,20 m²:

--4.4. Informe a quantidade de turmas dos Anos Finais em que o espaço por aluno em sala de aula (área da sala dividido pelo nº de alunos) era: Inferior a 1,00 m²:

--4.22. A Prefeitura municipal fez uma pesquisa/estudo para levantar o número de crianças que necessitavam dos Anos Finais escolar em 2023?

--4.23. Informe: Número de crianças de 11 a 14 anos que solicitaram vaga nos Anos Finais até 31/12/2023:

SELECT 
SUM(QT_VAGA_OFERECIDA) AS VAGAS,
CONVERT(VARCHAR,CRDATE-1,103) AS DT_BASE
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (232,255,237,256,238,257,239,258)
GROUP BY CRDATE

--4.24. Informe: Número de vagas de Anos Finais ofertadas em 2023:


SELECT 
SUM(CASE WHEN CD_TIPO_TURNO = 1 THEN AL_AT ELSE NULL END) AS MT_MANHA,
SUM(CASE WHEN CD_TIPO_TURNO = 3 THEN AL_AT ELSE NULL END) AS MT_TARDE,
SUM(CASE WHEN CD_TIPO_TURNO = 5 THEN AL_AT ELSE NULL END) AS MT_NOITE,
SUM(CASE WHEN CD_TIPO_TURNO = 6 THEN AL_AT ELSE NULL END) AS MT_INTEGRAL,
SUM(AL_AT) AS TOTAL
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (232,255,237,256,238,257,239,258)

/*
        MT_MANHA	MT_TARDE	MT_NOITE	MT_INTEGRAL	    TOTAL
         119078	      61450	      NULL	       4814	       185342
*/

--4.25. Informe o número de alunos matriculados dos Anos Finais por turno no ano de 2023: Manhã:

--4.26. Informe o número de alunos matriculados dos Anos Finais por turno no ano de 2023: Tarde:

SELECT 
COUNT(DISTINCT CASE WHEN AL_AT<=30 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Até 30 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 31 AND 35 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '31 a 35 alunos',
COUNT(DISTINCT CASE WHEN AL_AT BETWEEN 36 AND 39 THEN CD_TURMA_ESCOLA ELSE NULL END) AS '36 a 39 alunos',
COUNT(DISTINCT CASE WHEN AL_AT>39 THEN CD_TURMA_ESCOLA ELSE NULL END) AS 'Mais de 39 alunos',
COUNT(DISTINCT CD_TURMA_ESCOLA) AS TOTAL
FROM ##CLASSES
WHERE CD_SERIE_ENSINO IN (232,255,237,256,238,257,239,258) AND AL_AT<>0

/*
       Até 30 alunos	31 a 35 alunos	36 a 39 alunos	Mais de 39 alunos	TOTAL
          1956	          4076	           22	              0	             6054
*/

--4.27. Informe a quantidade de turmas dos Anos Finais no ano de 2023: Até 30 alunos:

--4.28. Informe a quantidade de turmas dos Anos Finais no ano de 2023: De 31 a 35 alunos:

--4.29. Informe a quantidade de turmas dos Anos Finais no ano de 2023: De 36 a 39 alunos:

--4.30. Informe a quantidade de turmas dos Anos Finais no ano de 2023: Acima de 39 alunos:

--4.31. Qual foi o número de aulas vagas nos Anos Finais durante o ano de 2023? Quantidade de aulas vagas:

