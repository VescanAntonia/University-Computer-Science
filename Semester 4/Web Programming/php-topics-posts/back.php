<?php
include ('connection.php');


try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // $con = OpenConnection();
        // $json = json_decode(file_get_contents('php://input'), true);
        $username = $_POST['username'];
        $topicname = $_POST['topicname'];
        $text = $_POST['text'];
        $con = OpenConnection();

        $query = "SELECT id FROM topics where topicname='$topicname'";
        
        $result = mysqli_query($con, $query);
        if($result && mysqli_num_rows($result)>0){
            $row = mysqli_fetch_row($result);
            $Id = (int) $row[0];               

        }
        else{
            $sql = sprintf("INSERT into topics(topicname) values ('$topicname')");
            $con->query($sql);
            $query = "SELECT id FROM topics where topicname='$topicname'";
        
            $result = mysqli_query($con, $query);
            $row = mysqli_fetch_row($result);
            $Id = (int) $row[0];
        }
        $myDate = date("Y-m-d");
        //$mysqli->query("insert into articles (user, journalid, summary, date) values ('$username', '$summary')") or die ($mysqli->error);
        $sql = sprintf("INSERT into posts(user, topicid, text, date) values ('$username','$Id', '$text','$myDate')");
        $con->query($sql);
        echo "Added successfully";
        // alert("New article added %user, %journal, %summary, %date",$username,$Id,$summary,$myDate);

        $currentUsername = $username; // Replace with the actual current user ID
        // $notificationMessage = "New article added: User - $username, Journal - $journalname, Summary - $summary, Date - $myDate";
        // notifyUser($currentUsername, $notificationMessage); // Replace this with your notification mechanism


        header('HTTP/1.1 200 OK');
        CloseConnection($con);
        //$uid = $json['userid'];
    //    $names = $json['name'];
    //    $descriptions = $json['desc'];
    //    $values = $json['value'];

    //    for($i=0; $i < sizeof($names); $i++){

    //        $sql = sprintf("INSERT INTO assets (userid, name, description, value) VALUES (%d,'%s','%s',%d)",$uid,$names[$i],$descriptions[$i],$values[$i]);

    //        $con->query($sql);
    //    }

        // header('HTTP/1.1 200 OK');

        // CloseConnection($con);
        exit;
    }
    else if (isset($_GET['postid']))
    {
        $postid = $_GET['postid'];
        $username = $_GET['username'];
        $topicid = $_GET['topicid'];
        $text = $_GET['text'];
        $con = OpenConnection();
        $myDate = date("Y-m-d");

        $sql = sprintf("UPDATE posts SET user='%s',
                                                    topicid='%s',
                                                    text='%s',
                                                    date='%s'
                                     WHERE id='%d'",$username,$topicid,$text,$myDate,$postid);
        $con->query($sql);

        header('HTTP/1.1 200 OK');
        CloseConnection($con);
        exit;
    }
    // else if (isset($_GET['action']) && $_GET['action']="show-websites")
    // {
    //     $con = OpenConnection();

    //     $query = "SELECT * FROM websites";
    //     $result = mysqli_query($con, $query);
    //     if(mysqli_num_rows($result)>0){
    //         echo "<table border=1>";
    //         echo "<tr>";
    //         echo "<th>ID</th>";
    //         echo "<th>URL</th>";
    //         echo "<th>No. of documents</th>";
    //         echo "</tr>";
    //         while ($row = mysqli_fetch_array($result)){
    //             echo "<tr>";
    //             echo "<td>".$row['id']."</td>";
    //             echo "<td>".$row['URL']."</td>";
    //             $sql = "SELECT count(id) AS countID FROM documents where idwebsite=".$row['id'];
    //             $query2 = $con->query($sql);
    //             $r = mysqli_fetch_row($query2);
    //             $count= $r[0];
    //             echo "<td>".$count."</td>";
    //             echo "</tr>";
    //         }
    //         echo "</table>";
    //     }
    //     header('HTTP/1.1 200 OK');
    //     CloseConnection($con);
    // }
} catch (Exception $e) {
    header('HTTP/1.1 500 INTERNAL_SERVER_ERROR');
    exit;
}