<?php

error_log('#@@# bin/worker.php');

/*while(true) {
    error_log('Log a cada 10 segundos');

    sleep(10);
}*/

//

$autoload_path = dirname(dirname(__FILE__)) . "/vendor/autoload.php";
//echo $autoload_path;exit;
require_once($autoload_path);
//echo '<pre>';print_r(spl_autoload_functions());exit;

//
use Symfony\Component\Process\Process;
use Symfony\Component\Process\Exception\ProcessFailedException;

var_dump($argv);
var_dump(isset($argv));
//exit;

if ($argc < 2 )
{
    exit( "Usage: program <parameter1>\n" );
}

$process = new Process($argv[1]);
$process->start();

while ($process->isRunning()) {
    //echo ' waiting for process to finish ...';
}

if (!$process->isSuccessful()) {
    throw new ProcessFailedException($process);
}

echo '<pre>';
print_r($process->getOutput());

//
