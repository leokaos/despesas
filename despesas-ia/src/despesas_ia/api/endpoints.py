from fastapi import FastAPI, File, UploadFile
from ..services.conversor_service import ConversorService

app = FastAPI(title="despesas-ia")
service = ConversorService()

@app.post("/")
async def extrair(arquivo: UploadFile = File(...)):
    bytes_arquivo = await arquivo.read()
    content_type = arquivo.content_type
    
    comprovante = service.extrair(bytes_arquivo, content_type)
    
    return {
        "data": comprovante.data,
        "valor": comprovante.valor,
        "descricao": comprovante.descricao
    }

@app.get("/health")
async def health():
    return {"status": "ok"}