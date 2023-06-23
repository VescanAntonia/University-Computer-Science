let names = [];
let descriptions = [];
let values = [];

function showWebsites(){
    $.get("back.php", { action: "show-websites" },
        function (data, status) {
            $("#websites-section").html(data);
        });
}

function findDocuments(){
    let keys = $("#keywords-input").val();
    let klist = keys.split(" ");
    //console.log(klist);
    let my_json = JSON.stringify({action: "find-docs", keywords: klist});
    $.post("back.php", my_json,
        function(result){
            $("#documents-section").html(result);
    });
}

function updateKeywords(){
    $.get("back.php", { docid: $("#doc-id-input").val(),
        keyword1: $("#keyword1-input").val(),
        keyword2: $("#keyword2-input").val(),
        keyword3: $("#keyword3-input").val(),
        keyword4: $("#keyword4-input").val(),
        keyword5: $("#keyword5-input").val()
        },
        function (data, status) {
            // $("#doc-id-input").val('');
            // $("#keyword1-input").val('');
            // $("#keyword2-input").val('');
            // $("#keyword3-input").val('');
            // $("#keyword4-input").val('');
            // $("#keyword5-input").val('');
            location.reload();
        });
}

function push(){
    let name = $("#name-input").val();
    let desc = this.document.getElementById("description-input").value;
    let value = this.document.getElementById("value-input").value;
    names.push(name);
    descriptions.push(desc);
    values.push(value);

    $("#name-input").val('');
    //this.document.getElementById("name-input").value = '';
    this.document.getElementById("description-input").value = '';
    this.document.getElementById("value-input").value = '';
    alert("Asset pushed to the list to send");
}

function add(userId){
    let ajax = new XMLHttpRequest();


    ajax.open('POST', 'add.php', true);
    let json = JSON.stringify({'userid':userId,'name': names,'desc':descriptions,'value':values});
    ajax.send(json);

    ajax.onreadystatechange = function () {
        if (this.status === 200) {
            window.location.reload(true);
        }
    }
}