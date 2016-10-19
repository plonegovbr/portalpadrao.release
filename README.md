portalpadrao.release
====================

Esse repositório contém os arquivos com as versões utilizadas em cada release do Portal Padrão e uma explicação técnica do funcionamento do lançamento de um novo release.

Passos para criação de um novo release
======================================

A definição do que deve entrar em cada release é definido pela SECOM, com o desenvolvimento das funcionalidades/correções podendo ser feitas com os parceiros ou interessados na comunidade plonegovbr.

Versões e pinagens de novos releases em andamento (ou seja, que não tenham ainda o seu lançamento oficial) são feitas no arquivo https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg, presente em outro repositório, o https://github.com/plonegovbr/portal.buildout/.

Ações para um novo release
---------------------------

- As dependências plonegovbr (como brasil.gov.tiles, brasil.gov.portlets e etc) tem seus respectivos releases criados, tags geradas e pacotes disponibilizados no pypi;
- Os releases de dependências plonegovbr feitas no passo anterior, as pinagens de dependências externas e do próprio Plone que foram testados durante o processo de geração de release são adicionadas/alteradas em https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg;
- É feita uma revisão em todas as pinagens de https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg (procure por FIXME, HACK, BBB) para ver se poderá ser feita alguma modificação para aquele release em específico;
- Restartar as builds do master das dependências plonegovbr no travis;
- Quando todas as revisões tiverem sido feitas e estiver para lançar um release, o https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg será copiado para https://github.com/plonegovbr/portalpadrao.release, criando um novo diretório para aquele release;
- É feita uma alteração no `extends` de https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/base.cfg informando esse novo release criado;
- Criação da tag do release em https://github.com/plonegovbr/portalpadrao.release;
- Criação da tag do release em https://github.com/plonegovbr/portal.buildout;
- Envio de email pra lista plonegovbr indicando o lançamento desse novo release.

Deve haver uma preocupação para que as versões de brasil.gov.portal sempre tenham a mesma versão de um release lançado em https://github.com/plonegovbr/portalpadrao.release, podendo ser aceitas variações mínimas como bugfixes (exemplo: brasil.gov.portal é 1.1.3 mas temos o release 1.1.3.1).

Observação: no passado, para releases temporários, se usava o **-pending**, mas isso traz a desvantagem de quebrar todo pacote que referencia o pending quando você tenta voltar o histórico e rodar o buildout e por isso não será mais utilizado.
