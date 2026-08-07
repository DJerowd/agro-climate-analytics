import pandas as pd
import os
import sys

def processar_dados_conab():
    caminho_entrada = 'SerieHistoricaGraos.txt'

    if not os.path.exists(caminho_entrada):
        print(f"Erro: O arquivo de entrada '{caminho_entrada}' não foi encontrado no diretório atual.")
        sys.exit(1)
    
    print(f"Lendo os dados brutos de {caminho_entrada}...")
    df_bruto = pd.read_csv(caminho_entrada, sep=';', encoding='latin1')
    print(f"Extração concluída. Total de linhas existentes: {len(df_bruto)}")

    # Limpeza e filtragem dos dados
    df_limpo = df_bruto.copy()
    df_limpo.columns = df_limpo.columns.str.strip()

    colunas_texto = ['ano_agricola', 'dsc_safra_previsao', 'uf', 'produto']
    for coluna in colunas_texto:
        if coluna in df_limpo.columns:
            df_limpo[coluna] = df_limpo[coluna].astype(str).str.strip()

    # Filtros de Região e Cultura
    df_limpo = df_limpo[df_limpo['uf'] == 'PR']
    culturas_alvo = ['SOJA', 'MILHO']
    df_limpo = df_limpo[df_limpo['produto'].str.contains('|'.join(culturas_alvo), na=False)]

    print(f"Linhas após filtragem por estado (PR) e cultura (Soja/Milho): {len(df_limpo)}")
    print(df_limpo.head())

    # Tratamento dos tipos numéricos
    colunas_numericas = ['area_plantada_mil_ha', 'producao_mil_t', 'produtividade_mil_ha_mil_t']
    for col in colunas_numericas:
        if col in df_limpo.columns:
            df_limpo[col] = pd.to_numeric(df_limpo[col], errors='coerce').fillna(0)

    print("\n📊 Estrutura final dos dados:")
    print(df_limpo.dtypes)

    # Carga
    caminho_saida = 'Dados_Safra_CONAB.csv'
    df_limpo.to_csv(caminho_saida, sep=';', encoding='utf-8', index=False)
    print(f"\nProcesso de ETL concluído. O arquivo está salvo em: {caminho_saida}")
    
if __name__ == "__main__":
    print("--- INICIANDO PIPELINE DE GRÃOS (CONAB) ---")
    processar_dados_conab()
    print("--- PIPELINE CONCLUÍDO ---")