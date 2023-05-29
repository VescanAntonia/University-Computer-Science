<?php

function handleHintCall(){
    //methos used in the lending process to show the book that is borrowed
    $error_book_id = "";
    $bookID = 0;


    if (empty($_GET["bookID"])) {
        $error_book_id = "Client ID number is required.";
    } else {
        $bookID = test_input($_GET["bookID"]);
        if (is_numeric($bookID)) {
            $bookID = (int)$bookID;
        } else {
            $error_book_id = "ID number must be an integer.";
        }
    }

    if (!empty($error_book_id)) {
        echo $error_book_id;
        return;
    }

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "web_lab7_books";

    $connection = new mysqli($servername, $username, $password, $dbname);

    if ($connection->connect_error) {
        echo "Couldn't connect to database.";
        return;
    }

    $sql="SELECT * FROM `books` WHERE `ID` = '".$bookID."'";

    $result = $connection->query($sql);
    if($result && $result->num_rows === 1){
        $row =  $result->fetch_assoc();
        echo $row['title'] . ", " . $row['author'];
    }
    else{
        echo "No book with that id.";
    }
}

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

handleHintCall();

?>