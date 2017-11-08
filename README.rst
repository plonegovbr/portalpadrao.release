portalpadrao.release
====================

Esse repositório contém os arquivos com as versões utilizadas em cada release do Portal Padrão e uma explicação técnica do funcionamento do lançamento de um novo release.

Passos para criação de um novo release
======================================

A definição do que deve entrar em cada release é definido pela SECOM, com o desenvolvimento das funcionalidades/correções podendo ser feitas com os parceiros ou interessados na comunidade plonegovbr.

Versões e pinagens de novos releases em andamento (ou seja, que não tenham ainda o seu lançamento oficial) são feitas no arquivo https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg, presente em outro repositório, o https://github.com/plonegovbr/portal.buildout/.

Ações para um novo release
---------------------------

- Confira se os testes de integração contínua do `portal.buildout <https://travis-ci.org/plonegovbr/portal.buildout>`_ passam em ambos builds, ``DEVELOPMENT`` e ``PRODUCTION``
- Se a versão do Plone tiver sido alterada, favor indicar em https://github.com/plonegovbr/brasil.gov.portal#requisitos;
  <!-- PACKAGES -->
- As dependências plonegovbr, se tiverem sofrido alteração, tem seus respectivos releases criados, tags geradas e pacotes disponibilizados no `PyPI <https://pypi.python.org/>`_;
- Os releases de dependências plonegovbr feitas no passo anterior, as pinagens de dependências externas e do próprio Plone que foram testados durante o processo de geração de release são adicionadas/alteradas em https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg;
  <!-- PACKAGES -->
- É feita uma revisão em todas as pinagens de https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/versions.cfg (procure por FIXME, HACK, BBB) para ver se poderá ser feita alguma modificação para aquele release em específico;
- É feita uma revisão nas issues de https://github.com/plonegovbr/portalpadrao.release/issues e https://github.com/plonegovbr/portal.buildout/issues para ver se alguma melhoria pode ser incorporada no release;
  <!-- PACKAGES -->
- Criar uma instância da última versão de brasil.gov.portal e efetuar um teste exploratório mínimo. É interessante montar uma instância anterior ao novo release e atualizar para testar os upgradeSteps;
- Quando todas as revisões tiverem sido feitas e estiver para lançar um release,
  o https://github.com/plonegovbr/portal.buildout/blob/master/etc/versions.cfg será copiado para https://github.com/plonegovbr/portalpadrao.release criando um novo diretório para aquele release:

  .. code-block:: console

    wget https://raw.githubusercontent.com/plonegovbr/portal.buildout/master/etc/versions.cfg

- É feita uma alteração no `extends` de https://github.com/plonegovbr/portal.buildout/blob/master/buildout.d/base.cfg informando esse novo release criado (pode ser necessário esperar alguns minutos, pois a url http://downloads.plone.org.br/release/x.x.x/versions.cfg demora um tempo para sincronizar no github);
- Criação das tags do release (esse é o **último** passo, é nessa ordem caso, durante os passos anteriores, seja necessária alguma alteração pontual):
  - Gerar novo release em `portal.buildout <https://github.com/plonegovbr/portal.buildout/releases/new>`_ e em `portalpadrao.release <https://github.com/plonegovbr/portalpadrao.release/releases/new>`_ (uma tag será gerada automaticamente);
  - É interessante adicionar no release o que foi adicionado na nova versão:
    quais os relatos que foram atendidos e avisos específicos sobre aquela versão,
    se for o caso (como necessidade de novas variáveis de ambiente, ordem de upgradeSteps, etc).
    O GitHub permite a edição do texto de um release após sua geração;
- Aviso ao patrocinador do lançamento do release para que ele prossiga com o envio de email pelo patrocinador pra lista plonegovbr indicando o lançamento desse novo release.

Como escolher corretamente o arquivo de versões de um release
-------------------------------------------------------------

A versão escolhida em portalpadrao.release deve ser a mesma que a brasil.gov.portal sendo aceitas variações mínimas como bugfixes de um release (exemplo, o brasil.gov.portal é 1.1.5.1 mas o último release é o 1.1.5.2).

Pode ser que um release tenha sido lançado e, mesmo testado, ocorra uma situação muito específica que impeça o release de funcionar corretamente (uma dependência errada, uma diretiva de configuração de buildout incorreta, etc). Nesse tipo de situação, é feita a correção e gerado um bugfix do release. Não são feitos bugfixes de releases para adicionar novas funcionalidades pois o escopo já havia sido fechado no momento que ele foi lançado.

Como um release do IDG não envolve apenas o pacote brasil.gov.portal pois existem várias dependências (brasil.gov.\* e vários pacotes da comunidade), não faz sentido mudar a versão de brasil.gov.portal se a modificação que por ventura tenha sido feita para o bugfix daquele release tiver ocorrido em outro pacote: por isso pode ocorrer a situação de um brasi.gov.portal ser a versão 1.1.5.1 mas aqui no portalpadrao.release ser 1.1.5.2.

Por que versions.cfg e versions-sem-extends.cfg? Qual devo usar?
----------------------------------------------------------------

A partir do release 1.4 o ``versions.cfg`` passou a ser gerado automaticamente a cada mudança e ele inclui todas as versões homologadas necessárias para instalar e atualizar o IDG.

O uso do ``versions-sem-extends.cfg`` não é considerado mais uma boa prśtica e será removido na versão 1.5 do IDG.

Como devo efetuar a atualização entre releases?
-----------------------------------------------

Ler a documentação específica de cada release em https://github.com/plonegovbr/portalpadrao.release/releases/tag/x.x.x ou https://github.com/plonegovbr/portal.buildout/releases/tag/x.x.x (sendo ``x.x.x`` a versão desejada) e continue com o manual oficial de `Atualização de release <http://identidade-digital-de-governo-plone.readthedocs.io/en/latest/atualizacao/>`_.

Observações finais
------------------

No passado, para releases temporários, se usava o **-pending**, mas isso traz a desvantagem de quebrar todo pacote que referencia o pending quando você tenta voltar o histórico e rodar o buildout e por isso não será mais utilizado.
