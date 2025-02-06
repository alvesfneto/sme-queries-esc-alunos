/*Por gentiliza, poderia nos enviar um relatório de viagens que foram abertas para 2025. 

Neste relatório deve constar

NOME DO CONDUTOR
Placa
Escola de atendimento
Período 
Número da viagem aberta
*/
drop table ##teg_viagens_cs 
SELECT
      [nm_condutor] AS CONDUTOR
	  ,[cd_placa_veiculo] AS PLACA
	  ,[nm_unidade_educacao] AS ESCOLA
	  ,[nr_ordem_viagem] NR_VIAGEM
	  ,[dc_tipo_turno] AS TURNO
INTO ##teg_viagens_cs    
  FROM [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[ficha_validacao_veiculo]

  WHERE AN_REFERENCIA ='2024' AND MS_REFERENCIA=12 AND CD_DRE=108300
GO
--select * from ##teg_viagens_cs 




--SELECT * FROM  [DB_EDUCACAO_1_PRODAM].[se1426_ss].[dbo].[ficha_validacao_veiculo]   WHERE AN_REFERENCIA ='2024' AND MS_REFERENCIA=12 AND CD_DRE=108300
