/*
Solicitamos, por favor, relação atualizada das UEs da RME com as seguintes informações:

DRE
UE
CÓDIGO ESCOLA
ENDEREÇO
DISTRITO
E-MAIL
TELEFONE
*/
SELECT 
DRE,
CODESC,
TIPOESC,
NOMESC,
ENDERECO,
NUMERO,
BAIRRO,
CEP,
TEL1,
TEL2,
EMAIL
INTO ##escolas_lista_para_coped
 FROM VW_CADASTRO_ESCOLAS_DIVULGACAO_EOL