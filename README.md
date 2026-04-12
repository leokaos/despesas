# BUILD

`mvnw versions:set -DnewVersion={newVersion}`

Faz o bump da versão

`mvnw clean install -P prod`

Faz o build da aplicação EAR e Angular

`git add . && git push`

Finaliza a versão com os pacotes e versão atual

`mvnw clean deploy`

No módulo despesas-image, gera a imagem docker e faz o push para hub