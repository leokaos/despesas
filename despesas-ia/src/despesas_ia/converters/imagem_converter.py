from PIL import Image
import pytesseract
import re
from io import BytesIO
from .base import ConverterComprovante, Comprovante

class ConverterImagem(ConverterComprovante):
    
    def extrair(self, arquivo_bytes: bytes) -> Comprovante:
        imagem = Image.open(BytesIO(arquivo_bytes))
        imagem = imagem.convert('L')
        texto = pytesseract.image_to_string(imagem, lang='por')
        return self._processar_texto(texto)
    
    def _processar_texto(self, texto: str) -> Comprovante:
        data_pattern = r'(\d{2}[-/]\d{2}[-/]\d{2,4})'
        valor_pattern = r'(\d{1,3}(?:[\. ]?\d{3})*,\d{2})'
        
        datas = re.findall(data_pattern, texto)
        valores = re.findall(valor_pattern, texto)
        
        data = "Nao encontrado"
        if datas:
            data_raw = datas[0]
            partes = re.split(r'[-/]', data_raw)
            if len(partes[2]) == 2:
                ano = 2000 + int(partes[2])
                data = f"{partes[0]}-{partes[1]}-{ano}"
            else:
                data = data_raw
        
        valor = "Nao encontrado"
        if valores:
            valor = valores[0].replace(' ', '')
        
        linhas = texto.split('\n')
        descricao = "Nao encontrado"
        for linha in linhas:
            linha_limpa = linha.strip()
            if len(linha_limpa) > 10:
                descricao = linha_limpa
                break
        
        return Comprovante(data, valor, descricao)