<!DOCTYPE html>
<html>
<head>
    <title>Book managment</title>
    <link href="css/lab7_final.css" type="text/css" rel="stylesheet">
    <script src="js/lab7_final.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- <script src="js/jquery-3.4.1.min.js"></script> -->
</head>
<body onload="prepareBookHandling()">
    <div id="book-manager-container">
        <div id="book_handling">
            <form method="POST" id="book-form">
                <label for="id">Id:</label><br>
                <input type="number" id="id" name="id"><br>
                <label for="author">Author:</label><br>
                <input type="text" id="author" name="author"><br>
                <label for="genre">Genre:</label><br>
                <input type="text" id="genre" name="genre"><br>
                <label for="title">Title:</label><br>
                <input type="text" id="title" name="title"><br>
                <label for="pages">Pages:</label><br>
                <input type="number" id="pages" name="pages"><br>
                <input type="button" name="action" value="Add" id="addButton">
                <input type="button" name="action" value="Update" id="updateButton">
                <input type="button" name="action" value="Delete" id="deleteButton">
            </form>
            <label id="result-crud">Result of the command will be displayed here</label>
        </div>
        <div id="book_renting">
            <label>
<pre>The lending of the chosen books
always starts on the current day</pre></label>
            <!-- <form method="POST" id="add-book-lend"> -->
            <form method="UPDATE" id="add-book-lend">
                <label for="id-book-to-lend">Book id:</label><br>
                <input type="number" id="id-book-to-lend" name="id-book" onkeyup="showHintBook(this.value)">
                <label id="label-of-book-ajax-search"></label><br>
                <label for="id-for-client">Client id:</label><br>
                <input type="number" id="id-for-client" name="id-client" onkeyup="showHintClient(this.value)">
                <label id="label-of-client-ajax-search"></label><br>
                <label for="return-date">Return date:</label><br>
                <input type="date" id="return-date" name="return-date">
                <input type="button" name="action" value="Lend" id="lendButton">
            </form>
            <label id="result-lend">Result of the command will be displayed here</label>
        </div>
    </div>
    <hr>
    <a id="return-to-main-page" href="index.php">Main page</a>
</body>
</html>