import pandas as pd
import requests
import sys

def extrair_dados_clima():
    # Parâmetros da Extração
    latitude = -24.0461
    longitude = -52.3838
    data_inicio = "2015-01-01"
    data_fim = "2025-12-31"

    # Endpoint da API Open-Meteo
    url_clima = (
        f"https://archive-api.open-meteo.com/v1/archive?"
        f"latitude={latitude}&longitude={longitude}&"
        f"start_date={data_inicio}&end_date={data_fim}&"
        f"daily=precipitation_sum,temperature_2m_max,temperature_2m_min,"
        f"et0_fao_evapotranspiration,shortwave_radiation_sum&"
        f"timezone=America%2FSao_Paulo"
    )
    print("Consultando histórico climático do Open-Meteo...")
    response = requests.get(url_clima)

    if response.status_code == 200:
        dados = response.json()
        df_clima_bruto = pd.DataFrame(dados['daily'])
        print(f"Extração concluída! {len(df_clima_bruto)} registros obtidos.")
  
        # Transformação e Limpeza
        df_clima = df_clima_bruto.copy()
        df_clima.rename(columns={
            'time': 'DT_MEDICAO',
            'precipitation_sum': 'CHUVA',
            'temperature_2m_max': 'TEMP_MAX',
            'temperature_2m_min': 'TEMP_MIN',
            'et0_fao_evapotranspiration': 'EVAPOTRANSPIRACAO',
            'shortwave_radiation_sum': 'RADIACAO_SOLAR'
        }, inplace=True)

        # Tratamento dos tipos numericos
        df_clima.fillna(0, inplace=True)

        print(f"{len(df_clima)} registros diários processados e formatados com sucesso.")
        print(df_clima.head())

        # Carga
        caminho_arquivo_clima = 'Dados_Clima_Openmeteo.csv'
        df_clima.to_csv(caminho_arquivo_clima, sep=';', index=False)
        print(f"Arquivo salvo localmente como: {caminho_arquivo_clima}\n")
    else:
        print(f"Erro na API (Status: {response.status_code}).")
        sys.exit(1)

def gerar_dimensao_enso():
    print("⏳ Gerando dados da dimensão de Fenômenos Climáticos (ENSO)...")
    enso_data = {
        'ano_agricola': ['2019/20', '2020/21', '2021/22', '2022/23', '2023/24', '2024/25'],
        'fenomeno_global': ['Neutro', 'La Nina', 'La Nina', 'La Nina', 'El Nino', 'La Nina'],
        'impacto_esperado': ['Normalidade', 'Risco de Seca Severa', 'Risco de Seca Severa', 'Risco de Seca Moderada', 'Chuvas Acima da Media', 'Risco de Seca Moderada']
    }

    df_enso = pd.DataFrame(enso_data)
    print(df_enso.head())

    caminho_arquivo_fenomenos = 'Dados_Fenomenos_Openmeteo.csv'
    df_enso.to_csv(caminho_arquivo_fenomenos, sep=';', index=False, encoding='utf-8-sig')
    print(f"Arquivo salvo localmente como: {caminho_arquivo_fenomenos}\n")

if __name__ == "__main__":
    print("--- INICIANDO PIPELINE DE CLIMA ---")
    extrair_dados_clima()
    gerar_dimensao_enso()
    print("--- PIPELINE CONCLUÍDO ---")