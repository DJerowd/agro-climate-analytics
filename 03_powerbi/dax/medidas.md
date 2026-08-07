# Documentação das Medidas DAX - Projeto Agro-Climate

Este documento detalha as principais expressões DAX criadas no modelo de dados do Power BI.

## 1. Medidas Base (Produção)
Para garantir flexibilidade nos cruzamentos (e evitar o uso de medidas implícitas), os cálculos de produtividade foram explícitos.

### Produtividade Real
Calcula a produtividade média (Kg por hectare) da safra selecionada.
```dax
Produtividade_Real = 
DIVIDE(
    SUM(fato_producao[producao_t]), 
    SUM(fato_producao[area_plantada_ha]),
    0
)
```

## 2. Medidas Climáticas (Agrometeorologia)

### Saldo Hídrico
Calcula o balanço entre a entrada de água (chuva) e a perda de água para a atmosfera (evapotranspiração).
```dax
Saldo_Hidrico = 
SUM(fato_clima[chuva_mm]) - SUM(fato_clima[evapotranspiracao])
```

## 3. Medidas de Inteligência (Impacto ENSO)
Calculam o peso financeiro/produtivo que os fenômenos El Niño e La Niña causaram à cooperativa.

### Produtividade Base (Cenário Neutro)
Isola o comportamento da produtividade apenas nos anos em que não houve anomalias climáticas.
```dax
Produtividade_Base_Neutro = 
CALCULATE(
    [Produtividade_Real], 
    dim_fenomeno[fenomeno_global] = "Neutro"
)
```

### Impacto do Fenômeno (%)
Calcula a variação percentual da safra atual contra o cenário base (Neutro).
```dax
Impacto_Fenomeno_Perc = 
DIVIDE(
    [Produtividade_Real] - [Produtividade_Base_Neutro], 
    [Produtividade_Base_Neutro],
    0
)
```

## 4. Medidas de Storytelling (Narrativa UI)
Trazem inteligência à interface, fazendo o painel "conversar" com o usuário.

### Texto Contexto Clima
Gera uma frase dinâmica com base no ano agrícola selecionado pelo usuário no filtro.
```dax
Texto_Contexto_Clima = 
VAR Safra = SELECTEDVALUE(dim_tempo[ano_agricola], "Todas as Safras")
VAR Fenomeno = SELECTEDVALUE(dim_fenomeno[fenomeno_global], "Múltiplos Cenários")
VAR Impacto = SELECTEDVALUE(dim_fenomeno[impacto_esperado], "Selecione um ano para ver o contexto")

RETURN
"Contexto da Safra " & Safra & ": " & Fenomeno & " (" & Impacto & ")."
```