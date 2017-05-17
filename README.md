[checkmark]: https://raw.githubusercontent.com/mozgbrasil/mozgbrasil.github.io/master/assets/images/logos/Red_star_32_32.png "MOZG"
![valid XHTML][checkmark]

[getcomposer]: https://getcomposer.org/
[uninstall-mods]: https://getcomposer.org/doc/03-cli.md#remove

# Heroku\Magento

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

Tenha sua loja virtual usando a plataforma [Magento](https://magento.com/) em apenas 1 clique, por apenas $10.00 que é o custo para uso do banco de dados [MySQL](https://elements.heroku.com/addons/jawsdb#leopard) na [Heroku](https://www.heroku.com/)

## Implantando na Heroku

Clique abaixo para implantar o aplicativo na sua conta na [Heroku](https://www.heroku.com/)

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mozgbrasil/heroku-magento)

Em seguida clique no botão "Deploy"

Ao finalizar a implantação do aplicativo será exibido a mensagem "Your app was successfully deployed."

Clique no botão "View"

Será carregado o aplicativo, com o acesso ao Magento

Em seguida você pode baixar o aplicativo, fazer as alterações e enviar ao seu repositório no github que a implantação na Heroku será efetuada.

## Sobre temas

Pelo seguinte repositório

https://www.magentocommerce.com/magento-connect/themes.html

Usando o Magento Connect podemos instalar módulos ou templates no Magento

Mas não é recomendado o uso do Magento Connect quando se trabalha com o Composer, pois o Magento Connect se trata de um ambiente defasado, e no uso do mesmo pode ser feito download do arquivo composer.json de módulos de terceiros, corrompendo o arquivo composer.json do projeto

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

:cat2: