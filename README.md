# Zotero

Este template facilita a sincronização dos arquivos de uma instalação local do Zotero utilizando o GitHub como serviço de
armazenamento em nuvem.

## Compatibilidade
* Ubuntu
* Linux Mint
* Possivelmente outras distros do linux (talvez necessite de ajustes)

## Instalação

Primeiramente, crie um repositório para uso pessoal a partir deste template (clique no botão "Usar este template" acima). Após isso, clone o repositório em sua máquina local. A pasta raiz do repositório deverá ser a pasta `~/Zotero`:

```sh
rm -r ~/Zotero                      # garantir que a pasta ~/Zotero não existe
git clone <url-do-seu-repositorio>
mv <seu-repositorio> ~/Zotero
```

Após executar os comandos acima, você deverá ter algo semelhante a isto:

```sh
home/Usuario/
    Zotero/ # O repositório
        .gitignore
        README.md
        zotero.sh
        ... # Arquivos que serão gerados pelo Zotero
```

Para executar pela primeira vez, execute o shellscript diretamente.

```sh
~/Zotero/zotero.sh
```

Isso baixará todos os arquivos do Zotero automaticamente e abrirá o programa. Após a primeira execução,
um atalho poderá ser usado para iniciar o Zotero (talvez seja necessário reabrir o terminal):

```sh
zotero
```

Este atalho executa o shellscript apresentado acima. Antes de iniciar o Zotero, o script executa um `git pull`
para baixar os arquivos remotos atualizados. Após terminar de usar o Zotero, feche o programa normalmente e
as mudanças serão salvas no seu repositório do GitHub automaticamente.

Evite deixar o Zotero aberto em mais de um dispositivo ao mesmo tempo, visto que isto pode ocasionar
em conflitos se múltiplas sessões realizarem alterações em paralelo.
