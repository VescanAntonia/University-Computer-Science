<html>
<head>
    <title>Browse books</title>
    <link href="css/lab7_final.css" type="text/css" rel="stylesheet">
    <script src="js/lab7_final.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- <script src="js/jquery-3.4.1.min.js"></script> -->
</head>
<body onload='getGenres("")'>
<main id="list-main">

<table id='main_table'>
         <tr>
            <td>
                <table id='table_header'>
                <tr>
                    <th>ID <?php session_start(); echo $_SESSION["col"] ?></th>
                    <th>Author</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Pages</th>
                </tr>                
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div id='table_body_div'>
                    <table id='table_of_contents'>

                    </table>
                </div>
            </td>
        </tr>
</table>

<form>
    Genre: <input type='text' onkeyup='getGenres(this.value)'>  
</form>
    <a href="index.php">Main page</a>


</main>
</body>
</html>