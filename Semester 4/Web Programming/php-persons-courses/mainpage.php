<?php
include ('connection.php');
session_start();
if (isset($_SESSION['username'])){
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="main.js"></script>
    <link rel="stylesheet" type="text/css" href="main.css">


</head>
<body>
<h3>Welcome <?php echo $username; ?> ! </h3>

<br>

<br>
<div>
    <input name="course" type="text" id="course-input" placeholder="course name">
    <button type="button" onclick="showParticipants()">Show participants</button>
    <br>
</div>
<section id="participants"> </section>
<br>

<br>
<div>
    <input name="student" type="text" id="student-input" placeholder="student name">
    <button type="button" onclick="showCourses()">Show courses in which participates</button>
    <br>
</div>
<section id="courses"> </section>
<br>


<div>
    <!-- <input type="number" id="doc-id-input" placeholder="document ID"><br> -->
    
    <input type="text" id="coursename-input" placeholder="course name"><br>
    <input type="text" id="studentname-input" placeholder="student name"><br>
    <input type="text" id="grade-input" placeholder="grade"><br>
    <!-- <input type="text" id="keyword3-input" placeholder="keyword3"><br>
    <input type="text" id="keyword4-input" placeholder="keyword4"><br>
    <input type="text" id="keyword5-input" placeholder="keyword5"><br><br> -->
    <button type="button" onclick="addGrade('<?php echo $userId; ?>')">Add grade</button>
    <br><br>
    <section id="added-message"> </section>
</div>


<!-- 
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
    
    <input type="text" id="topicname-input" placeholder="topic name"><br>
    <input type="text" id="textInput" placeholder="text"><br><br>
    <button type="button" onclick="addPost('<?php echo $username; ?>')">Add post</button>
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