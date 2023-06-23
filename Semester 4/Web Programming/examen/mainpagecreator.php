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
<h3>Creator mode</h3>
<h3>Welcome <?php echo $username; ?> ! </h3>


<div>
    <input type="text" id="title-input" placeholder="title"><br>
    <input type="text" id="description-input" placeholder="description"><br>
    <input type="text" id="url-input" placeholder="url"><br>
    <button type="button" onclick="addContent('<?php echo $username; ?>')">Add content</button>
    <br><br>
    <section id="added-message"> </section>
</div>


<br>
<form action="addentries.php">
    <input type="submit" name="addentries" value="Add multiple entries">
</form>
<br>


<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

</body>
</html>