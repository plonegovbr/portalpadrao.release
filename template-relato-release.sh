#!/usr/bin/env bash

# Esse script tem a função de gerar um arquivo texto com os passos necessários
# para gerar um release mas já num formato markdown com checkboxes para facilitar
# o trabalho de gerar um issue pra acompanhar o andamento do release.

rm -f template-relato-release.md

wget -O template-relato-release.md http://raw.githubusercontent.com/plonegovbr/portalpadrao.release/master/README.md

# https://stackoverflow.com/a/37222377
packages=$(cat <<-END
  - [ ] [brasil.gov.agenda](https://github.com/plonegovbr/brasil.gov.agenda/)
  - [ ] [brasil.gov.barra](https://github.com/plonegovbr/brasil.gov.barra/)
  - [ ] [brasil.gov.facetada](https://github.com/plonegovbr/brasil.gov.facetada/)
  - [ ] [brasil.gov.paginadestaque](https://github.com/plonegovbr/brasil.gov.paginadestaque/)
  - [ ] [brasil.gov.portal](https://github.com/plonegovbr/brasil.gov.portal/)
  - [ ] [brasil.gov.portlets](https://github.com/plonegovbr/brasil.gov.portlets/)
  - [ ] [brasil.gov.temas](https://github.com/plonegovbr/brasil.gov.temas/)
  - [ ] [brasil.gov.tiles](https://github.com/plonegovbr/brasil.gov.tiles/)
  - [ ] [brasil.gov.vcge 1.x](https://github.com/plonegovbr/brasil.gov.vcge/tree/1.x)
  - [ ] [brasil.gov.vcge 2.x](https://github.com/plonegovbr/brasil.gov.vcge/)
END
)

# Remove o que existir antes dessa seção
sed -i "/Ações para um novo release/,\$!d" template-relato-release.md

# Remove o que existir depois dessa seção
sed -i "/^Como escolher corretamente o arquivo de versões de um release$/,\$d" template-relato-release.md

# Altera o placeholder pra não dar problema no próximo sed que substitui '- '.
sed -i "s/<!-- PACKAGES -->/PACKAGES/g" template-relato-release.md

# Troca '- ' para '- [ ] ' para fazer o efeito de checkbox
sed -i "s/- /- \[ \] /g" template-relato-release.md

# Troca o placeholder pelos nomes dos pacotes junto com url para facilitar a
# verificação.
# https://unix.stackexchange.com/a/60322
packages_escaped=$(printf '%s\n' "$packages" | sed 's,[\/&],\\&,g;s/$/\\/')
packages_escaped=${packages_escaped%?}
sed -i "s/PACKAGES/$packages_escaped/g" template-relato-release.md
