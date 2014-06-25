<?php
session_start();
if(!isset($_SESSION['check']))  { header('Location: login.php'); } 

?>
<!DOCTYPE html>
<head> <link rel="stylesheet" type="text/css" href="style.css"> </head>
<body>
<center>
<h2>Asset Management</h2> 

<?php
//include 'dbinfo.php';
//ORDER BY prop_id DESC LIMIT 1
function save_qr()
{
	$con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
	
	$result = mysqli_query($con,"SELECT prop_id, prop_qr FROM property ORDER BY prop_id DESC LIMIT 1"); 
	
	 
	while($row = mysqli_fetch_array($result))
	{
		$pid = $row['prop_id'];
		$url = $row['prop_qr'];
		
	}

	$filename = "upload/qr/" . $pid . ".png";
	$width = $height = 100;
	if (!file_exists($filename))
	{
	  $qr  = file_get_contents($url);
	  file_put_contents($filename, $qr);
	}

}

function insert_table()
{

$con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

	$result = mysqli_query($con,"SELECT prop_id, prop_name, prop_count, prop_category, prop_subcategory, prop_location, prop_image, prop_purchased, prop_purchase_docs, prop_released, prop_release_docs, prop_qr FROM property ORDER BY prop_id DESC LIMIT 1"); 
	//if (!$result) { // add this check.
    //die('Invalid query: ' . mysql_error());

	while($row = mysqli_fetch_array($result))
	{
		echo '
		<img src="' . $row['prop_image'] . '" alt="Item Image" width="250" height="auto" />
		<img src="upload/qr/' . $row['prop_id'] . '.png" alt="QR Code" width="150" height="150" />
		<table border="1">
				<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Count</th>
				<th>Category</th>
				<th>Subcategory</th>
				<th>Location</th>
				<th>Purchased Date</th>
				<th>Purchase Docs</th>
				<th>Released Date</th>
				<th>Release Docs</th>
				
				</tr>
				<tr>
				<td>' . $row['prop_id'] . '</td>
				<td>' . $row['prop_name'] . '</td>
				<td>' . $row['prop_count'] . '</td>
				<td>' . $row['prop_category'] . '</td>
				<td>' . $row['prop_subcategory'] . '</td>
				<td>' . $row['prop_location'] . '</td>
				<td>' . $row['prop_purchased'] . '</td>
				<td><a href="' . $row['prop_purchase_docs'] . '"target="_blank">View</a></td>
				<td>' . $row['prop_released'] . '</td>
				<td><a href="' . $row['prop_release_docs'] . '"target="_blank">View</a></td>
				
				</table>'; 
}
}

function update_table()
{

$con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }	

	
	$result = mysqli_query($con,"SELECT p.prop_id, p.prop_name, p.prop_count, p.prop_category, p.prop_subcategory, p.prop_location, p.prop_image, p.prop_purchased, p.prop_purchase_docs, p.prop_released, p.prop_release_docs, p.prop_qr
						FROM property p
						INNER JOIN prop_hist ph
						ON p.prop_id = ph.prop_id
						where prh_id=(SELECT max(prh_id) FROM prop_hist)"); 
	//if (!$result) { // add this check.
    //die('Invalid query: ' . mysql_error());

	while($row = mysqli_fetch_array($result))
	{
		echo '
		<img src="' . $row['prop_image'] . '" alt="Item Image" width="250" height="auto" />
		<img src="upload/qr/' . $row['prop_id'] . '.png" alt="QR Code" width="150" height="150" />
		<table border="1">
				<tr>
				<th>ID</th>
				<th>Name</th>
				<th>Count</th>
				<th>Category</th>
				<th>Subcategory</th>
				<th>Location</th>
				<th>Purchased Date</th>
				<th>Purchase Docs</th>
				<th>Released Date</th>
				<th>Release Docs</th>
				
				</tr>
				<tr>
				<td>' . $row['prop_id'] . '</td>
				<td>' . $row['prop_name'] . '</td>
				<td>' . $row['prop_count'] . '</td>
				<td>' . $row['prop_category'] . '</td>
				<td>' . $row['prop_subcategory'] . '</td>
				<td>' . $row['prop_location'] . '</td>
				<td>' . $row['prop_purchased'] . '</td>
				<td><a href="' . $row['prop_purchase_docs'] . '"target="_blank">View</a></td>
				<td>' . $row['prop_released'] . '</td>
				<td><a href="' . $row['prop_release_docs'] . '"target="_blank">View</a></td>
				
				</table>'; 
	}
}

