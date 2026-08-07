USE bi_agro;

-- PREENCHIMENTO DA DIMENSÃO DE SAFRA
INSERT INTO dim_tempo (ano_agricola)
SELECT DISTINCT ano_agricola 
FROM stg_safra 
WHERE ano_agricola IS NOT NULL;

-- PREENCHIMENTO DA DIMENSÃO DE PRODUTO
INSERT INTO dim_produto (nome_produto)
SELECT DISTINCT produto 
FROM stg_safra 
WHERE produto IS NOT NULL;

-- PREENCHIMENTO DA DIMENSÃO DE LOCALIDADE
INSERT INTO dim_localidade (uf)
SELECT DISTINCT uf 
FROM stg_safra 
WHERE uf IS NOT NULL;

-- PREENCHIMENTO DA DIMENSÃO DE FENOMENO
INSERT INTO dim_fenomeno (ano_agricola, fenomeno_global, impacto_esperado)
SELECT DISTINCT 
	ano_agricola, 
	fenomeno_global, 
	impacto_esperado
FROM stg_fenomeno
WHERE ano_agricola IS NOT NULL;

-- PREENCHIMENTO DO FATO PRODUÇÂO
INSERT INTO fato_producao (id_tempo, id_produto, id_localidade, area_plantada_ha, producao_t, produtividade_kg_ha)
SELECT 
    t.id_tempo, 
    p.id_produto, 
    l.id_localidade, 
    (s.area_plantada * 1000) AS area_plantada_ha,
    (s.producao * 1000) AS producao_t,
    (s.produtividade * 1000) AS produtividade_kg_ha
FROM stg_safra s
JOIN dim_tempo t ON s.ano_agricola = t.ano_agricola
JOIN dim_produto p ON s.produto = p.nome_produto
JOIN dim_localidade l ON s.uf = l.uf;

-- PREENCHIMENTO DO FATO CLIMA
INSERT INTO fato_clima (data_medicao, chuva_mm, temp_max, temp_min, evapotranspiracao, radiacao_solar)
SELECT 
	DT_MEDICAO, 
	CHUVA, 
	TEMP_MAX, 
	TEMP_MIN, 
	EVAPOTRANSPIRACAO, 
	RADIACAO_SOLAR
FROM stg_clima
WHERE DT_MEDICAO IS NOT NULL;

-- VALIDAÇÂO
SELECT 'dim_fenomeno' AS Tabela, COUNT(*) AS Registros FROM dim_fenomeno
UNION ALL
SELECT 'fato_clima', COUNT(*) FROM fato_clima
UNION ALL
SELECT 'fato_producao', COUNT(*) FROM fato_producao;