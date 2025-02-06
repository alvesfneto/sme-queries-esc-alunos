/*Prezados, bom dia.
 Por favor, seria poss�vel voc�s enviarem-me a rela��o das Unidades Conveniadas, com endere�o e subprefeitura?
 Aguardo um retorno.
  */
  drop table ##unidades_conveniadas_enderecos
  SELECT 
  DRE,
  CODESC,
  TIPOESC,
  NOMESC,
  ENDERECO,
  NUMERO,
  BAIRRO,
  DISTRITO,
  SUBPREF,
  [DATABASE]
  INTO ##unidades_conveniadas_enderecos
  FROM VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL
  WHERE TIPOESC IN ('CEI INDIR', 'CR.P.CONV')

  --SELECT * FROM ##unidades_conveniadas_enderecos