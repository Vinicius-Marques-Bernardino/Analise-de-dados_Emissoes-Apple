/* VALIDAÇÃO DOS DADOS
========================================= */

-- Observabdo a tabela de emissões de carbono
DESCRIBE gas_emissions;
SELECT COUNT(*) FROM gas_emissions;

SELECT * FROM gas_emissions;

-- Verificando valores nulos
SELECT
SUM(`Fiscal Year` IS NULL) AS anos_nulll,
SUM(category IS NULL) AS categoria_null,
SUM(`Type` IS NULL) AS tipo_null,
SUM(Scope IS NULL) AS escopo_null,
SUM(`Description` IS NULL) AS descricao_null,
SUM(emissions IS NULL) AS emissao_null
FROM gas_emissions;

/* Embora não tenha valores nulos, há, em escopo, valores vázios, que
representam as remoções de carbono. Ao que parece, o escopo não se 
aplica a esses "tipos de emissôes", logo, não se trata de um erro e 
pode permanecer assim enqunto estamos cientes dessa condição */

-- Verificando registros duplicados
SELECT *, COUNT(*) 
FROM gas_emissions
GROUP BY `Fiscal Year`, Category, `Type`, Scope, `Description`, Emissions
HAVING COUNT(*) > 1;
-- Sem dados duplicados

-- Verificando diferentes dados
-- Registros por ano
SELECT `Fiscal Year`, COUNT(*) AS qntd
FROM gas_emissions
GROUP BY `Fiscal Year`;
-- Praticamente 16 registros (com excessões em 2015/16/17 e 2022) por ano para 8 distintos 

-- Escopos
SELECT Scope, COUNT(*) AS qntd
FROM gas_emissions
GROUP BY Scope;
-- Três escopos e mais o "escopo ausente", sendo o terceiro com mais registros.

-- Descrição
SELECT DISTINCT `Description`, COUNT(*) AS qntd
FROM gas_emissions
GROUP BY `Description`;
-- A maioria varia entre 8 e 5 em questão de quantidade

SELECT COUNT(DISTINCT description) FROM gas_emissions;
-- Ao todo são 17 descrições diferentes

SELECT `Type`, Scope, COUNT(*) AS qntd
FROM gas_emissions
GROUP BY `Type`, Scope;

-- Observabdo a tabela de datação de carbono e fatores de normalização
DESCRIBE carbon_footprints;
SELECT COUNT(*) FROM carbon_footprints;
SELECT * FROM carbon_footprints;

DESCRIBE normalizing_factors;
SELECT COUNT(*) FROM normalizing_factors;
SELECT * FROM normalizing_factors;


/* Sendo tebelas pequenas, a maioria das validações
podem ser feitas a partir de observação. */

SELECT * FROM gas_emissions;

SELECT * FROM data_dictionary;