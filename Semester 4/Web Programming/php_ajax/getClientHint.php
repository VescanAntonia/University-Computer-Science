<?php

function handleCall(){
    //methos used in the lending process to show the client that borrows it
    $error_client_id = "";
    $clientID = 0;


    if (empty($_GET["clientID"])) {
        $error_client_id = "Client ID number is required.";
    } else {
        $clientID = test_input($_GET["clientID"]);
        if (is_numeric($clientID)) {
            $clientID = (int)$clientID;
        } else {
            $error_client_id = "ID number must be an integer.";
        }
    }

    if (!empty($error_client_id)) {
        echo $error_client_id;
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

    $sql="SELECT * FROM `clients` WHERE `ID` = '".$clientID."'";

    $result = $connection->query($sql);
    if($result && $result->num_rows === 1){
        $row =  $result->fetch_assoc();
        echo $row['firstname'] . " " . $row['lastname'];
    }
    else{
        echo "No client with that id.";
    }
}

function test_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

handleCall();

?>