from PIL import Image
import pytesseract
from io import BytesIO
from .base import ConverterComprovante, Comprovante

class ConverterImagem(ConverterComprovante):
    
    def extrair(self, arquivo_bytes: bytes) -> Comprovante:
        print(f"Tamanho: {len(arquivo_bytes)}")
        print(f"Primeiros 10 bytes: {arquivo_bytes[:10]}")
        imagem = Image.open(BytesIO(arquivo_bytes))
        imagem = imagem.convert('L')
        texto = pytesseract.image_to_string(imagem, lang='por')
        return self._construir_comprovante(texto)