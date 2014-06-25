<?php
$username = "ftpflcc_dbadmin";
$password = "Update4db";
$hostname = "76.162.254.169"; 
$maindb = "ftpflcc_Basicweb";

$dbhandle = mysql_connect($hostname, $username, $password) or die("Unable to connect to MySQL". mysql_error());
mysql_select_db($maindb) or die( "Unable to select database");

?>