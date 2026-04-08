from ..converters.base import ConverterComprovante, Comprovante
from ..converters.pdf_converter import ConverterPDF
from ..converters.imagem_converter import ConverterImagem

class ConversorService:
    
    def __init__(self):
        self.converters = {
            'application/pdf': ConverterPDF(),
            'image/jpeg': ConverterImagem(),
            'image/png': ConverterImagem(),
        }
    
    def extrair(self, arquivo_bytes: bytes, content_type: str) -> Comprovante:
        if content_type not in self.converters:
            raise ValueError(f"Tipo de arquivo nao suportado: {content_type}")
        
        converter = self.converters[content_type]
        return converter.extrair(arquivo_bytes)