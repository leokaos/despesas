
# Cria o container e anexa o volume no diretório atual
`docker run --rm --name dev-python -it -p 8080:8080 -e UV_PROJECT_ENVIRONMENT=/tmp/.venv -v .:/app python:3.12-slim /bin/bash`

# Instala dependências do sistema (tesseract, poppler)
`apt-get update && apt-get install -y poppler-utils tesseract-ocr tesseract-ocr-por`

# Instala uv e dependências Python
`pip install uv`

`uv sync --no-dev`

# Roda a API
`uv run uvicorn src.despesas_ia.api.endpoints:app --host 0.0.0.0 --port 8080`