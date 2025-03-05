#!/bin/bash

# Mudar cwd para diretório do repositório
cd $(dirname "$0")

# Instala o zotero
if [ ! -f ./install.lock ]; then
  source install.sh
  touch install.lock
fi

# Buscar por atualizações no repositório remoto
git pull

# Executar Zotero
./zotero

# Renomear pastas dentro de "storage" para o nome do arquivo PDF contido nelas
#STORAGE_DIR="./storage"
#if [ -d "$STORAGE_DIR" ]; then
#  for folder in "$STORAGE_DIR"/*; do
#    if [ -d "$folder" ]; then
#      pdf_file=$(find "$folder" -maxdepth 1 -type f -name "*.pdf" | head -n 1)
#      if [ -n "$pdf_file" ]; then
#        pdf_name=$(basename "$pdf_file" .pdf)
#        parent_dir=$(dirname "$folder")
#        new_folder="$parent_dir/$pdf_name"
#        if [ "$folder" != "$new_folder" ]; then
#          mv "$folder" "$new_folder"
#          echo "Renomeado: $folder -> $new_folder"
#        fi
#      fi
#    fi
#  done
#fi

# Subir as mudanças para o GitHub
if [[ `git status --porcelain` ]]; then
  # Gambiarra para comitar apenas a pasta storage e os zotero.sqlite's
  ls -1 | grep -Ev "storage|zotero.sqlite" > .gitignore
  git add .
  git commit -m "atualiza dados"
  git push
fi

