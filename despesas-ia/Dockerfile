FROM python:3.12-slim

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-por \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia os arquivos de dependências primeiro (melhor cache)
COPY pyproject.toml uv.lock ./

# Instala uv e as dependências Python
RUN pip install uv && \
    uv sync --no-dev

# Copia o código fonte
COPY src/ ./src/

# Expõe a porta
EXPOSE 8080

# Comando para rodar a API
CMD ["uv", "run", "uvicorn", "src.despesas_ia.api.endpoints:app", "--host", "0.0.0.0", "--port", "8080"]