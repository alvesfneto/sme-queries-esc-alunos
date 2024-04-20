--ENDEREÇOS DOS ALUNOS



--DROP table ##ALUNOS_ENDERECOS 

SELECT distinct 
A.cd_aluno AS COD_ALUNO, 
A.cd_escola,
E.dc_tp_logradouro AS TP_LOGRADOURO,
D.nm_logradouro AS ENDEREÇO, 
D.cd_nr_endereco AS NR, 
D.dc_complemento_endereco AS COMPL, 
D.nm_bairro AS BAIRRO,
D.cd_cep AS CEP, 
D.cd_coordenada_geo_y AS LAT_ALUNO, 
D.cd_coordenada_geo_x AS LON_ALUNO,
A.qt_distancia AS DIST_ESCOLA,
A.qt_distancia_carro AS DIST_CARRO,
A.an_letivo AS ANO_LETIVO, 
CONVERT(VARCHAR, A.CRDATE,103) AS CRDATE
INTO ##ALUNOS_ENDERECOS
FROM D_MATRICULA A 
INNER JOIN ((D_ENDERECO_ALUNO B
INNER JOIN D_endereco_aluno_tipo_endereco C ON B.cd_endereco_aluno = C.cd_endereco_aluno) 
INNER JOIN D_endereco D ON B.ci_endereco = D.ci_endereco) ON A.cd_aluno = B.cd_aluno
INNER JOIN TIPO_LOGRADOURO E ON D.tp_logradouro= E.tp_logradouro
INNER JOIN TIPO_ENDERECO F ON C.ci_tipo_endereco =F.ci_tipo_endereco
WHERE B.dt_fim Is Null 
AND A.st_matricula='1'
AND A.cd_serie_ensino IS NOT NULL
AND A.an_letivo=YEAR(GETDATE())
AND C.dt_fim Is Null
AND F.ci_tipo_endereco='1'


---------------------------------------------------------
--SELECT * FROM ##ALUNOS_ENDERECOS







