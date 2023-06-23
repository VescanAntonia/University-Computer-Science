function showParticipants(){
    $.get("back.php", {course: $("#course-input").val() },
        function (data, status) {
            $("#participants").html(data);
        });
}

function showCourses(){
    $.get("back.php", {student: $("#student-input").val() },
        function (data, status) {
            $("#courses").html(data);
        });
}

function addGrade(userId){
    $.get("back.php", { userId: userId,
    coursename: $("#coursename-input").val(),
    studentname: $("#studentname-input").val(),
    grade:$("#grade-input").val()
        },
        function (data, status) {
            $("#added-message").html(data);
        });
}