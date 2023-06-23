let names = [];
let descriptions = [];
let values = [];

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