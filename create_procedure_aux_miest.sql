USE [Db_local]
GO

/****** Object:  StoredProcedure [dbo].[PROC_AUX_MIEST]    Script Date: 20/06/2024 13:57:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[PROC_AUX_MIEST]

AS

begin

DECLARE @DURCLASSE INT SET @DURCLASSE = 0 
DECLARE @SEMESTRE DATE SET @SEMESTRE = '2010-07-21' 

      IF (SELECT  MIN(AN_LETIVO)  FROM D_TURMA_ESCOLA) = YEAR(GETDATE()) 
         (SELECT @DURCLASSE = @DURCLASSE + 2) 
  ELSE
  
  IF MONTH(@SEMESTRE) < MONTH(GETDATE()) 
 (SELECT @DURCLASSE = @DURCLASSE + 1) 
  ELSE 
 (SELECT @DURCLASSE = @DURCLASSE + 2)


 
 IF EXISTS
(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##TAB_DURCLASSE')
DROP TABLE ##TAB_DURCLASSE

CREATE TABLE ##TAB_DURCLASSE 
	(
	VALOR INT
	)

	INSERT ##TAB_DURCLASSE 
	VALUES ((SELECT @DURCLASSE))

	--SELECT * FROM ##TAB_DURCLASSE
/*------------------------------------------------------------------------------------------------------------------------------------------------------------
--PROCEDURE CRIA TABELA SOMENTE COM DOS C�DIGOS DE ESCOLAS E TURNOS DE ATENDIMENTO
------------------------------------------------------------------------------------------------------------------------------------------------------------*/

IF EXISTS
(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##AUX_TURNO')
DROP TABLE ##AUX_TURNO

SELECT 
	DISTINCT CD_ESCOLA, CD_TIPO_TURNO 
	INTO ##AUX_TURNO 
	FROM SME_CLASSES_DIARIO
WHERE
	CASE WHEN CD_TIPO_PERIODICIDADE  IN (1,2) THEN 0 --anual com inicio em primeiro semestre e anual com inicio em segundo semestre
		 WHEN CD_TIPO_PERIODICIDADE  IN (3) THEN 1 
		 WHEN CD_TIPO_PERIODICIDADE  IN (4) THEN 2
		 ELSE CD_TIPO_PERIODICIDADE 
	END <>  (SELECT * FROM ##TAB_DURCLASSE)
	AND AN_LETIVO = YEAR(GETDATE()) 
	AND CD_SERIE_ENSINO IS NOT NULL OR CD_TIPO_TURMA = 2
ORDER BY CD_ESCOLA, CD_TIPO_TURNO


--/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----TABELA DE CODIGO DE PROGRAMA / EOL COLETA ETAPA POR ETAPA EM QUALQUER PROGRAMA
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
IF EXISTS 
(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME = '##TIPO_PROGRAMA')
DROP TABLE ##TIPO_PROGRAMA


SELECT *,
TIPO_PROG = CASE

                           WHEN CD_TIPO_PROGRAMA IN (15 ,101,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,

                             143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,

                             181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,

                             219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,

                             257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,

                             295,296,297,298,299,300,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,333,93 ,341,334,338,

                             342,336,339,343,337,344,345,346,347,340,351,352,353,354,355,356,358,359,360,361,362,364,365,366,367,363,368,369,372,371,370,373,374,376,375,377,378,379,

                             380,382,383,384,385,386,387,388,389,391,390,392,393,395,398,399,400,401,402,405,406,409,410,

                             394,396,397,404,381,413,415,416,417,418,419,420,421,422,423,424,430,431,429,425,427,428,429,

                             47,357,414,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,557,558,559,560,561,562,563,564,565,566,
							 
/*acrescidos em 01/04/2024*/ 43,39, --saiu do osl/poie para atv compl segundo dom marcio
/*acrescidos em 01/04/2024*/ 605,599,600,604,597,594,609,568,603,607,606,601,602,595,569,567,598,596  
							 							 
							 )THEN 'ATIVIDADE COMPLEMENTAR'

                           WHEN CD_TIPO_PROGRAMA IN (99,100,102,103,104,105,106,301,302,303,411,412,424,553,554,555,556)THEN 'RECUPERACAO PARALELA'

                           WHEN CD_TIPO_PROGRAMA IN (426)THEN 'PAP RECUP.DE APRENDIZAGENS'

 

                           WHEN CD_TIPO_PROGRAMA IN (94,95,96,97,403, 608) THEN 'SALA DE RECURSO MULTIFUNCIONAL'

                           WHEN CD_TIPO_PROGRAMA IN (45) THEN 'MOVA'

                           WHEN CD_TIPO_PROGRAMA IN (16,17,18,19,20,21,22,23,24,25,26,1,2,42,331,332,534)THEN 'EVENTUAL PARA ATRIBUICAO'

                           WHEN CD_TIPO_PROGRAMA IN (13,27,32,33,44,70,80,88,533) THEN 'ED. PROF. BASICA - CMCT'

                           WHEN CD_TIPO_PROGRAMA IN (6,46,348,349,350) THEN 'CAEE - CONVENIOS ESPECIAIS'

                          -- WHEN CD_TIPO_PROGRAMA IN (43,39) THEN 'OSL/OIE - OUTROS'

                           WHEN CD_TIPO_PROGRAMA IN (451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,

                                                                     498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531) THEN 'ED. PROF. ESCOLA MUSICA'

                                                      WHEN CD_TIPO_PROGRAMA IN (535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552, 570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593) THEN 'CELP'

                    ELSE 'VERIFICAR' 
			END
INTO ##TIPO_PROGRAMA
FROM TIPO_PROGRAMA
WHERE DT_CANCELAMENTO IS NULL

end


--exec PROC_AUX_MIEST
--
--select * from ##TIPO_PROGRAMA where tipo_prog='verificar' order by dc_tipo_programa

GO


