from pdf2image import convert_from_bytes
import pytesseract
from .base import ConverterComprovante, Comprovante

class ConverterPDF(ConverterComprovante):
    
    def extrair(self, arquivo_bytes: bytes) -> Comprovante:
        paginas = convert_from_bytes(arquivo_bytes, dpi=300)
        texto = pytesseract.image_to_string(paginas[0], lang='por')
        return self._construir_comprovante(texto)