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

<br>
<div>
    <input name="name" type="text" id="name-input" placeholder="person name">
    <button type="button" onclick="showChannels()">Show channels</button>
    <br>
</div>
<section id="channels"> </section>
<br>

<button type="button" onclick="showSubscriptions(<?php echo $userId?>)">Show subscriptions</button>
<br>
<section id="subscriptions"> </section>

<br><br>
<div>
    <input name="channelname" type="text" id="channel-input" placeholder="channel name">
    <button type="button" onclick="subscribe(<?php echo $userId?>)">Subscribe</button>
    <br><br>
    <section id="subscribe-message"> </section>
</div>

<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

</body>
</html>