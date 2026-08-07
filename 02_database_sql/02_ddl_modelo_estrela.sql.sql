USE bi_agro;

-- DIMENSÃO TEMPO
DROP TABLE IF EXISTS dim_tempo;
CREATE TABLE dim_tempo (
    id_tempo INT AUTO_INCREMENT PRIMARY KEY,
    ano_agricola VARCHAR(20) NOT NULL
);

-- DIMENSÃO PRODUTO
DROP TABLE IF EXISTS dim_produto;
CREATE TABLE dim_produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL
);

-- DIMENSÃO LOCALIDADE
DROP TABLE IF EXISTS dim_localidade;
CREATE TABLE dim_localidade (
    id_localidade INT AUTO_INCREMENT PRIMARY KEY,
    uf VARCHAR(2) NOT NULL
);

-- TABELA DIMENSÃO FENOMENO
DROP TABLE IF EXISTS dim_fenomeno;
CREATE TABLE dim_fenomeno (
    id_fenomeno INT AUTO_INCREMENT PRIMARY KEY,
    ano_agricola VARCHAR(10) NOT NULL,
    fenomeno_global VARCHAR(20),
    impacto_esperado VARCHAR(50)
);

-- FATO PRODUÇÃO
DROP TABLE IF EXISTS fato_producao;
CREATE TABLE fato_producao (
    id_fato_producao INT AUTO_INCREMENT PRIMARY KEY,
    id_tempo INT,
    id_produto INT,
    id_localidade INT,
    area_plantada_ha DECIMAL(15,2),
    producao_t DECIMAL(15,2),
    produtividade_kg_ha DECIMAL(10,2),
    FOREIGN KEY (id_tempo) REFERENCES dim_tempo(id_tempo),
    FOREIGN KEY (id_produto) REFERENCES dim_produto(id_produto),
    FOREIGN KEY (id_localidade) REFERENCES dim_localidade(id_localidade)
);

-- FATO CLIMA
DROP TABLE IF EXISTS fato_clima;
CREATE TABLE fato_clima (
    id_fato_clima INT AUTO_INCREMENT PRIMARY KEY,
    data_medicao DATE NOT NULL,
    chuva_mm DECIMAL(10,2),
    temp_max DECIMAL(10,2),
    temp_min DECIMAL(10,2),
    evapotranspiracao DECIMAL(10,2),
    radiacao_solar DECIMAL(10,2)
);