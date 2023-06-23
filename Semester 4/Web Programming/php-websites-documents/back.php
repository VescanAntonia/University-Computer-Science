<?php
include ('connection.php');

function checkKeywords($userKeys, $k1,$k2,$k3,$k4,$k5) {
    $count = 0;
    $all_keys = array($k1,$k2,$k3,$k4,$k5);
    for($i=0; $i < sizeof($userKeys); $i++){
        if (in_array($userKeys[$i], $all_keys))
            $count++;
    }
    if($count==3)
        return true;
    return false;
}

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $con = OpenConnection();
        $json = json_decode(file_get_contents('php://input'), true);
        $action = $json['action'];
        if($action == "find-docs"){
            $keywords = $json['keywords'];
            $query = "SELECT * FROM documents";
            $result = mysqli_query($con, $query);
            if(mysqli_num_rows($result)>0){
                echo "<table border='1'>";
                echo "<tr>";
                echo "<th>ID</th>";
                echo "<th>ID website</th>";
                echo "<th>Name</th>";
                echo "<th>keyword1</th>";
                echo "<th>keyword2</th>";
                echo "<th>keyword3</th>";
                echo "<th>keyword4</th>";
                echo "<th>keyword5</th>";
                echo "</tr>";
                while ($row = mysqli_fetch_array($result)){
                    if(checkKeywords($keywords,$row['keyword1'],$row['keyword2'],$row['keyword3'],$row['keyword4'],$row['keyword5'])){
                        echo "<tr>";
                        echo "<td>".$row['id']."</td>";
                        echo "<td>".$row['idwebsite']."</td>";
                        echo "<td>".$row['name']."</td>";
                        echo "<td>".$row['keyword1']."</td>";
                        echo "<td>".$row['keyword2']."</td>";
                        echo "<td>".$row['keyword3']."</td>";
                        echo "<td>".$row['keyword4']."</td>";
                        echo "<td>".$row['keyword5']."</td>";
                        echo "</tr>";
                    }
                }
                echo "</table>";
            }
            header('HTTP/1.1 200 OK');
        }
        CloseConnection($con);
    }
    else if (isset($_GET['docid']))
    {
        $docid = $_GET['docid'];
        $keyword1 = $_GET['keyword1'];
        $keyword2 = $_GET['keyword2'];
        $keyword3 = $_GET['keyword3'];
        $keyword4 = $_GET['keyword4'];
        $keyword5 = $_GET['keyword5'];
        $con = OpenConnection();

        $sql = sprintf("UPDATE documents SET keyword1='%s',
                                                    keyword2='%s',
                                                    keyword3='%s',
                                                    keyword4='%s',
                                                    keyword5='%s'
                                     WHERE id='%d'",$keyword1,$keyword2,$keyword3,$keyword4,$keyword5,$docid);
        $con->query($sql);

        header('HTTP/1.1 200 OK');
        CloseConnection($con);
        exit;
    }
    else if (isset($_GET['action']) && $_GET['action']="show-websites")
    {
        $con = OpenConnection();

        $query = "SELECT * FROM websites";
        $result = mysqli_query($con, $query);
        if(mysqli_num_rows($result)>0){
            echo "<table border=1>";
            echo "<tr>";
            echo "<th>ID</th>";
            echo "<th>URL</th>";
            echo "<th>No. of documents</th>";
            echo "</tr>";
            while ($row = mysqli_fetch_array($result)){
                echo "<tr>";
                echo "<td>".$row['id']."</td>";
                echo "<td>".$row['URL']."</td>";
                $sql = "SELECT count(id) AS countID FROM documents where idwebsite=".$row['id'];
                $query2 = $con->query($sql);
                $r = mysqli_fetch_row($query2);
                $count= $r[0];
                echo "<td>".$count."</td>";
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