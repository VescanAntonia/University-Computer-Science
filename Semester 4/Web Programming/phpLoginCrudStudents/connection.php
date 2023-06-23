<?php
 
    $con=mysqli_connect('localhost','root','','example1db');
 
    if(!$con)
    {
        die('Connection error.'.mysqli_error($con));
    }
?>