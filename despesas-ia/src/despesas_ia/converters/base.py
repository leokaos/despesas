from abc import ABC, abstractmethod
from dataclasses import dataclass
from datetime import datetime
from decimal import Decimal
import re

@dataclass
class Comprovante:
    data: datetime
    valor: Decimal
    descricao: str

class ConverterComprovante(ABC):
    
    @abstractmethod
    def extrair(self, arquivo_bytes: bytes):
        pass
    
    def _construir_comprovante(self, texto: str) -> Comprovante:
        data_pattern = r'(\d{2}[-/]\d{2}[-/]\d{2,4})'
        valor_pattern = r'(\d{1,3}(?:[\. ]?\d{3})*,\d{2})'
        
        datas = re.findall(data_pattern, texto)
        valores = re.findall(valor_pattern, texto)
        
        # Processa data
        data = None
        if datas:
            data_raw = datas[0]
            partes = re.split(r'[-/]', data_raw)
            dia = int(partes[0])
            mes = int(partes[1])
            ano = int(partes[2])
            if ano < 100:
                ano = 2000 + ano
            data = datetime(ano, mes, dia)
        
        # Processa valor
        valor = None
        if valores:
            valor_str = valores[0].replace(' ', '').replace('.', '').replace(',', '.')
            valor = Decimal(valor_str)
        
        # Processa descricao
        linhas = texto.split('\n')
        descricao = "Nao encontrado"
        for linha in linhas:
            linha_limpa = linha.strip()
            if len(linha_limpa) > 10:
                descricao = linha_limpa
                break
        
        return Comprovante(data, valor, descricao)