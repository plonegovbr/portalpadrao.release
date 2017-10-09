#!/bin/bash
# Esse script gera um arquivo de versions das dependências sem extends.
# Acesse https://github.com/plonegovbr/portalpadrao.release/blob/master/README.md
# na seção "Por que versions.cfg e versions-sem-extends.cfg? Qual devo usar?"
# para entender a motivação desse script.

if [ $# -eq 0 ]; then
    echo "Preciso de um release como parâmetro. Ex: 1.1.5"
    echo "Esse script só foi testado para versões >= 1.1.5."
else
    portal_padrao_idg_release="$1"
    if git clone https://github.com/plonegovbr/portal.buildout.git /tmp/portal.buildout; then
        cd /tmp/portal.buildout || exit
        if git checkout "$portal_padrao_idg_release"; then
            python bootstrap.py -c production.cfg

            # Explicando o sed:
            # Removo a partir do '[versions]' até o início do arquivo, sendo a
            # string '[versions]' também removida;
            # Removo da primeira linha vazia até o fim do arquivo. É essa linha
            # vazia que indica que a parte '[versions]' terminou;
            # Remove todas as linhas que começam com 4 espaços, geralmente são
            # linhas que contém as urls http;
            # Troco todas as strings '= ' para ' = ' para melhor visibilidade,
            # já que todos os pacotes vem como 'my.package= x.x.'. Isso ocorre
            # por causa dessa linha: https://github.com/buildout/buildout/blob/b8e599fd90f7167735351ce8deeae8b9fe4c16a8/src/zc/buildout/buildout.py#L1119
            # Garantir que tenho valores únicos e em ordem alfabética
            bin/buildout -c production.cfg annotate | sed '1,/\[versions\]/d' | sed '/^$/,$ d' | sed '/    /d' | sed 's/= / = /' | uniq | sort > versions-sem-extends.cfg

            # BBB: Aqui, adiciono 'versions = versions' por causa da versão do
            # buildout utilizada, 1.7.1;
            # Readiciono o '[versions]' removido acima e uma mensagem
            # indicando que esse arquivo é gerado automaticamente.
            sed -i '1s/^/\[buildout\]\n# NÃO EDITE ESSE ARQUIVO, ele foi gerado dinamicamente pelo script https:\/\/raw.githubusercontent.com\/plonegovbr\/portalpadrao.release\/master\/versions-sem-extends.sh\n# Utilize esse arquivo caso o seu servidor não possua acesso à internet, uma vez que o versions.cfg tenta acessar vários cfgs externos no extends.\n# Para maiores informações, acesse a seção "Por que versions.cfg e versions-sem-extends.cfg? Qual devo usar?" no README.md em https:\/\/github.com\/plonegovbr\/portalpadrao.release\/blob\/master\/README.md\n\n# Ver em https:\/\/github\.com\/plonegovbr\/portal\.buildout\/blob\/ab6abcb596d51bb505db1f729065a335ecac9c1e\/buildout\.d\/versions\.cfg#L30 a motivação de "versions = versions".\nversions = versions\n\n\[versions\]\n/' versions-sem-extends.cfg

            echo "Arquivo versions-sem-extends compilado presente em $PWD/versions-sem-extends.cfg."
            cd - || exit
            cp "/tmp/portal.buildout/versions-sem-extends.cfg" "$portal_padrao_idg_release" && echo "Arquivo versions-sem-extends.cfg copiado para $portal_padrao_idg_release."
        fi
    fi
fi
