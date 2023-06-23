<?php
include ('connection.php');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $con = OpenConnection();
        $json = json_decode(file_get_contents('php://input'), true);

        $uid = $json['userid'];
//        $names = $json['name'];
//        $descriptions = $json['desc'];
//        $values = $json['value'];
//
//        for($i=0; $i < sizeof($names); $i++){
//
//            $sql = sprintf("INSERT INTO assets (userid, name, description, value) VALUES (%d,'%s','%s',%d)",$uid,$names[$i],$descriptions[$i],$values[$i]);
//
//            $con->query($sql);
//        }

        header('HTTP/1.1 200 OK');

        CloseConnection($con);
        exit;
    }
    else if (isset($_GET['action']) && $_GET['action']=="get-files")
    {
        $uid = $_GET['userid'];
        $con = OpenConnection();
        $query = "SELECT * FROM files WHERE userid='".$uid."'";
        $result = mysqli_query($con, $query);
        if(mysqli_num_rows($result)>0){
            echo "<table border='1' background-color='cadetblue' id='data'>";
            while ($row = mysqli_fetch_array($result)){
                echo "<tr>";
                echo "<td>".$row['id']."</td>";
                echo "<td>".$row['userid']."</td>";
                echo "<td>".$row['filename']."</td>";
                echo "<td>".$row['filepath']."</td>";
                echo "<td>".$row['size']."</td>";
                echo "</tr>";
            }
            echo "</table>";
        }
        header('HTTP/1.1 200 OK');
        CloseConnection($con);
    }
} catch (Exception $e) {
    header('HTTP/1.1 500 INTERNAL_SERVER_ERROR');
    exit;
}