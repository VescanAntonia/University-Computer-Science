<?php
include ('connection.php');
//include ('Asset.php');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // $con = OpenConnection();
        // $json = json_decode(file_get_contents('php://input'), true);
        $username = $_POST['username'];
        $journalname = $_POST['journalname'];
        $summary = $_POST['summary'];
        $con = OpenConnection();

        $query = "SELECT id FROM journals where name='$journalname'";
        
        $result = mysqli_query($con, $query);
        if($result && mysqli_num_rows($result)>0){
            $row = mysqli_fetch_row($result);
            $Id = (int) $row[0];               

        }
        else{
            $sql = sprintf("INSERT into journals(name) values ('$journalname')");
            $con->query($sql);
            $query = "SELECT id FROM journals where name='$journalname'";
        
            $result = mysqli_query($con, $query);
            $row = mysqli_fetch_row($result);
            $Id = (int) $row[0];
        }
        $myDate = date("Y-m-d");
        //$mysqli->query("insert into articles (user, journalid, summary, date) values ('$username', '$summary')") or die ($mysqli->error);
        $sql = sprintf("INSERT into articles(user, journalid, summary, date) values ('$username','$Id', '$summary','$myDate')");
        $con->query($sql);
        echo "Added successfully";
        // alert("New article added %user, %journal, %summary, %date",$username,$Id,$summary,$myDate);

        $currentUsername = $username; // Replace with the actual current user ID
        $notificationMessage = "New article added: User - $username, Journal - $journalname, Summary - $summary, Date - $myDate";
        notifyUser($currentUsername, $notificationMessage); // Replace this with your notification mechanism


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
    else if (isset($_GET['journal'])&& !isset($_GET['summary']))
    {
        $name = $_GET['journal'];
        $id = $_GET['username'];
        $con = OpenConnection();
        $sql = "SELECT id FROM journals where name = '$name' LIMIT 1";
        $query = $con->query($sql);
        $row = mysqli_fetch_row($query);
        $journalId= $row[0];
        
        $query = "SELECT * FROM articles WHERE journalid='$journalId' and user='$id'";
        $result = mysqli_query($con, $query);
        if($result && mysqli_num_rows($result)>0){
            echo "<table>";
            echo "<tr>";
            echo "<th>ID</th>";
            echo "<th>User</th>";
            echo "<th>JournalId</th>";
            echo "<th>Summary</th>";
            echo "<th>Date</th>";
            echo "</tr>";
            while ($row = mysqli_fetch_array($result)){
                echo "<tr>";
                echo "<td>".$row['id']."</td>";
                echo "<td>".$row['user']."</td>";
                echo "<td>".$row['journalid']."</td>";
                echo "<td>".$row['summary']."</td>";
                echo "<td>".$row['date']."</td>";
                echo "</tr>";
            }
            echo "</table>";

           
        }
        header('HTTP/1.1 200 OK');
        CloseConnection($con);
    }
    else if (isset($_POST['journalname'])&& isset($_POST['summary']))
    {
        $username = $_POST['username'];
        $journalname = $_POST['journalname'];
        $summary = $_POST['summary'];
        $con = OpenConnection();

        $query = "SELECT id FROM journals where name='$journalname'";
        
        $result = mysqli_query($con, $query);
        if($result && mysqli_num_rows($result)>0){
            $row = mysqli_fetch_row($result);
            $Id = (int) $row[0];               

        }
        else{
            $sql = sprintf("INSERT into journals values ('$journalname')");
            $con->query($sql);
            $query = "SELECT id FROM journals where name='$journalname'";
        
            $result = mysqli_query($con, $query);
            $row = mysqli_fetch_row($result);
            $Id = (int) $row[0];
        }
        $myDate = date("Y-m-d");
        //$mysqli->query("insert into articles (user, journalid, summary, date) values ('$username', '$summary')") or die ($mysqli->error);
        $sql = sprintf("INSERT into articles(user, journalid, summary, date) values ('$username','$Id', '$summary','$myDate')");
        $con->query($sql);
        echo "Added successfully";

        header('HTTP/1.1 200 OK');
        CloseConnection($con);
        
    }

    // else if (isset($_GET['userid']) && !isset($_GET['channel']))
    // {
    //     $id = $_GET['userid'];
    //     $con = OpenConnection();

    //     $query = "SELECT name,description,subscribers FROM channels";
    //     $result = mysqli_query($con, $query);
    //     if(mysqli_num_rows($result)>0){
    //         echo "<table>";
    //         echo "<tr>";
    //         echo "<th>Name</th>";
    //         echo "<th>Description</th>";
    //         echo "</tr>";
    //         while ($row = mysqli_fetch_array($result)){
    //             $subs_arr = explode (",", $row['subscribers']);
    //             foreach($subs_arr as $element) {
    //                 $sub = explode (":", $element);
    //                 if($sub[0] == $id){
    //                     echo "<tr>";
    //                     echo "<td>".$row['name']."</td>";
    //                     echo "<td>".$row['description']."</td>";
    //                     echo "</tr>";
    //                     break;
    //                 }
    //             }
    //         }
    //         echo "</table>";
    //     }
    //     header('HTTP/1.1 200 OK');
    //     CloseConnection($con);
    // }
    // else if (isset($_GET['channel']))
    // {
    //     $id = $_GET['userid'];
    //     $chname = $_GET['channel'];
    //     $newSubs = "";
    //     $con = OpenConnection();

    //     $query = "SELECT subscribers FROM channels where name='".$chname."'";
    //     $result = mysqli_query($con, $query);
    //     if(mysqli_num_rows($result)>0){
    //         if ($row = mysqli_fetch_array($result)){
    //             $subs_arr = explode (",", $row['subscribers']);
    //             $found = false;
    //             foreach($subs_arr as $element) {
    //                 $sub = explode (":", $element);
    //                 if (isset($sub[0]) && isset($sub[1])) {
    //                 if($sub[0] == $id){
    //                   $sub[1] = date("Y-m-d");
    //                   $found = true;
    //                 }
    //                 $newSubs = $newSubs.$sub[0].":".$sub[1].",";
    //                     }
    //                 }
    //             if(!$found)
    //                 $newSubs = $newSubs.$id.":".date("Y-m-d");

    //             $sql = sprintf("UPDATE channels SET subscribers='%s' WHERE name='%s'",$newSubs,$chname);
    //             $con->query($sql);
    //             echo "Subscription successful";
    //         }
    //         else
    //             echo "Subscription failed";

    //     }
    //     else
    //         echo "Subscription failed";
    //     header('HTTP/1.1 200 OK');
    //     CloseConnection($con);
    // }

} catch (Exception $e) {
    header('HTTP/1.1 500 INTERNAL_SERVER_ERROR');
    exit;
}

function notifyUser($userId, $message) {
    // Implement your notification mechanism here
    // You can send an email, display a pop-up message, use websockets, etc.
    // This function is a placeholder, you need to replace it with your own implementation
    echo "Notification sent to User $userId: $message";
}