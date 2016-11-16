portalpadrao.release
====================

Esse repositório contém os arquivos com as versões utilizadas em cada release do Portal Padrão e uma explicação técnica do funcionamento do lançamento de um novo release.

Por que versions.cfg e versions-sem-extends.cfg? Qual devo usar?
-------------------------------------------------------------

Até o release 1.1.4, o arquivo versions.cfg era um arquivo compilado *manualmente* não contendo nenhuma url a mais no extends.

A partir do release 1.1.5, passamos a usar como referência no extends o versions do Plone para a última versão do Plone homologada pelo IDG, de forma a diminuir o retrabalho na criação desse arquivo de versões. Isso significa que o seu servidor precisará ter acesso externo à essas urls do extends para funcionar corretamente.

Para situações em que você não pode usar o extends de uma url externa (ambientes sem acesso externo), baixe o versions-sem-extends.cfg para a sua instância e renomeie para versions.cfg.

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
- Criar uma instância da última versão de brasil.gov.portal e efetuar um teste exploratório mínimo;
- Quando todas as revisões tiverem sido feitas e estiver para lançar um release, o https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg será copiado para https://github.com/plonegovbr/portalpadrao.release, criando um novo diretório para aquele release, e o versions-sem-extends.cfg gerado usando o script em https://github.com/plonegovbr/portalpadrao.release/blob/master/versions-sem-extends.sh
- É feita uma alteração no `extends` de https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/base.cfg informando esse novo release criado (pode ser necessário esperar alguns minutos, pois a url http://downloads.plone.org.br/release/x.x.x/versions.cfg demora um tempo para sincronizar no github);
- Verificar se a build do master de portal.buildout no travis está ok;
- Criação das tags do release (esse é o **último** passo, é nessa ordem caso, durante os passos anteriores, seja necessária alguma alteração pontual):
    - Gerar tag em https://github.com/plonegovbr/portal.buildout;
    - Gerar o versions-sem-extends.cfg usando o script https://github.com/plonegovbr/portalpadrao.release/blob/master/versions-sem-extends.sh passando como parâmetro release gerado no passo anterior, e adicionar na pasta do release em https://github.com/plonegovbr/portalpadrao.release;
    - Gerar tag em https://github.com/plonegovbr/portalpadrao.release;
- Envio de email pra lista plonegovbr indicando o lançamento desse novo release.

Deve haver uma preocupação para que as versões de brasil.gov.portal sempre tenham a mesma versão de um release lançado em https://github.com/plonegovbr/portalpadrao.release, podendo ser aceitas variações mínimas como bugfixes (exemplo: brasil.gov.portal é 1.1.3 mas temos o release 1.1.3.1).

Observação: no passado, para releases temporários, se usava o **-pending**, mas isso traz a desvantagem de quebrar todo pacote que referencia o pending quando você tenta voltar o histórico e rodar o buildout e por isso não será mais utilizado.
