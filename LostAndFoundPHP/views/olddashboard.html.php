<?php
require_once($_SERVER['DOCUMENT_ROOT'] . "/util.php");

if (!isset($_SESSION['username'])) {
	//$_SESSION['msg'] = "You must log in first";
	redirect("/",300);
}
if (isset($_GET['logout'])) {
	session_destroy();
	unset($_SESSION['username']);
	redirect("/",301);
	var_dump($_SESSION);
}
?>
<!DOCTYPE html>
<html>

<head>
	<title>Dashboard</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
	<!-- logged in user information -->
		<p>Welcome  <?=$_SESSION['username']??"test" ?><strong>
				<!-- <?php echo $_SESSION['username']; ?> -->
			</strong></p>
		<p> <a href="dashboard?logout='1'" style="color: red;">logout</a> </p>
	</div>

</body>

</html>