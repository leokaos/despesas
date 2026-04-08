from abc import ABC, abstractmethod
from dataclasses import dataclass

@dataclass
class Comprovante:
    data: str
    valor: str
    descricao: str

class ConverterComprovante(ABC):
    
    @abstractmethod
    def extrair(self, arquivo_bytes: bytes) -> Comprovante:
        pass