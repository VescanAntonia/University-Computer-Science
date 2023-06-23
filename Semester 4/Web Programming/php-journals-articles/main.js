let names = [];
let descriptions = [];
let values = [];


function showArticles(username){
    $.get("back.php", { username: username,journal: $("#journal-input").val() },
        function (data, status) {
            $("#articles").html(data);
        });
}

function addArticle(username){
    $.post("back.php", { username: username,journalname: $("#journal-name-input").val(),
        summary: $("#summary-input").val()
        },
        function (data, status) {
            $("#added-message").html(data);
        });
}

// function showSubscriptions(userId){
//     $.get("back.php", { userid: userId },
//         function (data, status) {
//             $("#subscriptions").html(data);
//         });
// }

// function subscribe(userId){
//     $.get("back.php", { userid: userId, channel: $("#channel-input").val() },
//         function (data, status) {
//             $("#subscribe-message").html(data);
//         });
// }