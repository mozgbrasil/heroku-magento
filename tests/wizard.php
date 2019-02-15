<?php
/**
 * Copyright © 2017 Mozg. All rights reserved.
 * See LICENSE.txt for license details.
 */

//

ini_set('display_errors', 1);

//

require 'vendor/autoload.php';

//

/*

/?server=true

/?phpinfo=true

/?database=true

/?scandir=true&dir=/app/magento/&load_file=true&file=/app/magento/var/report/156669766042

*/


//

if ( (php_sapi_name() === 'cli') ){

    echo "\e[1;33m (1) \e[0m" ;
    echo "\n";

    print_r('PHP CLI');

    echo "\n";
    echo "\e[1;33m (2) \e[0m" ;
    echo "\n";

    print_r(get_loaded_extensions());

    echo "\n";
    echo "\e[1;33m (3) \e[0m" ;
    echo "\n";

    $ext = 'zend-guard-loader';
    print_r(extension_loaded($ext));

    echo "\n";
    echo "\e[1;33m (4) \e[0m" ;
    echo "\n";

    $ext = 'zend guard loader';
    print_r(extension_loaded($ext));

    echo "\n";
    echo "\e[1;33m (5) \e[0m" ;
    echo "\n";

    print_r(get_extension_funcs($ext));

    exit;

}

//

if ( empty($_REQUEST) ){

    //$version = '06052017_161445';
    //dump($version);

    $app_name = getenv("HEROKU_APP_NAME");

    $BASE_URL = 'http://'.$_SERVER['SERVER_NAME'] . dirname($_SERVER['REQUEST_URI']);

    $MAGENTO_URL = $BASE_URL . 'magento/';

    $parsed_url = parse_url($BASE_URL);
    $host = explode('.', $parsed_url['host']);
    $subdomain = $host[0];
    $APP_NAME = $subdomain;

    $path_file = __DIR__ . '/magento/app/etc/local.xml';

    $html = '';



    // output buffering
    ob_start();
    $mysql_database = parse_url(getenv("JAWSDB_URL"));
    dump($mysql_database);
    $ob_response = ob_get_clean();
    // output buffering

    if( !file_exists($path_file) ){
        $html .= <<<EOF

        <h2>Passo 1</h2>

        <p><b>Caso queira, execute o comando abaixo para a visualização dos logs do seu aplicativo</b></p>

        <p>heroku logs --app $APP_NAME --tail</p>

        <h2>Passo 2</h2>

        <!--

        <p><b>Caso queira, execute o comando abaixo para auto instalar o Magento com o sample data</b></p>

        <p>heroku run --app $APP_NAME ' bash magento_install.sh $MAGENTO_URL ; '</p>

        <p><b>Obs.</b> a execução do arquivo *.sh, não armazena o sample data, nem instala o Magento, por isso da execução via php WEB</p>

        -->

        <p><b>Caso queira, acesse o link a seguir para auto instalar o Magento com o sample data</b></p>

        <p><a href="${BASE_URL}wizard.php?magento_sample_data=true" target="_blank">Clique aqui para auto instalar o Magento com o sample data</a></p>

        <!--<p><b>Obs:</b> Pode ocorrer o erro h12, https://devcenter.heroku.com/articles/error-codes#h12-request-timeout</p>-->

        <p><b>Obs:</b> Esse processo ira rodar em background, aguarde 2 minutos e acesse a URL do Magento</p>

        <p>ou</p>

        <p>Efetue a instalação do Magento pelo instalador do Magento, para isso acesse qualquer URL do projeto abaixo e informe os seguintes dados de acesso ao banco de dados</p>

        <p>$ob_response</p>

        <h2>Passo 3</h2>

        <p><a href="${BASE_URL}wizard.php?phpinfo=true" target="_blank">Clique aqui para acesso ao phpinfo</a></p>

EOF;

    }

    $html .= <<<EOF

    <p><a href="${BASE_URL}magento/admin" target="_blank">Clique aqui para acesso ao backend do Magento</a></p>

    <p>admin / 123456a</p>

    <p><a href="${BASE_URL}magento" target="_blank">Clique aqui para para acesso ao frontend do Magento</a></p>

EOF;

    echo $html;

}

//

