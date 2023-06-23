<?php

function OpenConnection(): mysqli
{
    $dbhost = "127.0.0.1";
    $dbusername = "root";
    $dbpassword = "";
    $dbname = "users-assets";

    return mysqli_connect($dbhost, $dbusername, $dbpassword, $dbname);
}

function CloseConnection(mysqli $con)
{
    $con->close();
}