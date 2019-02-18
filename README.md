[checkmark]: https://raw.githubusercontent.com/mozgbrasil/mozgbrasil.github.io/master/assets/images/logos/logo_32_32.png "MOZG"
![valid XHTML][checkmark]

[getcomposer]: https://getcomposer.org/
[uninstall-mods]: https://getcomposer.org/doc/03-cli.md#remove

# Heroku\Magento

## Demonstração

[![Clique para visualizar o vídeo](https://img.youtube.com/vi/-cT1mqkdi_E/0.jpg)](https://youtu.be/-cT1mqkdi_E "Clique para visualizar o vídeo")

## Sinopse

Automação para criação de projeto [Magento](https://magento.com/) na [Heroku](https://www.heroku.com/)

## Motivação

Evangelizar a plataforma [Magento](https://magento.com/)

## Característica técnica

Para o aplicativo o Heroku usa o arquvo [app.json](app.json)

Para a implantação o Heroku usa o arquvo [composer.json](composer.json)

Como a Heroku trabalha com o [Composer](https://getcomposer.org/), todas as dependências a ser usada no projeto está registrada no arquivo [composer.json](composer.json)

## Descrição

Olá

Tenha sua loja virtual usando a plataforma [Magento](https://magento.com/) em apenas 1 clique

## Implantando na Heroku

Clique abaixo para implantar o aplicativo na sua conta na [Heroku](https://www.heroku.com/)

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mozgbrasil/heroku-magento)

Em seguida clique no botão "Deploy"

Ao finalizar a implantação do aplicativo será exibido a mensagem "Your app was successfully deployed."

Clique no botão "View"

Será carregado o aplicativo exibindo o diretório raiz, acesse a pasta magento para utilizar a plataforma

## Implantando em ambiente local


```
git clone https://github.com/mozgbrasil/heroku-magento

composer update

bash app.sh magento_sample_data_install --url='http://localhost.loc/heroku-magento/magento/' \
--db_host="mysql" \
--db_port="3306" \
--db_name="heroku-magento-001" \
--db_user="root" \
--db_pass=""

```

## Magento

Atualmente um projeto Magento ideal é gerenciado completamente pelo Composer, a fim de obter as seguintes melhorias

- [✓] Magento sempre atualizado;
- [✓] Módulos sempre atualizados;
- [✓] Template sempre atualizado;

Precisa de um projeto para ação de Comércio eletrônico, utilize a melhor plataforma, utilize o Magento, entre em contato conosco

Conheça a nossa trajetória de sucesso construída com muito empenho, compromisso, ética e profissionalismo.

[CEREBRUM](https://www.cerebrum.com.br/ "Magento")

Quer aprender sobre Magento, acesse a Comunidade Magento

[Comunidade Magento](https://www.comunidademagento.com.br/ "Magento")

Precisa de módulos para Magento, instale os módulos da MOZG em seu projeto Magento

[MOZG](http://mozg.com.br/catalogo/ "Magento")

## Demonstração

<a href="http://heroku-magento-mozg.herokuapp.com/magento/index.php/admin/" target="_blank">Clique aqui para acesso ao backend</a>

Utilize os seguintes dados para acesso

    admin / 123456a

<a href="http://heroku-magento-mozg.herokuapp.com/magento/index.php/" target="_blank">Clique aqui para acesso ao frontend</a>

## Recursos do projeto

No uso do Composer todo os recursos é relacionado no manifesto do projeto

<a href="http://heroku-magento-mozg.herokuapp.com/composer.json" target="_blank">Clique aqui para acesso manifesto do projeto</a>

## Sobre temas

Pelo seguinte repositório

https://www.magentocommerce.com/magento-connect/themes.html

Usando o Magento Connect podemos instalar módulos ou templates no Magento

Mas não é recomendado o uso do Magento Connect quando se trabalha com o Composer, pois pode ser feito download do arquivo composer.json de módulos de terceiros, corrompendo o arquivo composer.json do projeto

Portanto no uso do Composer com o Magento

Podemos usar o seguinte repositório

http://packages.firegento.com/

Onde vemos diversos temas, pesquise por "theme", vemos que essas bibliotecas se trata das mesmas registrada no Magento Connect mas por esse repositório podemos instalar via Composer

Ou

Podemos usar o seguinte repositório

https://packagist.org/

Que se trata do repositório central de bibliotecas disponibilizada via Composer

## Sobre o aplicativo para o Heroku

Esse aplicativo foi desenvolvido pela [MOZG](http://mozg.com.br/) e se encontra disponível no seguinte repositório no github [https://github.com/mozgbrasil/heroku-magento](https://github.com/mozgbrasil/heroku-magento), qualquer contribuição é bem vinda.

# Considerações

Se você gostou deste projeto, considere dar um 🌟 ou doar.

- [![pagseguro](https://stc.pagseguro.uol.com.br/public/img/botoes/doacoes/164x37-doar-assina.gif)](https://pagseguro.uol.com.br/checkout/v2/donation.html?currency=BRL&receiverEmail=mozgbrasil@gmail.com)
- [![Star on GitHub](https://img.shields.io/github/stars/mozgbrasil/heroku-magento.svg?style=social)](https://github.com/mozgbrasil/heroku-magento/stargazers)
- [![Watch on GitHub](https://img.shields.io/github/watchers/mozgbrasil/heroku-magento.svg?style=social)](https://github.com/mozgbrasil/heroku-magento/watchers)

Verifique também minha [Conta GitHub](https://github.com/mozgbrasil), onde eu tenho outros artigos e aplicativos que você pode achar interessantes.

## Para contratar 👨💻

Se você quiser que eu o ajude, estou disponível para contratar.

Entre em contato com suporte@mozg.com.br

## Onde seguir

Você pode me seguir nas mídias sociais 🐙😇, nos seguintes locais:

- [GitHub](https://github.com/mozgbrasil)
- [Twitter](https://twitter.com/mozgbrasil)

## Mais sobre mim

Eu não só vivo no GitHub, eu tento fazer muitas coisas para não me aborrecer 🙃. Para saber mais sobre mim, você pode visitar os seguintes links:

- [Artigos](http://mozg.com.br/artigos/)

:cat2:
