<?php
include ('connection.php');
//include ('Asset.php');

try {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // $con = OpenConnection();
        // $json = json_decode(file_get_contents('php://input'), true);
        if (isset($_POST['title'])&& isset($_POST['description'])&& isset($_POST['url'])){
        $username = $_POST['username'];
        $title = $_POST['title'];
        $description = $_POST['description'];
        $url = $_POST['url'];
        $con = OpenConnection();

        $query = "SELECT id FROM users where user='$username'";
        
        
        $result = mysqli_query($con, $query);
        if($result && mysqli_num_rows($result)>0){
            $row = mysqli_fetch_row($result);
            $userId = (int) $row[0];               

        }
            
        $myDate = date("Y-m-d");
        //$mysqli->query("insert into articles (user, journalid, summary, date) values ('$username', '$summary')") or die ($mysqli->error);
        $sql = sprintf("INSERT into contents(date, title, description, url,userid) values ('$myDate','$title', '$description','$url','$userId')");
        $con->query($sql);
        echo "Added successfully";}
        else {echo "Failed to add";}
        

        


        header('HTTP/1.1 200 OK');
        CloseConnection($con);
        
        exit;
    }
    

} catch (Exception $e) {
    header('HTTP/1.1 500 INTERNAL_SERVER_ERROR');
    exit;
}

