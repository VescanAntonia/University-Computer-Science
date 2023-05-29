<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "web_lab7_books";

$connection = new mysqli($servername,$username,$password,$dbname);

$q = $_REQUEST['q'];
$resultString = "";

if(!$connection->connect_error) {

    if($q !== "")
        $sqlGenre = "SELECT * FROM `books` where genre like '$q%'";
        // $sqlGenre = "SELECT * FROM `books` where genre = '" . $q . "'";
    else
        $sqlGenre = "SELECT * FROM `books`";
    $result = $connection->query($sqlGenre);

    if ($result && $result->num_rows > 0) {

        while ($row = $result->fetch_assoc()) {
            //appends the results
            $resultString .= "<tr><td>" . $row["ID"] . "</td><td>" . $row["author"] . "</td><td>" . $row["title"] . "</td><td>" . $row["genre"] . "</td><td>" . $row["pages"] . "</td></tr>";
        }


    } else {
        $resultString .= "<tr><th>No results</th></tr>";
    }
}
else {
    $resultString .= "<tr><th>No results</th></tr>";
}

echo $resultString;
?>