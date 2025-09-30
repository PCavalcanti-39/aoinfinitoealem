# Projeto de Pipeline de Taxas de Cambio com Enriquecimento LLM
**Aluno:** Priscilla Cavalcanti de Almeida  
**Descricao:** Este projeto realiza o processo completo de ingestao, transformacao, carga e enriquecimento de dados de taxas de cambio obtidas via API publica, aplicando conceitos de engenharia de dados (camadas Raw/Silver/Gold) e geracao de insights automaticos com modelo LLM (ChatGPT).

---

## Arquitetura do Projeto

```
/content
raw/       → Armazena os dados brutos em JSON (Ingest)
silver/    → Dados tratados e normalizados (Transform)
gold/      → Dados finais consolidados (Load)
gold/insights/ → Resumos e analises automaticas geradas pela LLM
```

---

## Etapa 1 – Ingestao (Coleta de Dados da API)

O script coleta as taxas de cambio da API `https://v6.exchangerate-api.com` e armazena os dados brutos (RAW) em formato JSON com nomeacao baseada na data atual.

### Codigo:
```python
import requests
import json
from datetime import datetime
from pathlib import Path

# Configuracao da API
API_KEY = "b504fc0b61276b0453c2db85"
BASE_CURRENCY = "USD"
RAW_DIR = Path("raw")
RAW_DIR.mkdir(exist_ok=True)

# Monta URL da API
url = f"https://v6.exchangerate-api.com/v6/{API_KEY}/latest/{BASE_CURRENCY}"

# Requisição
try:
    response = requests.get(url, timeout=30)
except requests.RequestException as e:
    print("Erro de conexão:", e)
    exit()

# Tratamento da resposta
if response.status_code == 200:
    data = response.json()
    if data.get("result") == "success":
        today = datetime.today().strftime("%Y-%m-%d")
        file_path = RAW_DIR / f"{today}.json"
        with open(file_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2, ensure_ascii=False)
        print(f"Dados salvos com sucesso em: {file_path}")
    else:
        print("Erro na API:", data)
else:
    print("Erro de conexão HTTP:", response.status_code)
```

---

## Etapa 2 – Transformação (Normalização e Limpeza)

Nesta etapa, os arquivos brutos são normalizados, convertendo a estrutura JSON em **DataFrame Pandas**. São aplicadas validações para remover valores inválidos, duplicados e formatar os tipos de dados.

### Código:
```python
from pathlib import Path
from datetime import datetime
import json
import pandas as pd
import sys, subprocess

BASE_DIR = Path("/content")
RAW_DIR = BASE_DIR / "raw"
SILVER_DIR = BASE_DIR / "silver"
GOLD_DIR = BASE_DIR / "gold"

for d in [RAW_DIR, SILVER_DIR, GOLD_DIR]:
    d.mkdir(parents=True, exist_ok=True)

# Localiza o arquivo mais recente da camada RAW
raw_files = sorted(RAW_DIR.glob("*.json"))
raw_file = raw_files[-1]

# Carrega o JSON
with open(raw_file, "r", encoding="utf-8") as f:
    data = json.load(f)

base_currency = data.get("base_code") or "USD"
rates = data.get("conversion_rates", {})

records = [
    {"base_currency": base_currency, "moeda": m, "taxa": float(t), "timestamp": datetime.utcnow().isoformat()}
    for m, t in rates.items() if isinstance(t, (int, float)) and t > 0
]

df = pd.DataFrame(records).drop_duplicates(subset=["base_currency", "moeda", "timestamp"])

# Salva em JSON (Silver)
today = datetime.today().strftime("%Y-%m-%d")
silver_file = SILVER_DIR / f"{today}.json"
df.to_json(silver_file, orient="records", indent=2, force_ascii=False)

# Salva em Parquet (Gold)
gold_file = GOLD_DIR / f"{today}.parquet"
try:
    df.to_parquet(gold_file, index=False, engine="pyarrow")
except Exception:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-q", "pyarrow"])
    df.to_parquet(gold_file, index=False, engine="pyarrow")
```

---

## Etapa 3 – Carga (Load)

Carrega os dados transformados da camada **Silver** e grava o resultado final em **Parquet** na camada **Gold**.

### Código:
```python
import pandas as pd
from pathlib import Path
from datetime import datetime

SILVER_DIR = Path("silver")
GOLD_DIR = Path("gold")
GOLD_DIR.mkdir(exist_ok=True)

silver_files = sorted(SILVER_DIR.glob("*.json"))
silver_file = silver_files[-1]

df = pd.read_json(silver_file)

today = datetime.today().strftime("%Y-%m-%d")
gold_file = GOLD_DIR / f"{today}.parquet"

df.to_parquet(gold_file, engine="pyarrow", index=False)

print(f"Dados finais gravados em: {gold_file}")
print(f"Total de registros: {len(df)}")
```

---

## Etapa 4 – Enriquecimento com LLM (ChatGPT)

Nesta etapa, o modelo **GPT-4o-mini** gera um resumo executivo das variações cambiais diárias e mensais das 5 principais moedas frente ao real (BRL).

### Dependências:
```bash
pip install python-dotenv pyarrow openai
```

---

## Tecnologias Utilizadas
| Componente | Função |
|-------------|---------|
| **Python** | Linguagem principal |
| **Pandas** | Manipulação e normalização de dados |
| **PyArrow** | Conversão para Parquet |
| **Requests** | Consumo da API de câmbio |
| **OpenAI (GPT-4o-mini)** | Geração de insights |
| **dotenv** | Gestão segura de variáveis (.env) |
| **Chatgpt**| Ajuda na codificação e processos|

---

## Aluno:
**Priscilla Cavalcanti de Almeida**  
Trabalho Python Programming for Data Engineers – 2025 - MBA DE_07  
priscilla.almeida@aluno.faculdadeimpacta.com.br
