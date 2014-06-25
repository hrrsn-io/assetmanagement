<?php
session_start(); 
?>
<!DOCTYPE html>
<head> <link rel="stylesheet" type="text/css" href="style.css"> </head>
<title>Asset Management</title>
<body>
<center>
<h2>Asset Management</h2>
<br></br>

<form action="" method="post" enctype="multipart/form-data">

Username: <input type="text" name="user" value="" >
Password: <input type="password" name="pass" value="">
<br></br><input type="submit" name="login" value="Login">

<?php
if (isset($_POST['login']))
{
$con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
  
$user = $_POST['user'];
$pass = $_POST['pass'];

$qry = mysqli_query($con,"SELECT * from users WHERE username = '$user' AND password = '$pass'");
if (isset($_POST['login']) && mysqli_num_rows($qry) == 1) 
	{ 
	 $_SESSION['check'] = 1;
	 header('Location: asset.php'); 
	}
else
	{
		echo '<p>&nbsp;</p><p class="error">Invalid username or password</p>';
	}
}
	?>
</center>


</body>
</html>