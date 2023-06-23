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
    <script type="text/javascript">
        const userid='<?php echo $userId;?>';
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="main.js"></script>
    <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
<h3>Welcome <?php echo $username; ?> </h3>

<div>
    <p>Your files (ID, UserID, FileName, FilePath, Size)</p>
    <section id="user-files"> </section>
</div>

<div>
    <br>
    <button type="button" onclick="showMostPopularFile()">Show most popular file</button>
    <br><br>
    <section id="popular-file"> </section>
</div>
<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

</body>
</html>