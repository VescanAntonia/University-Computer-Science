<?php
session_start();

if(isset($_POST['submit'])) {
    include('connection.php');
    $username = $_POST['username'];
    $password = $_POST['password'];
    // $role = $_POST['role'];

    $con = OpenConnection();
    $sql = "SELECT id,user,password,role FROM users where user = '$username' LIMIT 1";
    $query = $con->query($sql);
    if($query) {
        $row = mysqli_fetch_row($query);
        $userId= $row[0];
        $dbUserName = $row[1];
        $dbpassword=$row[2];
        $dbrole=$row[3];
    }
    if($username == $dbUserName&&$dbrole==1&&$password == $dbpassword) {
        $_SESSION['username'] = $username;
        $_SESSION['id'] = $userId;
        header('Location: mainpage.php');
    }
    else if($username == $dbUserName&&$dbrole==2&&$password == $dbpassword){
        $_SESSION['username'] = $username;
        $_SESSION['id'] = $userId;
        header('Location: mainpagecreator.php');
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
    <input type="password" name = "password" placeholder="Enter password">
    <!-- <input type="text" name = "role" placeholder="Enter role"> -->
    <br><br>
    <input type="submit" name="submit" value="Login">
</form>


</body>
</html>