function updatePosts(username){
    $.get("back.php", {username:username, postid: $("#post-id-input").val(),
        topicid: $("#topicId-input").val(),
        text: $("#text-input").val()
        },
        function (data, status) {
            $("#post-id-input").val('');
            $("#topicId-input").val('');
            $("#text-input").val('');
            // $("#keyword3-input").val('');
            // $("#keyword4-input").val('');
            // $("#keyword5-input").val('');
            location.reload();
        });
}

function addPost(username){
    $.post("back.php", { username: username,
    topicname: $("#topicname-input").val(),
    text: $("#textInput").val()
        },
        function (data, status) {
            $("#added-message").html(data);
        });
}