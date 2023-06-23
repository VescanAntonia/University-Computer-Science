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
<h3>View mode</h3>
<h3>Welcome <?php echo $username; ?> ! </h3>




<div>
    <p>All contents</p>
    <?php
    $con = OpenConnection();
    $query = "SELECT * FROM contents";
    $result = mysqli_query($con, $query);
    if(mysqli_num_rows($result)>0){
        echo "<table>";
        echo "<tr>";
        echo "<th>ID</th>";
        echo "<th>Date</th>";
        echo "<th>Title</th>";
        echo "<th>Description</th>";
        echo "<th>URL</th>";
        echo "<th>UserID</th>";
        echo "</tr>";
        while ($row = mysqli_fetch_array($result)){
            echo "<tr>";
            echo "<td>".$row['id']."</td>";
            echo "<td>".$row['Date']."</td>";
            echo "<td>".$row['title']."</td>";
            echo "<td>".$row['description']."</td>";
            echo "<td>".$row['url']."</td>";
            echo "<td>".$row['userid']."</td>";
            echo "</tr>";
        }
        echo "</table>";
    }

    CloseConnection($con);
    ?>
</div>
<section id="newly added"> </section>
<br>
<div>
    
    <button type="button" onclick="getNewContent()">Get new content</button>
    <br>
</div>


<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

</body>
</html>