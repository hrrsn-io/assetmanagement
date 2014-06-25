<?php
include 'dbinfo.php';
session_start();
$pid = $_SESSION['prop_id'];


echo 'test';


mysql_query("UPDATE property SET prop_active = '1' WHERE prop_id = '$pid'");




header('Location: asset.php');


?>