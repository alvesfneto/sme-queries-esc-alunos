
/*
De: José Alves Ferreira Neto <jose.neto@sme.prefeitura.sp.gov.br>
Enviada em: quinta-feira, 4 de julho de 2024 14:00
Para: Harry Walter Finger Roberts <harryr@prodam.sp.gov.br>
Assunto: tp_responsavel_dispositivo_comunicacao

Boa tarde Harry

Temos no EOL a descrição da coluna [tp_responsavel_dispositivo_comunicacao da tabela dbo.dispositivo_comunicacao_aluno?

Parece que M é Mãe e P é Pai, mas A, C,I,R?
====================================================

Boa tarde Jose,

Seguem abaixo as definições
A – Aluno (Dados antigos)
C – Contato de Recados
I – Relacionado ao endereço indicativo
M - Mãe
P - Pai
R – Responsável (Dado antigo)
 
====================================================
*/

--DROP TABLE tipo_responsavel_contato
CREATE TABLE tipo_responsavel_contato (
	tp_responsavel_dispositivo_comunicacao VARCHAR(1),
	dc_responsavel_dispositivo_comunicacao VARCHAR(35))


INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('A', 'Aluno (Dados antigos)')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('C',  'Contato de Recados')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('I','Relacionado ao endereço indicativo')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('M', 'Mãe')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('P', 'Pai')
INSERT INTO tipo_responsavel_contato (tp_responsavel_dispositivo_comunicacao, dc_responsavel_dispositivo_comunicacao) VALUES ('R', 'Responsável (Dado antigo)')


select * from tipo_responsavel_contato
	