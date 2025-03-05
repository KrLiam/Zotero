#!/bin/bash -e


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


APPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -w "$APPDIR"/zotero.desktop ]; then
	sed -i -e "s@^Exec=.*@Exec=$APPDIR/zotero.sh %U@" \
           -e "s@^Icon=.*@Icon=$APPDIR/icons/icon128.png@" "$APPDIR"/zotero.desktop
    
    sudo ln -s "$APPDIR"/zotero.desktop /usr/share/applications/zotero.desktop
else
	echo "$APPDIR"/zotero.desktop is not writable
	exit 1
fi