function insert()
{
$con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$pic_location = 'upload/pics/' . ($_FILES['prop_image']['name']);
move_uploaded_file($_FILES['prop_image']['tmp_name'], $pic_location);

$pdoc_location = 'upload/pdocs/' . ($_FILES['prop_purchase_docs']['name']);
move_uploaded_file($_FILES['prop_purchase_docs']['tmp_name'], $pdoc_location); 

$rdoc_location = 'upload/rdocs/' . ($_FILES['prop_release_docs']['name']);
move_uploaded_file($_FILES['prop_release_docs']['tmp_name'], $rdoc_location); 
  
mysqli_query($con,"INSERT INTO property (prop_name, prop_count, prop_category, prop_subcategory, prop_location, prop_image, prop_purchased, prop_purchase_docs, prop_released, prop_release_docs, prop_qr) VALUES ('$_POST[prop_name]', 
'$_POST[prop_count]', '$_POST[prop_category]', '$_POST[prop_subcategory]', '$_POST[prop_location]', '$pic_location', '$_POST[prop_purchased]', '$pdoc_location', 
'$_POST[prop_released]', '$rdoc_location', 'https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=localhost/asset_query.php?')") or die(mysqli_error());

mysqli_query($con,"UPDATE property SET prop_qr = CONCAT(prop_qr, prop_id) ORDER BY prop_id DESC LIMIT 1") or die(mysqli_error());
echo save_qr();
}

if(isset($_POST['submit']))
{
echo insert();
echo insert_table();
}




function update()
{

$con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$eid = $_POST['eid'];

include 'dbinfo.php';

if ($_FILES['prop_image']['name'] != '')
{
	$pic_location = 'upload/pics/' . ($_FILES['prop_image']['name']);
	move_uploaded_file($_FILES['prop_image']['tmp_name'], $pic_location);
	mysqli_query($con,"UPDATE property SET prop_image= '$pic_location' WHERE prop_id = '$eid'") or die(mysqli_error());
}
if ($_FILES['prop_purchase_docs']['name'] != '')
{
	$pdoc_location = 'upload/pdocs/' . ($_FILES['prop_purchase_docs']['name']);
	move_uploaded_file($_FILES['prop_purchase_docs']['tmp_name'], $pdoc_location);
	mysqli_query($con,"UPDATE property SET prop_purchase_docs= '$pdoc_location' WHERE prop_id = '$eid'") or die(mysqli_error());
}
if ($_FILES['prop_release_docs']['name'] != '')
{
	$rdoc_location = 'upload/rdocs/' . ($_FILES['prop_release_docs']['name']);
	move_uploaded_file($_FILES['prop_release_docs']['tmp_name'], $rdoc_location);
	mysqli_query($con,"UPDATE property SET prop_release_docs= '$rdoc_location' WHERE prop_id = '$eid'") or die(mysqli_error());
} 
  
mysqli_query($con,"UPDATE property SET prop_name= '$_POST[prop_name]', prop_count= '$_POST[prop_count]', prop_category= '$_POST[prop_category]', prop_subcategory= '$_POST[prop_subcategory]', 
prop_location= '$_POST[prop_location]', prop_purchased= '$_POST[prop_purchased]', prop_released= '$_POST[prop_released]' WHERE prop_id = '$eid'") or die(mysqli_error());
}

if(isset($_POST['edit2']))
{
echo update();
echo update_table();
}






echo '<form name="new" method="post" action="asset.php"><input type="submit" name="new" value="New Submission"/>';




?>
</center>
</body>
</html>


