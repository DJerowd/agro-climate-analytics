# Inteligência de Safra e Análise Climática

> **Status do Projeto:** Em Desenvolvimento

## Sobre o Projeto
Este projeto é uma solução de Engenharia de Dados e Business Intelligence focada no setor Agroindustrial. O objetivo principal é correlacionar dados históricos de produção agrícola (soja e milho) no estado do Paraná com variáveis climáticas de precisão e fenômenos climáticos globais.

## Arquitetura da Solução (Atual e Planejada)
A arquitetura foi desenhada para simular um ecossistema corporativo real:

- **Extração e Transformação (ETL):** Scripts em Python (`pandas`, `requests`) consumindo a API histórica do Open-Meteo.
- **Armazenamento:** Banco de Dados Relacional MySQL (Modelagem Star Schema com tabelas Fato e Dimensão).
- **Visualização:** Dashboard interativo em Power BI com análises cruzadas via DAX.

## Estrutura do Repositório
O projeto está modularizado para facilitar a manutenção e escalabilidade:

```text
agro-climate-analytics
 ┣ 01_extract_python  # Scripts de coleta de dados e tratamento (Pandas)
 ┣ 02_database_sql    # Scripts DDL e DML para criação do Data Warehouse (MySQL)
 ┣ 03_powerbi         # Arquivo .pbix, ícones SVG personalizados e DAX
 ┣ data_samples       # Amostras de dados (.csv) para testes locais
 ┣ .gitignore         # Regras de exclusão de arquivos não essenciais
 ┗ README.md          # Documentação principal