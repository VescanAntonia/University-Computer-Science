<?php
session_start();

if(isset($_POST['submit'])) {
    include('connection.php');
    $username = $_POST['username'];

    $con = OpenConnection();
    $sql = "SELECT user FROM posts where user = '$username' LIMIT 1";
    $query = $con->query($sql);
    if($query) {
        $row = mysqli_fetch_row($query);
        // $userId= $row[0];
        $dbUserName = $row[0];
    }
    if($username == $dbUserName) {
        $_SESSION['username'] = $username;
        // $_SESSION['id'] = $userId;
        header('Location: mainpage.php');
    }
    else {
        echo "<b><i>Incorrect credentials</i><b>";

    }
    CloseConnection($con);
}

?>


<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link type="text/css" href="main.css">
</head>
<body>
<h1>Login</h1>
<form method="post" action="login.php">
    <input type="text" name = "username" placeholder="Enter user name">
    <br><br>
    <input type="submit" name="submit" value="Login">
</form>


</body>
</html>