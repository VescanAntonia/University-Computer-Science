<?php
include ('connection.php');
include ('Asset.php');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $con = OpenConnection();
        $json = json_decode(file_get_contents('php://input'), true);

        $uid = $json['userid'];
        $names = $json['name'];
        $descriptions = $json['desc'];
        $values = $json['value'];

        for($i=0; $i < sizeof($names); $i++){

            $sql = sprintf("INSERT INTO assets (userid, name, description, value) VALUES (%d,'%s','%s',%d)",$uid,$names[$i],$descriptions[$i],$values[$i]);

            $con->query($sql);
        }

        header('HTTP/1.1 200 OK');

        CloseConnection($con);
        exit;
    }
} catch (Exception $e) {
    header('HTTP/1.1 500 INTERNAL_SERVER_ERROR');
    exit;
}