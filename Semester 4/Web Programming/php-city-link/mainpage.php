<?php
include ('connection.php');
session_start();
// if (isset($_SESSION['username'])){
//     $userId = $_SESSION['id'];
//     $username = $_SESSION['username'];

// }
// else {
//     header('Location: index.php');
//     die();
// }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Welcome user</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="main.js"></script>
    <link rel="stylesheet" type="text/css" href="main.css">


</head>
<body>
<h3>Welcome! </h3>

<br>


<div>
    <p>The Cities</p>
    <?php
    $con = OpenConnection();
    $query = "SELECT * FROM cities";
    $result = mysqli_query($con, $query);
    if(mysqli_num_rows($result)>0){
        echo "<table>";
        echo "<tr>";
        echo "<th>ID</th>";
        echo "<th>Name</th>";
        echo "<th>County</th>";
        echo "</tr>";
        while ($row = mysqli_fetch_array($result)){
            echo "<tr>";
            echo "<td>".$row['id']."</td>";
            echo "<td>".$row['name']."</td>";
            echo "<td>".$row['county']."</td>";
            echo "</tr>";
        }
        echo "</table>";
    }

    CloseConnection($con);
    ?>
</div>
<br>
<form action="mainpage2.php" method="POST">
        <label for="city">Enter a city:</label>
        <input type="text" name="city" id="city" required>
        <input type="submit" value="Show links">
    </form>
<br>







<!-- <br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br> -->

</body>
</html>