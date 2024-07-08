
/*
De: Jos� Alves Ferreira Neto <jose.neto@sme.prefeitura.sp.gov.br>
Enviada em: quinta-feira, 4 de julho de 2024 14:00
Para: Harry Walter Finger Roberts <harryr@prodam.sp.gov.br>
Assunto: tp_responsavel_dispositivo_comunicacao

Boa tarde Harry

Temos no EOL a descri��o da coluna [tp_responsavel_dispositivo_comunicacao da tabela dbo.dispositivo_comunicacao_aluno?

Parece que M � M�e e P � Pai, mas A, C,I,R?
====================================================

Boa tarde Jose,

Seguem abaixo as defini��es
A � Aluno (Dados antigos)
C � Contato de Recados
I � Relacionado ao endere�o indicativo
M - M�e
P - Pai
R � Respons�vel (Dado antigo)
 
====================================================
*/

--DROP TABLE tipo_responsavel_contato
CREATE TABLE tipo_responsavel_contato (
	tp_responsavel_dispositivo_comunicacao VARCHAR(1),
	dc_responsavel_dispositivo_comunicacao VARCHAR(35))


INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('A', 'Aluno (Dados antigos)')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('C',  'Contato de Recados')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('I','Relacionado ao endere�o indicativo')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('M', 'M�e')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('P', 'Pai')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('R', 'Respons�vel (Dado antigo)')


select * from tipo_responsavel_contato
	