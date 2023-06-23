let userids = [];
let titles = [];
let descriptions = [];
let urls = [];

function addContent(username){
    $.post("back.php", { username: username,title: $("#title-input").val(),
        description: $("#description-input").val(),url: $("#url-input").val()
        },
        function (data, status) {
            $("#added-message").html(data);
            $("#title-input").val('');
            $("#description-input").val('');
            $("#url-input").val('');
        });
}

function push(){
    let title = this.document.getElementById("title-input").value;
    let description = this.document.getElementById("description-input").value;
    let url = this.document.getElementById("url-input").value;
    titles.push(title);
    descriptions.push(description);
    urls.push(url);

    
    //this.document.getElementById("name-input").value = '';
    this.document.getElementById("title-input").value = '';
    this.document.getElementById("description-input").value = '';
    this.document.getElementById("url-input").value = '';
    alert("Content pushed to the list to send");
}


function add(userId){
    let ajax = new XMLHttpRequest();


    ajax.open('POST', 'add.php', true);
    let json = JSON.stringify({'userid':userId,'title': titles,'description':descriptions,'url':urls});
    ajax.send(json);

    ajax.onreadystatechange = function () {
        if (this.status === 200) {
            window.location.reload(true);
        }
    }
    alert("Content submitted to the table");
}

function getNewContent(){
        location.reload();
    
}