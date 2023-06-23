let names = [];
let descriptions = [];
let values = [];


function showChannels(){
    $.get("back.php", { name: $("#name-input").val() },
        function (data, status) {
            $("#channels").html(data);
        });
}

function showSubscriptions(userId){
    $.get("back.php", { userid: userId },
        function (data, status) {
            $("#subscriptions").html(data);
        });
}

function subscribe(userId){
    $.get("back.php", { userid: userId, channel: $("#channel-input").val() },
        function (data, status) {
            $("#subscribe-message").html(data);
        });
}