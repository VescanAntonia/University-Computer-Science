function GetXmlHttpObject() {
    //create and return an XMLHttpRequest object, which is used for making asynchronous HTTP requests in JavaScript. 
    //The XMLHttpRequest object allows you to send HTTP requests to a server and receive responses without reloading the entire page
    if (window.XMLHttpRequest) {     // code for IE7+, Firefox, Chrome, Opera, Safari
        return new XMLHttpRequest();
    }
    if (window.ActiveXObject) {         // code for IE6, IE5
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
    return null;
}
function getGenres(stringToFindBy) {
    // retrieve and display data from the server asynchronously based on a given search string
    var xmlhttp;
    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function () {
        if(this.readyState == 4 && this.status == 200){
            document.getElementById('table_of_contents').innerHTML = this.responseText;
        }
    };
    xmlhttp.open("GET","filter.php?q="+stringToFindBy,true);
    xmlhttp.send();
}

function testForPositiveInteger(stringToTest){
    if(Number.isNaN(stringToTest)){
        console.log("Invalid string input string " + stringToTest);
        return false;
    }

    var numID = parseInt(stringToTest);


    if(!Number.isInteger(numID)){
        console.log("Invalid string input string, not integer " + stringToTest);
        return false;
    }
    if(numID < 0){
        console.log("Must be positive " + numID);
        return false;
    }
    return true;
}

function showHintBook(stringOfId) {
    //displays a hint or suggestion for a book based on a provided book ID


    if(!testForPositiveInteger(stringOfId)){
        $('#label-of-client-ajax-search').html("");
        return;
    }

    var numID = parseInt(stringOfId);

    $.get(
        "getBookHint.php",
        {bookID:numID},
        function (data,status) {
            $('#label-of-book-ajax-search').html(data);
        }
    );

}

function showHintClient(stringOfId) {
    //display a hint or suggestion for a client based on a provided client ID


    if(!testForPositiveInteger(stringOfId)){
        $('#label-of-client-ajax-search').html("");
        return;
    }

    var numID = parseInt(stringOfId);

    // if(Number.isNaN(stringOfId)){
    //     console.log("Invalid string input string " + stringOfId);
    //     $('#label-of-client-ajax-search').html("");
    //     return;
    // }
    //
    // var numID = parseInt(stringOfId);
    //
    //
    // if(!Number.isInteger(numID)){
    //     console.log("Invalid string input string, not integer " + stringOfId);
    //     $('#label-of-client-ajax-search').html("");
    //     return;
    // }
    // if(numID < 0){
    //     console.log("Must be positive " + numID);
    //     $('#label-of-client-ajax-search').html("");
    //     return;
    // }

    $.get(
        "getClientHint.php",
        {clientID:numID},
        function (data,status) {
            $('#label-of-client-ajax-search').html(data);
        }
    );

}

function prepareBookHandling(message) {
    $('#addButton').on('click',function () {
        //sets up event handling for the "Add" button click in order to perform an asynchronous POST request 
        //to a server-side script for handling book-related operations.
        var command ="add";
        var author = document.getElementById("author").value;
        var genre = document.getElementById("genre").value;
        var title = document.getElementById("title").value;
        var pages = document.getElementById("pages").value;
        // var url = "handleRequest.php"
        // url = url + "?command=" + command;
        // url = url + "&author=" + author;
        // url = url + "&genre=" + genre;
        // url = url + "&title=" + title;
        // url = url + "&pages=" + pages;

        $.post({
            url: "handleRequest.php",
            data : {command: command,author:author,genre:genre,title:title,pages:pages},
            success:function (data,status) {
                $("#result-crud").html(data);
            },
            error:function(xhr,textStatus, errorThrown){
                alert(errorThrown);
            }
        })

        // var xmlhttp = new GetXmlHttpObject();
        // if (xmlhttp==null)  {
        //     alert ("Your browser does not support XMLHTTP!");
        //     return;
        // }
        // xmlhttp.onreadystatechange = function () {
        //     if(this.readyState == 4 && this.status == 200){
        //         document.getElementById('result').innerHTML = this.responseText;
        //     }
        // };
        // xmlhttp.open("POST",url,true);
        // xmlhttp.send();

    })

    $('#updateButton').on('click',function () {
        //sets up event handling for the "Update" button click to perform an asynchronous POST request to a 
        //server-side script for updating book information
        var command ="update";
        var id = document.getElementById("id").value;
        var author = document.getElementById("author").value;
        var genre = document.getElementById("genre").value;
        var title = document.getElementById("title").value;
        var pages = document.getElementById("pages").value;
        // alert("Update button clicked"); 
        $.post({
            url: "handleRequest.php",
            data : {command: command,id:id,author:author,genre:genre,title:title,pages:pages},
            success:function (data,status) {
                $("#result-crud").html(data);
            },
            error:function(xhr,textStatus, errorThrown){
              alert(errorThrown);
            }
        })
    //     var command = "update";
    // var id = $("#id").val();
    // var author = $("#author").val();
    // var genre = $("#genre").val();
    // var title = $("#title").val();
    // var pages = $("#pages").val();

    // alert("Update button clicked"); 

    // $.ajax({
    //   url: "handleRequest.php",
    //   type: "POST",
    //   data: { command: command, id: id, author: author, genre: genre, title: title, pages: pages },
    //   success: function(data) {
    //     $("#result-crud").html(data);
    //   },
    //   error: function(xhr, textStatus, errorThrown) {
    //     alert(errorThrown);
    //   }
    // });
    })

    $('#deleteButton').on('click',function () {
        //sets up event handling for the "Delete" button click to perform an asynchronous POST request to a server-side script 
        //for deleting a book entry
        var command ="delete";
        var id = document.getElementById("id").value;
        // var url = "handleRequest.php";
        // url = url + "?command=" + command;
        // url = url + "&id=" + id;

        $.post({
            url: "handleRequest.php",
            data : {command: command,id:id},
            success:function (data,status) {
                $("#result-crud").html(data);
            },
            error:function(xhr,textStatus, errorThrown){
                alert(errorThrown);
            }
        })

        // var xmlhttp = new GetXmlHttpObject();
        // if (xmlhttp==null)  {
        //     alert ("Your browser does not support XMLHTTP!");
        //     return;
        // }
        // xmlhttp.onreadystatechange = function () {
        //     if(this.readyState == 4 && this.status == 200){
        //         document.getElementById('result').innerHTML = this.responseText;
        //     }
        // };
        // xmlhttp.open("POST",url,true);
        // xmlhttp.send();

        })

    $('#lendButton').on('click',function () {
        // sets up event handling for the 'Lend' button click to perform an asynchronous POST request to a server-side script for adding a lend entry
        var command ="lend";
        var bookID = document.getElementById("id-book-to-lend").value;
        var clientID = document.getElementById("id-for-client").value;
        var returnDate = document.getElementById("return-date").value;
        // var url = "handleRequest.php";
        // url = url + "?command=" + command;
        // url = url + "&id=" + bookID;
        // url = url + "&date=" + returnDate;
        console.log(returnDate);
        $.post({
            url: "handleRequest.php",
            data : {command: command,bookID:bookID,clientID:clientID,returnDate:returnDate},
            success:function (data,status) {
                $("#result-lend").html(data);
            },
            error:function(xhr,textStatus, errorThrown){
                alert(errorThrown);
            }
        })

    })

}