if ( array_key_exists('magento_sample_data', $_REQUEST) ){

    if( file_exists($path_file) ){
        echo 'Magento já foi instalado.';
        exit;
    }

    //

    $BASE_URL = 'http'.(isset($_SERVER['HTTPS'])?'s':'').'://'.$_SERVER['SERVER_NAME'] . dirname($_SERVER['REQUEST_URI']);

    $BASE_URL = 'http://'.$_SERVER['SERVER_NAME'] . dirname($_SERVER['REQUEST_URI']);

    $BASE_URL = $BASE_URL . 'magento/';

    $arg1 = $BASE_URL;
    $arg2 = '';

    try {
        $cmd = "wget https://raw.githubusercontent.com/mozgbrasil/bash-shell-scripts-public/master/Magento.sh ; bash Magento.sh magento_sample_data_install --url=$arg1 ; ";
        $output = passthru($cmd . " > /dev/null &");
        dump('cmd');
        //dump($output);
    } catch (Exception $e) {
        dump('Exception');
        dump($e->getMessage());
    }

    echo "Fim";

}

//

if ( array_key_exists('server', $_REQUEST) ){

    dump($_SERVER);
    dump($_REQUEST);

}

//

if ( array_key_exists('scandir', $_REQUEST) ){

    $dir    = isset($_REQUEST['dir']) ? $_REQUEST['dir'] : __DIR__;
    $files  = scandir($dir);
    dump(getcwd());
    dump(dirname(__FILE__));
    dump(basename(__DIR__));
    dump($dir);
    dump($files);

}

//

if ( array_key_exists('load_file', $_REQUEST) ){

    $path_file  = isset($_REQUEST['file']) ? $_REQUEST['file'] : __FILE__;
    $file       = file_get_contents($path_file);
    dump($path_file);
    dump($file);

}

//

if ( array_key_exists('phpinfo', $_REQUEST) ){

    phpinfo();

}

//

if ( array_key_exists('objects', $_REQUEST) ){

    $_array = array(
        'spl_autoload_functions()'=>spl_autoload_functions(),
        'get_loaded_extensions()'=>get_loaded_extensions(),
        'get_declared_traits()'=>get_declared_traits(),
        'array_keys(get_defined_vars())'=>array_keys(get_defined_vars()),
        'get_defined_constants()'=>get_defined_constants(),
        'get_defined_functions()'=>get_defined_functions(),
        'get_declared_classes()'=>get_declared_classes(),
    );

    dump($_array);

}

//

if ( array_key_exists('database', $_REQUEST) ){

    //

    echo '<h1>CLEARDB_DATABASE_URL</h1>';

    // Create connection

    $mysql_database = parse_url(getenv("CLEARDB_DATABASE_URL"));
    dump($mysql_database);
    $host = $mysql_database["host"];
    $user = $mysql_database["user"];
    $pass = $mysql_database["pass"];
    $db = substr($mysql_database["path"], 1);

    try {
        $conn = new mysqli($host, $user, $pass, $db);
    } catch (Exception $e) {
        dump($e->getMessage());
    }

    dump($conn);

    // Check connection
    if ($conn->connect_error) {
        dump("Connection failed: " . $conn->connect_error);
    }

    $sql = "SHOW tables";
    $result = $conn->query($sql);

    dump($result);

    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            dump($row);
        }
    } else {
        echo "0 results";
    }

    $conn->close();

    //

    echo '<h1>JAWSDB_URL</h1>';

    // Create connection

    $mysql_database = parse_url(getenv("JAWSDB_URL"));
    dump($mysql_database);
    $host = $mysql_database["host"];
    $user = $mysql_database["user"];
    $pass = $mysql_database["pass"];
    $db = substr($mysql_database["path"], 1);

    try {
        $conn = new mysqli($host, $user, $pass, $db);
    } catch (Exception $e) {
        dump($e->getMessage());
    }

    dump($conn);

    // Check connection
    if ($conn->connect_error) {
        dump("Connection failed: " . $conn->connect_error);
    }

    $sql = "SHOW tables";
    $result = $conn->query($sql);

    dump($result);

    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            dump($row);
        }
    } else {
        echo "0 results";
    }

    $conn->close();

    //

}

//
