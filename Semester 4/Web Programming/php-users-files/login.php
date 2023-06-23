<?php
session_start();

if(isset($_POST['submit'])) {
    include('connection.php');
    $username = $_POST['username'];
    $password = $_POST['password'];
    $dbUserName = "";
    $dbPassword = "";

    $con = OpenConnection();
    $sql = "SELECT id,username,password FROM users where username = '$username' LIMIT 1";
    $query = $con->query($sql);
    if(mysqli_num_rows($query)>0) {
        $row = mysqli_fetch_row($query);
        $userId= $row[0];
        $dbUserName = $row[1];
        $dbPassword = $row[2];
    }
    if($username == $dbUserName && $password == $dbPassword) {
        $_SESSION['username'] = $username;
        $_SESSION['id'] = $userId;
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
    <input type="text" name = "username" placeholder="Enter username">
    <br> <br>
    <input type="password" name="password" placeholder="Enter password here">
    <br> <br>
    <input type="submit" name="submit" value="Login">
</form>


</body>
</html>