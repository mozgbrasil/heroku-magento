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

Tenha sua loja virtual usando a plataforma [Magento](https://magento.com/) de forma fácil

## Implantando na Heroku

Obtenha seu banco de dados MySQL com 100MB grátis para usar como quiser

[https://remotemysql.com/](https://remotemysql.com/)

A implantação na Heroku pode ser feito de qualquer uma das 2 formas a seguir

1. 

Clique no botão abaixo para implantar o aplicativo na sua conta na [Heroku](https://www.heroku.com/pricing) usando o plano gratuito

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mozgbrasil/heroku-magento)

Efetue o preenchimento dos campos relativo ao banco de dados, para o campo "MAGE_URL" altere em "APP_NAME" pelo nome do aplicativo

Em seguida clique no botão "Deploy"

2. 

A seguir temos um modelo que ao acessar já preenche os campos previamente, apenas cerfifique se de ter feito as devidas alterações

    https://heroku.com/deploy?env[MAGE_URL]=https://APP_NAME.herokuapp.com/magento/&env[MAGE_DB_HOST]=remotemysql.com&env[MAGE_DB_NAME]=???&env[MAGE_DB_USER]=???&env[MAGE_DB_PASS]=???&template=https://github.com/mozgbrasil/heroku-magento

Acesse a URL informe o nome da aplicação

Em seguida clique no botão "Deploy"

.

Ao finalizar a implantação do aplicativo será exibido a mensagem "Your app was successfully deployed."

Clique no botão "View"

Será carregado o aplicativo exibindo o diretório raiz, acesse a pasta magento para utilizar a plataforma

    O aplicativo ainda não suporta a importação do sample data, a melhor solução é importar o banco antes de implantar o aplicativo na Heroku

    No uso do HTTPS não carrega o projeto ou é carregado com lentidão, não usar

## Útil

https://medium.com/elefante-yogue/usando-php-com-heroku-e7d4f2fee56a

## Executando em ambiente local

    git clone https://github.com/mozgbrasil/heroku-magento
    cp env-example .env
    nano .env
    pwd && ls && rm -fr magento && rm -fr vendor && rm composer.lock && pwd && ls && composer install -vvv
      # 1 local: pre-update-cmd, post-update-cmd: command is executed without a lock file present.
      # 2 local, heroku 2: post-install-cmd: command has been executed with a lock file present.

    composer show -s -vvv
    composer install -vvv
    (du -hsx ./* | sort -rh | head -10)
    (du -hsx vendor/* | sort -rh | head -10)

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

---

## Deploy to **Heroku**

<img align="right" width="100px" height="auto" src="https://cdn.worldvectorlogo.com/logos/heroku.svg" alt="Heroku">

Heroku is a free hosting service for hosting small projects. Easy setup and deploy from the command line via _git_.

###### Pros

* Easy setup
* Free

###### Cons

* App has to sleep a couple of hours every day.
* "Powers down" after 30 mins of inactivity. Starts back up when you visit the site but it takes a few extra seconds. Can maybe be solved with [**Kaffeine**](http://kaffeine.herokuapp.com/)

---

### Install Heroku

1 . [Create your database](#create-your-database)

2 . Create an account on <br/>[https://heroku.com](https://heroku.com)

3 . Install the Heroku CLI on your computer: <br/>[https://devcenter.heroku.com/articles/heroku-cli](https://devcenter.heroku.com/articles/heroku-cli)

4 . Connect the Heroku CLI to your account by writing the following command in your terminal and follow the instructions on the command line:
```bash
heroku login
```

5 . Then create a remote heroku project, kinda like creating a git repository on GitHub. This will create a project on Heroku with a random name. If you want to name your app you have to supply your own name like `heroku create project-name`:
```bash
heroku create project-name
```

6 . Push your app to __Heroku__ (you will see a wall of code)
```bash
git push heroku master
```

7 . Visit your newly create app by opening it via heroku:
```bash
heroku open
```

8 . For debugging if something went wrong:
```bash
heroku logs --tail
```

---

## Deploy to **now**

1 . [Create your database](#create-your-database)

2 . Install now cli-tool globally
```bash
npm install -g now
```

3 . Run the `now` command in this folder/repo where your project is. If you run it for the first time, you will be prompted to login, after login, run the command again:
```
now --public --docker
```
_`--public` is to skip the prompt telling you that you will open source your project if you deploy it to now_

4 . The URL will be copied automatically and you can just paste it into your browser.

5. **Optional**: Rename the deployment:
```bash
now alias https://your-deployed-name.now.sh new-name
```
_first argument is the deployed site, second argument is the new name to give it_

---

## Deploy to **Azure**

<img align="right" width="100px" height="auto" src="https://docs.microsoft.com/en-us/azure/media/index/azure-germany.svg" alt="Azure">

You can also use _Microsoft Azure_ to deploy a smaller app for free to the Azure platform. The service is not as easy as _Heroku_ and you might go insane because the documentation is really really bad at some times and it's hard to troubleshoot.

The **pros** are that on _Azure_ the app **will not be forced to sleep**. It will sleep automatically on inactivity but you can just visit it and it will start up.

## Installation

1 . Create a Microsoft Account that you can use on Azure: </br>
https://azure.microsoft.com/

2 . Install the `azure-cli`: <br/>
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
_This might cause some trouble, you will see. Remember to restart your terminal or maybe your computer if the commands after this does not work_

3 . Login to the service via the command line and follow the instructions: </br>
```bash
az login
```
_You will be prompted to visit a website and paste a confirmation code_


## Create the project

1 . [Create your database](#create-your-database)

2 . Create a resource group for your projects, replace the name to whatever you want just be sure to use the same group name in all commands to come. You only have to create the resource group and service plan once, then you can use the same group and plan for all other apps you create if you like.

```bash
az group create -n NameOfResourceGroup -l northeurope
```

3 . Create a service plan:

```
az appservice plan create -n NameOfServicePlan -g NameOfResourceGroup
```

4 . Create the actual app and supply the service plan and resource group
```bash
az webapp create -n NameOfApp -g NameOfResourceGroup --plan NameOfServicePlan
```

5 . Create deployment details. A git-repo is not created automatically so we have to create it with a command:

```bash
az webapp deployment source config-local-git -n NameOfApp -g NameOfResourceGroup
```

6 . From the command in step 5 you should get a **url** in return. Copy this url and add it as a remote to your local git project, for example:

```bash
git remote add azure https://jesperorb@deploy-testing.scm.azurewebsites.net/deploy-testing.git
```

7 . Now you should be able to push your app:
```bash
git push azure master
```

You should be prompted to supply a password, this should be the pass to your account. If not, you can choose a different password at your Dashboard for Azure: **[https://portal.azure.com/](https://portal.azure.com/)**

Choose **App Services** in the sidebar to the left and the choose your app in the list that appears then go to **Deployment Credentials** to change your password for deployment:<br>
https://docs.microsoft.com/en-us/azure/app-service/app-service-deployment-credentials

---

:cat2:
