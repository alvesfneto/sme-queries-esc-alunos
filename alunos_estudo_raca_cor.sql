
/*Prezados bom dia, 
meu nome é Eva e atuo no Núcleo de Educação Étnico-Racial, precisamos dos dados dos estudantes e escolas que possuem, nesse ano, estudantes indígenas. Também precisamos de dados sobre o número de professores e demais profissionais (diretores, ATE, etc) indígenas que trabalham na Rede.
Atenciosamente, 
Eva 
*/

DROP TABLE ##MATRICULAS_RACA_COR
SELECT
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.SG_ETAPA,
A.CD_TIPO_PROGRAMA,
COUNT (DISTINCT CASE WHEN (SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) THEN CD_ALUNO ELSE NULL END) AS MATR,
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND TP_RACA_COR=5) THEN CD_ALUNO ELSE NULL END) AS INDÍGENA,
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND TP_RACA_COR=1) THEN CD_ALUNO ELSE NULL END) AS BRANCA,
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45)  AND TP_RACA_COR=2) THEN CD_ALUNO ELSE NULL END) AS PRETA,
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND TP_RACA_COR=3) THEN CD_ALUNO ELSE NULL END) AS PARDA,
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND TP_RACA_COR=4) THEN CD_ALUNO ELSE NULL END) AS AMARELA,
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND TP_RACA_COR=6) THEN CD_ALUNO ELSE NULL END) AS [NÃO INFORMADA],
COUNT (DISTINCT CASE WHEN ((SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND TP_RACA_COR=7) THEN CD_ALUNO ELSE NULL END) AS [RECUSOU INFORMAR]
INTO ##MATRICULAS_RACA_COR
FROM SME_ALUNOS_DIARIO  A
JOIN SME_ESCOLA_DIARIO B ON A.CD_ESCOLA=B.CD_ESCOLA
WHERE (SG_ETAPA IS NOT NULL OR CD_TIPO_PROGRAMA=45) AND B.TP_ESCOLA IN (1,2,3,4,10,11,12,13,16,17,18,20,22,28,30,31,32,33)
GROUP BY
B.DRE,
B.CD_ESCOLA,
B.SG_TP_ESCOLA,
B.NOMESC,
A.SG_ETAPA,
A.CD_TIPO_PROGRAMA

--SELECT * FROM ##MATRICULAS_RACA_COR
-------------------------------------------------------------------------------------------------------------------------
                            /*
                            tp_raca_cor	dc_raca_cor
                                 1	      BRANCA
                                 2	      PRETA
                                 3	      PARDA
                                 4	      AMARELA
                                 5	      INDIGENA
                                 6	      NAO INFORMADA
                                 7	      RECUSOU INFORMAR
  
							tp_escola	sg_tp_escola	dc_tipo_escola
                                1	      EMEF        	ESCOLA MUNICIPAL DE ENSINO FUNDAMENTAL                                
                                2	      EMEI        	ESCOLA MUNICIPAL DE EDUCACAO INFANTIL                                 
                                3	      EMEFM       	ESCOLA MUNICIPAL DE ENSINO FUNDAMENTAL E MEDIO                        
                                4	      EMEBS       	ESCOLA MUNICIPAL DE EDUCACAO BILINGUE PARA SURDOS
                                10	      CEI DIRET   	CENTRO DE EDUCACAO INFANTIL DIRETO                                    
                                11	      CEI INDIR   	CENTRO DE EDUCACAO INFANTIL INDIRETO
                                12	      CR.P.CONV   	CRECHE PARTICULAR CONVENIADA                                          
                                13	      CIEJA       	CENTRO INTEGRADO DE EDUCACAO DE JOVENS E ADULTOS                      
                                14	      CCI/CIPS    	CENTRO DE CONVIVENCIA INFANTIL /CENTRO INFANTIL DE PROTECAO A SAUDE   
                                15	      ESC.PART.   	ESCOLA PARTICULAR                                                     
                                16	      CEU EMEF    	CENTRO EDUCACIONAL UNIFICADO - EMEF                                   
                                17	      CEU EMEI    	CENTRO EDUCACIONAL UNIFICADO - EMEI                                   
                                18	      CEU CEI     	CENTRO EDUCACIONAL UNIFICADO - CEI                                    
                                19	      CEU         	CENTRO EDUCACIONAL UNIFICADO                                          
                                20	      CECI        	CENTRO DE EDUCACAO E CULTURA INDIGENA
                                22	      MOVA        	MOVIMENTO DE ALFABETIZACAO                                            
                                23	      CMCT        	CENTRO MUNICIPAL DE CAPACITACAO E TREIN.                              
                                24	      ESC PART NR 	ESCOLA PARTICULAR NAO AUTORIZADA
                                25	      E TEC       	ESCOLA TECNICA
                                26	      ESP CONV    	ESPECIAL CONVENIADA
                                27	      CEU AT COMPL	CEU EXCLUSIVO ATIVIDADE COMPLEMENTAR
                                28	      CEMEI       	CENTRO MUNICIPAL DE EDUCACAO INFANTIL
                                29	      CCA         	CENTRO PARA CRIANCAS E ADOLESCENTES
                                30	      CECI        	CENTRO DE EDUCACAO E CULTURA INDIGENA
                                31	      CEU CEMEI   	CENTRO EDUCACIONAL UNIFICADO CEMEI
                                32	      EMEF P FOM  	ESCOLA MUNICIPAL DE ENSINO FUNDAMENTAL PRIVADA FOMENTO
                                33	      EMEI P FOM  	ESCOLA MUNICIPAL DE EDUCACAO INFANTIL  PRIVADA FOMENTO
                                34	      EXTE        	EXTERNA ESTADUAL
                                35	      EXTF        	EXTERNA FEDERAL
                                36	      EXTM        	EXTERNA MUNICIPAL
                                37	      EXTP        	EXTERNA PRIVADA
                             */
-----------------------------------------------------------------------------------------------------------------

--select * from tipo_programa where dc_tipo_programa like '%mova%'
--select * from tipo_programa order by dc_tipo_programa
--SELECT tp_escola, sg_tp_escola,dc_tipo_escola FROM D_TIPO_ESCOLA WHERE dt_cancelamento IS NULL
--SELECT TOP 10 * FROM SME_ALUNOS_DIARIO
