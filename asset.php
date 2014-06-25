<?php 
session_start();
if(!isset($_SESSION['check']))  { header('Location: login.php'); } 

?>
<!DOCTYPE html>
<head> <link rel="stylesheet" type="text/css" href="style.css"> 
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Karla:400,700">
	
	<link rel="stylesheet" href="css/lightbox.css" media="screen"/>
	<script type="text/javascript" src="js/pop.js"></script>
	<script src="js/modernizr.custom.js"></script>
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/lightbox-2.6.min.js"></script>
</head>
<title>Asset Management</title>
<body>
<center>
<h2>Asset Management</h2>
<br></br>

<script>
function checkTextField(field) {
    if (field.value == '') {
        document.getElementById("sbmt").disabled=true;
}
    }
</script> 

<div id="stylized" class="add">

<form action="asset_query.php" method="post" enctype="multipart/form-data">
<table>
<tr>
<th>Name</th>
<th>Count</th> 
<th>Category</th>
<th>Subcategory</th> 
<th>Location</th>
<th>Image</th>
<th>Date Purchased</th>
<th>Purchase Docs</th>
<th>Date Released</th>
<th>Release Docs</th></tr>
<tr><td><input type="text" name="prop_name" onblur="checkTextField(this);"></td>
<td><input type="number" min="1" max="10" step="1" value="1" name="prop_count" style="width:auto;"></td>
<option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option></select></td>
<td><select name="prop_category"><option value="Technology" selected>Technology</option><option value="Furniture">Furniture</option><option value="Other">Other</option></select></td>
<td><select name="prop_subcategory"><option value="Desktop" selected>Desktop</option><option value="Laptop">Laptop</option><option value="Portable">Portable</option>
<option value="Phone">Phone</option><option value="Office">Office</option><option value="Other">Other</option></select></td>
<td><select name="prop_location"><option value="1" selected>1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
<option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option></select></td>
<td><input type="file" name="prop_image"></td>
<!--<td><input type="text" name="prop_purchased"></td> -->
<td><input name="prop_purchased" type="date"></td>

<td><input type="file" name="prop_purchase_docs"></td>

<!-- <td><input type="text" name="prop_released"></td> -->
<td><input name="prop_released" type="date"></td>

<td><input type="file" name="prop_release_docs"></td></tr></table>
<br></br><input type="submit" name="submit" value="Add">
</form>

</div>
</center>
<br></br>
<left> 
<div align="left" id="stylized" class="search">

