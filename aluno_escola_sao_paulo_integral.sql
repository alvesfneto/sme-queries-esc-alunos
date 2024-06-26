drop table ##aluno_escola_sao_paulo_integral																	
																	
																	
							SELECT  										
								 B.NM_UNIDADE_EDUCACAO AS DIRETORIA_REGIONAL									
								,SG_TP_ESCOLA									
								,A.CD_UNIDADE_EDUCACAO									
								,A.NM_UNIDADE_EDUCACAO									
								,M.CD_TURMA_ESCOLA									
								,M.CD_TIPO_TURMA									
								,P.CD_SERIE_ENSINO 									
								,Q.DC_ETAPA_ENSINO									
								,P.SG_SERIE_ENSINO									
								,COUNT(DISTINCT(CD_MATRICULA)) AS QTD_ALUNO									
								,ESCOLA_GRADE.CD_GRADE									
								,TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR									
								,DC_COMPONENTE_CURRICULAR									
								,TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_TERRITORIO_SABER									
								,TERRITORIO_SABER.DC_TERRITORIO_SABER									
								,TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_EXPERIENCIA_PEDAGOGICA 									
								,TIPO_EXPERIENCIA_PEDAGOGICA.DC_EXPERIENCIA_PEDAGOGICA									
																	
								--,EXPERIENCIA_PEDAGOGICA1 =  SUM(DISTINCT(CASE WHEN TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = 1214 THEN TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA ELSE 0 END)) 									
								--,EXPERIENCIA_PEDAGOGICA2 =  SUM(DISTINCT(CASE WHEN TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = 1215 THEN TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA ELSE 0 END)) 									
								--,EXPERIENCIA_PEDAGOGICA3 =  SUM(DISTINCT(CASE WHEN TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = 1216 THEN TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA ELSE 0 END)) 									
								--,EXPERIENCIA_PEDAGOGICA4 =  SUM(DISTINCT(CASE WHEN TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = 1217 THEN TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA ELSE 0 END)) 									
								--,EXPERIENCIA_PEDAGOGICA5 =  SUM(DISTINCT(CASE WHEN TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = 1218 THEN TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA ELSE 0 END)) 									
								--,EXPERIENCIA_PEDAGOGICA6 =  SUM(DISTINCT(CASE WHEN TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = 1219 THEN TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA ELSE 0 END)) 									
							into ##aluno_escola_sao_paulo_integral										
							FROM      D_UNIDADE_EDUCACAO A										
							LEFT JOIN D_UNIDADE_EDUCACAO B								ON A.CD_UNIDADE_ADMINISTRATIVA_REFERENCIA = B.CD_UNIDADE_EDUCACAO		
							LEFT JOIN D_ESCOLA C										ON A.CD_UNIDADE_EDUCACAO = C.CD_ESCOLA
								 JOIN D_TURMA_ESCOLA M									ON A.CD_UNIDADE_EDUCACAO =  M.CD_ESCOLA  
							LEFT JOIN D_CORRESPONDENCIA_SERIE_EOL M1					ON M.CD_CORRESPONDENCIA_SERIE = M1.CD_CORRESPONDENCIA_SERIE					
							LEFT JOIN D_SERIE_ENSINO P									ON M1.CD_SERIE_EOL2007 = P.CD_SERIE_ENSINO	
							LEFT JOIN D_MATRICULA_TURMA_ESCOLA N						ON M.CD_TURMA_ESCOLA = N.CD_TURMA_ESCOLA				
							LEFT JOIN D_ETAPA_ENSINO Q									ON P.CD_ETAPA_ENSINO = Q.CD_ETAPA_ENSINO	
							LEFT JOIN D_TIPO_TURMA R									ON M.CD_TIPO_TURMA = R.CD_TIPO_TURMA	
							LEFT JOIN D_TIPO_ESCOLA T									ON C.TP_ESCOLA = T.TP_ESCOLA	
							LEFT JOIN D_SERIE_TURMA_GRADE				                ON M.CD_TURMA_ESCOLA = SERIE_TURMA_GRADE.CD_TURMA_ESCOLA AND SERIE_TURMA_GRADE.DT_FIM IS NULL						
							LEFT JOIN D_ESCOLA_GRADE					                ON SERIE_TURMA_GRADE.CD_ESCOLA_GRADE = ESCOLA_GRADE.CD_ESCOLA_GRADE AND ESCOLA_GRADE.DT_FIM_VALIDADE IS NULL					
							LEFT JOIN D_GRADE							                ON ESCOLA_GRADE.CD_GRADE = GRADE.CD_GRADE AND GRADE.DT_FIM_VALIDADE IS NULL			
							LEFT JOIN D_TURMA_GRADE_TERRITORIO_EXPERIENCIA	            ON SERIE_TURMA_GRADE.CD_SERIE_GRADE = TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_SERIE_GRADE									
							LEFT JOIN D_TIPO_EXPERIENCIA_PEDAGOGICA						ON TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_EXPERIENCIA_PEDAGOGICA = TIPO_EXPERIENCIA_PEDAGOGICA.CD_EXPERIENCIA_PEDAGOGICA AND TIPO_EXPERIENCIA_PEDAGOGICA.DT_CANCELAMENTO IS NULL				
							LEFT JOIN D_TERRITORIO_SABER								ON TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_TERRITORIO_SABER = TERRITORIO_SABER.CD_TERRITORIO_SABER		
							LEFT JOIN D_COMPONENTE_CURRICULAR							ON TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR = COMPONENTE_CURRICULAR.CD_COMPONENTE_CURRICULAR			
							WHERE										
								A.TP_SITUACAO_UNIDADE = 1  									
								AND A.TP_UNIDADE_EDUCACAO = 1									
								AND M.AN_LETIVO = 2016									
								AND M.CD_TIPO_TURMA <> 4 --DESCONSIDERADO AS TURMAS DE CJ									
								--AND Q.CD_ETAPA_ENSINO IN (5,13)									
								and dc_territorio_saber is not null									
																	
							  --AND M.CD_TURMA_ESCOLA = 1988332										
															
							GROUP BY 										
								 B.NM_UNIDADE_EDUCACAO									
								,SG_TP_ESCOLA									
								,A.CD_UNIDADE_EDUCACAO									
								,A.NM_UNIDADE_EDUCACAO									
								,M.CD_TURMA_ESCOLA									
								,M.CD_TIPO_TURMA									
								,DC_TIPO_TURMA									
								,P.CD_CICLO_ENSINO									
								,P.CD_SERIE_ENSINO									
								,Q.DC_ETAPA_ENSINO									
								,SG_ETAPA									
								,P.SG_SERIE_ENSINO									
								,ESCOLA_GRADE.CD_GRADE									
								,TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_COMPONENTE_CURRICULAR									
								,DC_COMPONENTE_CURRICULAR									
								,TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_TERRITORIO_SABER									
								,TERRITORIO_SABER.DC_TERRITORIO_SABER									
								,TURMA_GRADE_TERRITORIO_EXPERIENCIA.CD_EXPERIENCIA_PEDAGOGICA 									
								,TIPO_EXPERIENCIA_PEDAGOGICA.DC_EXPERIENCIA_PEDAGOGICA									
																	
																	
																	
																	
SELECT * FROM ##aluno_escola_sao_paulo_integral																	
