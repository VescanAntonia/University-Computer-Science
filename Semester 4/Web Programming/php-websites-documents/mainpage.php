<?php
include ('connection.php');
session_start();
//if (isset($_SESSION['id'])){
//    $userId = $_SESSION['id'];
//    $username = $_SESSION['username'];
//
//}
//else {
//    header('Location: login.php');
//    die();
//}

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
<h3>Welcome</h3>

<div>
    <p>The documents</p>
    <?php
    $con = OpenConnection();
    $query = "SELECT * FROM documents";
    $result = mysqli_query($con, $query);
    if(mysqli_num_rows($result)>0){
        echo "<table>";
        echo "<tr>";
        echo "<th>ID</th>";
        echo "<th>ID website</th>";
        echo "<th>Name</th>";
        echo "<th>keyword1</th>";
        echo "<th>keyword2</th>";
        echo "<th>keyword3</th>";
        echo "<th>keyword4</th>";
        echo "<th>keyword5</th>";
        echo "</tr>";
        while ($row = mysqli_fetch_array($result)){
            echo "<tr>";
            echo "<td>".$row['id']."</td>";
            echo "<td>".$row['idwebsite']."</td>";
            echo "<td>".$row['name']."</td>";
            echo "<td>".$row['keyword1']."</td>";
            echo "<td>".$row['keyword2']."</td>";
            echo "<td>".$row['keyword3']."</td>";
            echo "<td>".$row['keyword4']."</td>";
            echo "<td>".$row['keyword5']."</td>";
            echo "</tr>";
        }
        echo "</table>";
    }

    CloseConnection($con);
    ?>
</div>
<br>
<div>
    <input type="number" id="doc-id-input" placeholder="document ID"><br>
    <input type="text" id="keyword1-input" placeholder="keyword1"><br>
    <input type="text" id="keyword2-input" placeholder="keyword2"><br>
    <input type="text" id="keyword3-input" placeholder="keyword3"><br>
    <input type="text" id="keyword4-input" placeholder="keyword4"><br>
    <input type="text" id="keyword5-input" placeholder="keyword5"><br><br>
    <button type="button" onclick="updateKeywords()">Update keywords</button>
    <br>
</div>
<br>
<button type="button" onclick="showWebsites()">Show websites</button>
<br><br>
<section id="websites-section"></section>
<br>
<input type="text" id="keywords-input" placeholder="insert keywords">
<button type="button" onclick="findDocuments()">Find documents by keywords</button>
<br><br>
<section id="documents-section"></section>
<br>
</body>
</html>