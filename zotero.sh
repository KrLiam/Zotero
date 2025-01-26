#!/bin/bash

# Cria o atalho da linha de comando
SH_PATH=$(realpath "$0")
if [ ! -f ~/.bash_aliases ] || ! grep -q "^alias zotero" ~/.bash_aliases; then
  echo alias zotero="\"${SH_PATH}\"" >> ~/.bash_aliases
  echo alias zotero="\"${SH_PATH}\"" >> ~/.bashrc
fi

# Mudar cwd para diretório do repositório
cd $(dirname "$0")

# Baixar arquivos do Zotero se ainda não disponíveis
if [ ! -f ./zotero ]; then
  curl -L -o ./zotero.tar.bz2 "https://www.zotero.org//download/client/dl?channel=release&platform=linux-x86_64&version=7.0.11"
  tar -xvjf zotero.tar.bz2 -C . --strip-components=1
  rm zotero.tar.bz2
fi

# Renomear pastas dentro de "storage" para o nome do arquivo PDF contido nelas
STORAGE_DIR="./storage"
if [ -d "$STORAGE_DIR" ]; then
  for folder in "$STORAGE_DIR"/*; do
    if [ -d "$folder" ]; then
      pdf_file=$(find "$folder" -maxdepth 1 -type f -name "*.pdf" | head -n 1)
      if [ -n "$pdf_file" ]; then
        pdf_name=$(basename "$pdf_file" .pdf)
        parent_dir=$(dirname "$folder")
        new_folder="$parent_dir/$pdf_name"
        if [ "$folder" != "$new_folder" ]; then
          mv "$folder" "$new_folder"
          echo "Renomeado: $folder -> $new_folder"
        fi
      fi
    fi
  done
fi

# Buscar por atualizações no repositório remoto
git pull

# Executar Zotero
./zotero

# Subir as mudanças para o GitHub
if [[ `git status --porcelain` ]]; then
  # Gambiarra para comitar apenas a pasta storage e os zotero.sqlite's
  ls -1 | grep -Ev "storage|zotero.sqlite" > .gitignore
  git add .
  git commit -m "atualiza dados"
  git push
fi

