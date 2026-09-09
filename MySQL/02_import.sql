/* IMPORTAÇÃO DAS TABELAS
========================================= */

/*Após a criação do banco de dados, as tabelas foram importadas utilizando o assistente de importação do 'MySQL Workbench'.
1. No painel 'Schemas', clique com o botão direito sobre 'Tables' e selecione 'Table Data Import Wizard'.
2. Selecione o arquivo .csv correspondente à tabela que será importada.
3. Escolha a opção 'Create a new table' e marque 'Drop table if exists', garantindo a substituição da tabela caso ela já exista.
4. Defina a codificação (Encoding) como UTF-8 e mantenha selecionadas todas as colunas para importação.
5. Confirme a operação e aguarde a conclusão do processo.
6. Repita os mesmos passos para as demais tabelas do projeto. */

/*As tabelas importadas foram:
greenhouse_gas_emissions.csv
carbon_footprint_by_product.csv
normalizing_factors.csv data_dictionary.csv*/

/* ✏️ Note-se que o nome das tabelas podem se diferir ao longo do projeto! 
A alteração foi feita para manter o código mais limpo, sem causar ambiguidade.*/

SELECT * FROM data_dictionary;