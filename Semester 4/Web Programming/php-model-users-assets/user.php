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
<html>
<head>
    <title>Welcome user</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="main.js"></script>
    <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
<h3>Welcome <?php echo $username; ?>. </h3>

<div>
    <p>Your assets</p>
    <?php

    $con = OpenConnection();
    $query = "SELECT * FROM Assets WHERE userid='$userId'";
    $result = mysqli_query($con, $query);
    if(mysqli_num_rows($result)>0){
        echo "<table>";
        echo "<tr>";
        echo "<th>Name</th>";
        echo "<th>Description</th>";
        echo "<th>Value</th>";
        echo "</tr>";
        while ($row = mysqli_fetch_array($result)){
            echo "<tr>";
            if ((int)$row['value']>10){
                echo "<td class='red'>".$row['name']."</td>";
                echo "<td class='red'>".$row['description']."</td>";
                echo "<td class='red'>".$row['value']."</td>";
            }
            else{
                echo "<td>".$row['name']."</td>";
                echo "<td>".$row['description']."</td>";
                echo "<td>".$row['value']."</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
    }

    CloseConnection($con);
    ?>
</div>
<div>
    <input name="name" type="text" id="name-input" placeholder="name">
    <input name="description" type="text" id="description-input" placeholder="description">
    <input name="value" type="text" id="value-input" placeholder="value">
    <button type="button" onclick="push()">Push</button>
    <button type="button" onclick="add(<?php echo $userId?>)">Add the pushed ones</button>
    <br>
</div>
<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

</body>
</html>