<h3>Search</h3> 
 <form name="query" method="post" action="">
 <input type="search" name="search_term" />
 <select name="search_what">
 <option value="prop_name" >Name</option>
 <option value="prop_location">Location</option>
 <option value="prop_id">ID</option>
 </select>
 <input type="submit" name="search" value="Search" />
 </form>
 </div>
 
 <?php  
 function search()
  {
  
  $con = mysqli_connect("localhost","root","","test1");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
  
  global $search; 
  if(isset($_POST['search']))
{
	 $search = $_POST['search_term']; 
	 $column = $_POST['search_what']; 	
	
	 switch ($column)
		{
			case 'prop_name':
			$result = mysqli_query($con,"SELECT prop_id, prop_name, prop_count, prop_category, prop_subcategory, prop_location, prop_image, prop_purchased, prop_purchase_docs, prop_released, prop_release_docs, prop_qr FROM property WHERE prop_name LIKE '$search%'"); 
			break;
			case 'prop_location':
			$result = mysqli_query($con,"SELECT prop_id, prop_name, prop_count, prop_category, prop_subcategory, prop_location, prop_image, prop_purchased, prop_purchase_docs, prop_released, prop_release_docs, prop_qr FROM property WHERE prop_location = '$search'"); 
			break;
			case 'prop_id':
			$result = mysqli_query($con,"SELECT prop_id, prop_name, prop_count, prop_category, prop_subcategory, prop_location, prop_image, prop_purchased, prop_purchase_docs, prop_released, prop_release_docs, prop_qr FROM property WHERE prop_id = '$search'"); 
			break;
		}	
	
	$num_rows = mysqli_num_rows($result);
	
	
	if 	($num_rows == FALSE)
		{
			echo '<center><H3>No items found.</H3></center>';
		}
	else
	{
	
	echo '<center> <table border="1">
					<tr>
					<th>Edit</th>
					<th>Delete</th>
					<th>ID</th>
					<th>Name</th>
					<th>Count</th>
					<th>Category</th>
					<th>Subcategory</th>
					<th>Location</th>
					<th>Image</th>
					<th>Date Purchased</th>
					<th>Purchase Docs</th>
					<th>Date Released</th>
					<th>Release Docs</th>
					
					<th>QR Code</th>
					</tr>'; 
					while($row = mysqli_fetch_array($result))
					{
					
					echo '
					<tr>
					<td><form name="edit" method="post" action=""><input type="submit" name="edit1" value="Edit"/>
					<input type="hidden" name="eid" value="' . $row['prop_id'] . '"/></form></td>
					<td><input type="submit" onClick="confirmation(); " name="del" value="Delete" /></td>
					
					<td>' . $row['prop_id'] . '</td>
					<td>' . $row['prop_name'] . '<form name="test" method="post" action=""><input type="hidden" name="did" value="' . $row['prop_id'] . '"/></form></td>
					<td>' . $row['prop_count'] . '</td>
					<td>' . $row['prop_category'] . '</td>
					<td>' . $row['prop_subcategory'] . '</td>
					<td>' . $row['prop_location'] . '</td>';
					if ($row['prop_image'] == 'upload/pics/')
					{
						echo '<td>None</td>';
					}
					else {
					echo '
					<div class="image-row">
					<div class="image-set">
					<td><a class="example-image-link" href="'.$row['prop_image'].'" data-lightbox="example-set" title="' . $row['prop_name'] . '"><img class="example-image" src="img/pic_icon.png" alt="Click"</a></td>'; }
					echo '
					<td>' . $row['prop_purchased'] . '</td>';
					if ($row['prop_purchase_docs'] == 'upload/pdocs/')
					{
						echo '<td>None</td>';
					}
					else {
					echo '		
					<td><a href="' . $row['prop_purchase_docs'] . '"target="_blank">View</a></td>'; }
					echo '<td>' . $row['prop_released'] . '</td>';
					if ($row['prop_release_docs'] == 'upload/rdocs/')
					{
						echo '<td>None</td>';
					}
					else {
					echo '<td><a href="' . $row['prop_release_docs'] . '"target="_blank">View</a></td>';}
					
					echo'
					<td><a class="example-image-link" href="upload/qr/'.$row['prop_id'].'.png" data-lightbox="example-set" title="' . $row['prop_name'] . '"><img class="example-image" src="img/qr_icon.png" alt="Click"</a></td> </div></div>';
					}
					
					
					} echo '</table></center>'; 
					//$_SESSION['prop_id'] = $_POST['did'];
	
	}					
}

echo search();
 
 
 if (isset($_POST['edit1']))
{

$eid = $_POST['eid'];
include 'dbinfo.php';   
  $result = mysqli_query($con,"SELECT prop_id, prop_name, prop_count, prop_category, prop_subcategory, prop_location, prop_image, prop_purchased, prop_purchase_docs, prop_released, prop_release_docs FROM property WHERE prop_id = '$eid'");
							$row = mysqli_fetch_array($result);
					
								
					
echo '<br></br> <div id="stylized" class="add">

<form name= "update" method="post" action="asset_query.php" enctype="multipart/form-data">
<table>
<tr>
<th>Name</th>
<th>Count</th> 
<th>Category</th>
<th>Subcategory</th> 
<th>Location</th>
<th>Image</th>
<th>Date Purchased</th>
<th>Purchase Docs</th>
<th>Date Released</th>
<th>Release Docs</th></tr>
<tr><td><input type="text" name="prop_name" value="' . $row['prop_name'] . '"><input type="hidden" name="eid" value="' . $row['prop_id'] . '"/></td>
<td><input type="number" min="1" max="10" step="1" value="' . $row['prop_count'] . '" name="prop_count" style="width:auto;"></td>
<td><select name="prop_category"><option value="' . $row['prop_category'] . '">' . $row['prop_category'] . '</option><option value="Technology">Technology</option><option value="Furniture">Furniture</option><option value="Other">Other</option></select></td>
<td><select name="prop_subcategory"><option value="' . $row['prop_subcategory'] . '">' . $row['prop_subcategory'] . '</option><option value="Desktop">Desktop</option><option value="Laptop">Laptop</option><option value="Portable">Portable</option>
<option value="Phone">Phone</option><option value="Office">Office</option><option value="Other">Other</option></select></td>
<td><select name="prop_location"><option value="' . $row['prop_location'] . '">' . $row['prop_location'] . '</option><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option>
<option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option></select></td>';

if ($row['prop_image'] == 'upload/pics/')
					{
						echo '<td><center>None</center><input type="file" name="prop_image"></td>';
					}
					else {
					echo '
					
					
					<td><center><div class="image-row"><div class="image-set"><a class="example-image-link" href="'.$row['prop_image'].'" data-lightbox="example-set" title="' . $row['prop_name'] . '"><img class="example-image" src="img/pic_icon.png" alt="Click"</img></a></div></div></center><input type="file" name="prop_image"></td>'; }

echo '


<td><input name="prop_purchased" value="'. $row['prop_purchased'] . '"type="date" /></td>';


if ($row['prop_purchase_docs'] == 'upload/pdocs/')
					{
						echo '<td><center>None</center><input type="file" name="prop_purchase_docs"></td>';
					}
					else {
					echo '

<td><center><a href="' . $row['prop_purchase_docs'] . '"target="_blank">Current Purchase Docs</a></center><input type="file" name="prop_purchase_docs"></td>';}

echo '
<td><input name="prop_released" value="'. $row['prop_released'] . '"type="date" /></td>';

if ($row['prop_release_docs'] == 'upload/rdocs/')
					{
						echo '<td><center>None</center><input type="file" name="prop_release_docs"></td>';
					}
					else {
					echo '

<td><center><a href="' . $row['prop_release_docs'] . '"target="_blank">Current Release Docs</a></center><input type="file" name="prop_release_docs"/></td>';}
echo '
</tr></table>
<br></br><input type="submit" name="edit2" value="Update">
</form>
</div>
</center>';

}
 ?>



</body>
</html>

