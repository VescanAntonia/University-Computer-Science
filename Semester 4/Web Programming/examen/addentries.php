<?php
include ('connection.php');
session_start();
if (isset($_SESSION['id'])){
    $userId = $_SESSION['id'];
    $username = $_SESSION['username'];

}
else {
    header('Location: login.php');
    die();
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Welcome user</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="main.js"></script>
    <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
<h3>Welcome <?php echo $username; ?> ! </h3>
<h3>Add more than one entry</h3>

<div>
    <input type="text" id="title-input" placeholder="title"><br>
    <input type="text" id="description-input" placeholder="description"><br>
    <input type="text" id="url-input" placeholder="url"><br>
    <button type="button" onclick="push()">Push</button>
    <button type="button" onclick="add(<?php echo $userId?>)">Add the pushed ones</button>
    <br>
    
</div>



<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

<br>
<form action="mainpagecreator.php">
    <input type="submit" name="gotomainpagecreator" value="Go back">
</form>
<br>

</body>
</html>