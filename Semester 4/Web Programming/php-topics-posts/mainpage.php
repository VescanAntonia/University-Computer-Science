<?php
include ('connection.php');
session_start();
if (isset($_SESSION['username'])){
    // $userId = $_SESSION['id'];
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="main.js"></script>
    <link rel="stylesheet" type="text/css" href="main.css">

    <script src="https://js.pusher.com/7.0/pusher.min.js"></script>

</head>
<body>
<h3>Welcome <?php echo $username; ?> ! </h3>

<br>

<div>
    <p>The posts</p>
    <?php
    $con = OpenConnection();
    $query = "SELECT * FROM posts";
    $result = mysqli_query($con, $query);
    if(mysqli_num_rows($result)>0){
        echo "<table>";
        echo "<tr>";
        echo "<th>ID</th>";
        echo "<th>User</th>";
        echo "<th>TopicId</th>";
        echo "<th>Text</th>";
        echo "<th>Date</th>";
        echo "</tr>";
        while ($row = mysqli_fetch_array($result)){
            echo "<tr>";
            echo "<td>".$row['id']."</td>";
            echo "<td>".$row['user']."</td>";
            echo "<td>".$row['topicid']."</td>";
            echo "<td>".$row['text']."</td>";
            echo "<td>".$row['date']."</td>";
            echo "</tr>";
        }
        echo "</table>";
    }

    CloseConnection($con);
    ?>
</div>

<br>
<div>
    <input type="number" id="post-id-input" placeholder="post ID"><br>
    <input type="text" id="topicId-input" placeholder="topic id"><br>
    <input type="text" id="text-input" placeholder="text"><br><br>
    <button type="button" onclick="updatePosts('<?php echo $username; ?>')">Update post</button>
    <br>
</div>
<br>

<br>

<div>
    <!-- <input type="number" id="doc-id-input" placeholder="document ID"><br> -->
    
    <input type="text" id="topicname-input" placeholder="topic name"><br>
    <input type="text" id="textInput" placeholder="text"><br><br>
    <!-- <input type="text" id="keyword3-input" placeholder="keyword3"><br>
    <input type="text" id="keyword4-input" placeholder="keyword4"><br>
    <input type="text" id="keyword5-input" placeholder="keyword5"><br><br> -->
    <button type="button" onclick="addPost('<?php echo $username; ?>')">Add post</button>
    <br><br>
    <section id="added-message"> </section>
</div>

<!-- <div>
    <input name="journal" type="text" id="journal-input" placeholder="journal name">
    <button type="button" onclick="showArticles('<?php echo $username; ?>')">Show articles</button>
    <br>
</div>
<section id="articles"> </section>
<br> -->
<!--
<div>
    <input type="text" id="journal-name-input" placeholder="journal name"><br>
    <input type="text" id="summary-input" placeholder="summary"><br>
    <button type="button" onclick="addArticle('<?php echo $username; ?>')">Add article</button>
    <br><br>
    <section id="added-message"> </section>
</div> -->


<br>
<form action="logout.php">
    <input type="submit" name="logout" value="Logout">
</form>
<br>

</body>
</html>