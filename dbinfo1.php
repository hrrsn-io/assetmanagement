<?php
$username = "root";
$password = "";
$hostname = "127.0.0.1"; 
$maindb = "test1";

$dbhandle = mysqli_connect($hostname, $username, $password) or die("Unable to connect to MySQL". mysql_error());
mysql_select_db($maindb) or die( "Unable to select database");

?>
