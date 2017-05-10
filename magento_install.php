<?php
/**
 * Copyright © 2017 Mozg. All rights reserved.
 * See LICENSE.txt for license details.
 */

//

$path_file = __DIR__ . '/root/app/etc/local.xml';

//var_dump(file_exists($path_file));

if( file_exists($path_file) ){
    echo 'Magento já foi instalado.';
    exit;
}

//

$BASE_URL = 'http'.(isset($_SERVER['HTTPS'])?'s':'').'://'.$_SERVER['SERVER_NAME'] . dirname($_SERVER['REQUEST_URI']);

$BASE_URL = $BASE_URL . 'root';

$arg1 = $BASE_URL;
$arg2 = '2';

$output = shell_exec("bash magento_install.sh $arg1 $arg2");

echo "<pre>$output</pre>";

//