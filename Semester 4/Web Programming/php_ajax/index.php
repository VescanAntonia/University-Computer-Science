<?php
session_start();
$_SESSION["col"] = "Welcome!";
?>

<!DOCTYPE html>
<html>
    <head>
        <title>Book renting site </title>
        <link href="css/lab7_final.css" type="text/css" rel="stylesheet">
        <script src="js/lab7_final.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- <script src="js/jquery-3.4.1.min.js"></script> -->
    </head>
    <body>
        <main>
            <div>
                <p>
                    <?php echo $_SESSION["col"] ?>
                </p>
                <form action="listBooks.php" method="post">
                    <input type="submit" value="List all books">
                </form>
                <form action="booksService.php" method="post">
                    <input type="submit" value="Add,remove,update,lend books">
                </form>
            </div>
        </main>
    </body>
</html>