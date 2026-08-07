CREATE DATABASE IF NOT EXISTS bi_agro;
USE bi_agro;

-- STAGING SAFRA
DROP TABLE IF EXISTS stg_safra;
CREATE TABLE stg_safra (
	ano_agricola VARCHAR(20),
    dsc_safra_previsao VARCHAR(50),
    uf VARCHAR(2),
    produto VARCHAR(100),
    id_produto VARCHAR(20),
    area_plantada DECIMAL(15,2),
    producao DECIMAL(15,2),
    produtividade DECIMAL(15,4)
);

-- STAGING CLIMA
DROP TABLE IF EXISTS stg_clima;
CREATE TABLE stg_clima (
    DT_MEDICAO DATE,
    CHUVA DECIMAL(10,2),
    TEMP_MAX DECIMAL(10,2),
    TEMP_MIN DECIMAL(10,2),
    EVAPOTRANSPIRACAO DECIMAL(10,2),
    RADIACAO_SOLAR DECIMAL(10,2)
);

-- STAGING FENOMENO
DROP TABLE IF EXISTS stg_fenomeno;
CREATE TABLE stg_fenomeno (
    ano_agricola VARCHAR(10),
    fenomeno_global VARCHAR(20),
    impacto_esperado VARCHAR(50)
);