/* ANÁLISE EXPLORATÓRIA
 Conhecendo as Tabelas
========================================= */

SELECT * FROM gas_emissions;

-- Visualização das emissões anuais
SELECT `Fiscal Year`, SUM(Emissions) AS emissoes_anuais
FROM gas_emissions
GROUP BY `Fiscal Year`
ORDER BY `Fiscal Year` ASC;

/* Aqui podemos ver as emissões anuais, que ao ordená-las, e possíveis verificar
que as emissões têm diminuído na maioria dos anos do períoco analisado*/

-- Visualização das emissões por categoria
SELECT category, SUM(emissions) AS emissoes_categoria,
ROUND(
	SUM(emissions) * 100 /
    (SELECT SUM(emissions) FROM gas_emissions),
    2 ) AS percentual 
FROM gas_emissions
GROUP BY category;

/*Aqui pode ser visto o percentual das emissões, evidenciando que a maioria
das emissões são provenientes do ciclo de vida do produto */

-- Visualização das emissões por tipo
SELECT `Type`, SUM(emissions) AS total_emissoes
FROM gas_emissions
GROUP BY `Type`;

/*Então houve remoção de carbono*/
SELECT `Fiscal Year`, SUM(emissions) AS remocoes
FROM gas_emissions
WHERE `Type` = 'Carbon removals' AND emissions < 0
GROUP BY `Fiscal Year` 
ORDER BY remocoes DESC;

/* Então os anos em que a empresa fez a remoção de carbono foram 2020, 2021 e 2022.
Sendo em 2021 quando houve a maior remoção. */

-- Observando as emissões por escopos
-- Os escopos apresentam diferentes núcleos das emissões de carbono da empresa

SELECT `Fiscal Year`,
	SUM(CASE WHEN Scope = 'Scope 1' THEN Emissions END) AS Scope1,
	SUM(CASE WHEN Scope = 'Scope 2 (market-based)' THEN Emissions END) AS Scope2,
	SUM(CASE WHEN Scope = 'Scope 3' THEN Emissions END) AS Scope3
FROM gas_emissions
GROUP BY `Fiscal Year`
ORDER BY `Fiscal Year`;

/* A conclusão que podemors extrair dessa consulta é o alto nível
de emissão de gases das ações do escopo 3. */

-- Verificando emissões por descrições das emissões
SELECT SUM(Emissions) AS total_emissoes, `Description`
FROM gas_emissions
GROUP BY `Description`
ORDER BY total_emissoes DESC;

/* Aqui podemos ver as operações (descrições) que geram
mais emissões de gases do efeito estufa. Sendo MANUFATURA 
a mais poluentes, seguida por USO DO PRODUTO e TRANSPORTE. */

SELECT `Description`, `Fiscal Year`, SUM(Emissions) AS total_emissoes
FROM gas_emissions
GROUP BY `Description`, `Fiscal Year`
ORDER BY `Description`;

/*Essa consulta permiti visualizar as emissões por ano e Descrição. 
Embora fiquemos com uma tabela extensa, podemos verificar as emissões ao
longo do período análisado por grupo. Onde podemos ver que algumas Descrições
como: GÁS NATURAL, PROCESSAMENTO DE FIM DE VIDA ÚTIL, FROTA DE VEÍCULOS, 
entre outros, apresentaram aumentos nas emissões. */

-- Análise das datações de Carbono dos produtos
SELECT `Release Year`, `Carbon Footprint`
FROM carbon_footprints
ORDER BY `Release Year` ASC;

/*Segundo o que podemos observar nessa tabela, ao longo dos anos, 
as pegadas de carbono a cada produto lançado têm diminuído, com destaque
para o período pós 2019, que consolidou uma diminuiçaõ contínua. */ 

SELECT `Baseline storage`,
ROUND(AVG(`Carbon Footprint`), 1) AS media_pegadasCO2
FROM carbon_footprints
GROUP BY `Baseline storage`;

/* Embora tenha ocorrido um aumento na capacidade de armazenamento
dos aparelhos, os modelos com com mais memória apresentaram uma média 
menor se comparado a modelos com capacidade inferior. Isso nos leva a 
acreditar que é possível o avanço da tecnologia (armazenamento) sem 
necessariamentar aumentar as emissões de carbono. */

-- Análise dos Fatores de Normalização
SELECT `Fiscal Year`, Revenue, `Market Capitalization`
FROM normalizing_factors
ORDER BY `Fiscal Year` ASC;

/* Através da análise dos Fatores de Normalização podemos comparar
A Receita e o Valor de Mercado, que, ao  julgar os dados, podemos 
observar que todos tiveram aumnentos mensuráveis ao longo dos anos,
apesar das quedas nas emissões de carbono como visto anteriormente . */

-- Comparação entre crescimento econômico e emissões de carbono
SELECT nf.`Fiscal Year`, nf.Revenue, nf.`Market Capitalization`,
SUM(ge.Emissions) AS total_emissoes
FROM normalizing_factors AS nf
INNER JOIN gas_emissions AS ge
ON ge.`Fiscal Year` = nf.`Fiscal Year`
GROUP BY nf.`Fiscal Year`, nf.Revenue, nf.`Market Capitalization`
ORDER BY nf.`Fiscal Year` ASC;

/* Com essa consulta podemos comparar os dados diretamente os dados de normalização 
e o total de emissões, que, segundo a tabela, não influenciam diretamente um ao outro, 
pois enquanto as emissões diminuem, a receita e o valor de mercado sobem. */