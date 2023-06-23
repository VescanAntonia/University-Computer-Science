<?php
include ('connection.php');
//include ('Asset.php');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $con = OpenConnection();
        $json = json_decode(file_get_contents('php://input'), true);

        $uid = $json['userid'];
    //    $names = $json['name'];
    //    $descriptions = $json['desc'];
    //    $values = $json['value'];

    //    for($i=0; $i < sizeof($names); $i++){

    //        $sql = sprintf("INSERT INTO assets (userid, name, description, value) VALUES (%d,'%s','%s',%d)",$uid,$names[$i],$descriptions[$i],$values[$i]);

    //        $con->query($sql);
    //    }

        header('HTTP/1.1 200 OK');

        CloseConnection($con);
        exit;
    }
    else if (isset($_GET['name']))
    {
        $name = $_GET['name'];
        $con = OpenConnection();
        $sql = "SELECT id FROM persons where name = '$name' LIMIT 1";
        $query = $con->query($sql);
        $row = mysqli_fetch_row($query);
        $userId= $row[0];

        $query = "SELECT * FROM channels WHERE ownerid='$userId'";
        $result = mysqli_query($con, $query);
        if(mysqli_num_rows($result)>0){
            echo "<table>";
            echo "<tr>";
            echo "<th>ID</th>";
            echo "<th>OwnerID</th>";
            echo "<th>Name</th>";
            echo "<th>Description</th>";
            echo "<th>Subscribers</th>";
            echo "</tr>";
            while ($row = mysqli_fetch_array($result)){
                echo "<tr>";
                echo "<td>".$row['id']."</td>";
                echo "<td>".$row['ownerid']."</td>";
                echo "<td>".$row['name']."</td>";
                echo "<td>".$row['description']."</td>";
                echo "<td>".$row['subscribers']."</td>";
                echo "</tr>";
            }
            echo "</table>";
        }
        header('HTTP/1.1 200 OK');
        CloseConnection($con);
    }
    else if (isset($_GET['userid']) && !isset($_GET['channel']))
    {
        $id = $_GET['userid'];
        $con = OpenConnection();

        $query = "SELECT name,description,subscribers FROM channels";
        $result = mysqli_query($con, $query);
        if(mysqli_num_rows($result)>0){
            echo "<table>";
            echo "<tr>";
            echo "<th>Name</th>";
            echo "<th>Description</th>";
            echo "</tr>";
            while ($row = mysqli_fetch_array($result)){
                $subs_arr = explode (",", $row['subscribers']);
                foreach($subs_arr as $element) {
                    $sub = explode (":", $element);
                    if($sub[0] == $id){
                        echo "<tr>";
                        echo "<td>".$row['name']."</td>";
                        echo "<td>".$row['description']."</td>";
                        echo "</tr>";
                        break;
                    }
                }
            }
            echo "</table>";
        }
        header('HTTP/1.1 200 OK');
        CloseConnection($con);
    }
    else if (isset($_GET['channel']))
    {
        $id = $_GET['userid'];
        $chname = $_GET['channel'];
        $newSubs = "";
        $con = OpenConnection();

        $query = "SELECT subscribers FROM channels where name='".$chname."'";
        $result = mysqli_query($con, $query);
        if(mysqli_num_rows($result)>0){
            if ($row = mysqli_fetch_array($result)){
                $subs_arr = explode (",", $row['subscribers']);
                $found = false;
                foreach($subs_arr as $element) {
                    $sub = explode (":", $element);
                    if (isset($sub[0]) && isset($sub[1])) {
                    if($sub[0] == $id){
                      $sub[1] = date("Y-m-d");
                      $found = true;
                    }
                    $newSubs = $newSubs.$sub[0].":".$sub[1].",";
                        }
                    }
                if(!$found)
                    $newSubs = $newSubs.$id.":".date("Y-m-d");

                $sql = sprintf("UPDATE channels SET subscribers='%s' WHERE name='%s'",$newSubs,$chname);
                $con->query($sql);
                echo "Subscription successful";
            }
            else
                echo "Subscription failed";

        }
        else
            echo "Subscription failed";
        header('HTTP/1.1 200 OK');
        CloseConnection($con);
    }

} catch (Exception $e) {
    header('HTTP/1.1 500 INTERNAL_SERVER_ERROR');
    exit;
}