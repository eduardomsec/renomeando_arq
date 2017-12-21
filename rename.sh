#!/bin/bash

# Script para buscar arquivos com caracteres maiusculos
# e renomeia para minusculos, independente dos 
# subdiretorios.
#
# Utilização:
# ./rename.sh
#   ~# Entre com o caminho:
#   ~# /tmp/foo
#
# O script irá renomear TODOS os arquivos e subdiretorios
# OBS: O diretorio Pai não será modificado
#
# borrachinha, 21/12/2017
#
#

# Variaveis
pastas="/tmp/pastas"
arquivo="/tmp/arq"
arq_pastas="/tmp/arq_pastas"

# Zerando arquivos
> ${pastas}; > ${arquivo}; > ${arq_pastas}

# Renomeando arquivos
echo "Entre com o caminho: "; read path

find ${path} -maxdepth 1 -type f > ${arquivo}

while read arq; do
	mv -v "$arq" "$(echo $arq | tr 'A-Z' 'a-z')"
done < ${arquivo}

# Renomeando pastas
find ${path} -type d | sed '1d' > ${pastas}

while read pasta; do
	pasta_minusculo="$(echo $pasta | tr 'A-Z' 'a-z')"
	mv -v "$pasta" "$pasta_minusculo"
	find ${pasta_minusculo} -maxdepth 1 -type f >> ${arq_pastas}
done < $pastas

# Renomeando arquivos contidos nas pastas
while read arq; do
	mv -v "$arq" "$(echo $arq | tr 'A-Z' 'a-z')"
done < ${arq_pastas}

# Apagando arquivos
rm -f ${pastas} ${arquivo} ${arq_pastas}
