/*
Solicitamos, por favor, rela��o atualizada das UEs da RME com as seguintes informa��es:

DRE
UE
C�DIGO ESCOLA
ENDERE�O
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