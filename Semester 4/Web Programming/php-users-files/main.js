
$(document).ready(function(){
    $.get("back.php", { action: "get-files", userid:  userid},
        function (data, status) {
            $("#user-files").html(data);

            $('#data').after('<div id="nav"></div>');
            let rowsShown = 5;
            let rowsTotal = $('#data tbody tr').length;
            let numPages = rowsTotal/rowsShown;
            for(i = 0;i < numPages;i++) {
                let pageNum = i + 1;
                $('#nav').append('<a href="#" rel="'+i+'">'+pageNum+'</a> ');
            }
            $('#data tbody tr').hide();
            $('#data tbody tr').slice(0, rowsShown).show();
            $('#nav a:first').addClass('active');
            $('#nav a').bind('click', function(){

                $('#nav a').removeClass('active');
                $(this).addClass('active');
                let currPage = $(this).attr('rel');
                let startItem = currPage * rowsShown;
                let endItem = startItem + rowsShown;
                $('#data tbody tr').css('opacity','0.0').hide().slice(startItem, endItem).
                css('display','table-row').animate({opacity:1}, 300);
            });
        });

});

function showMostPopularFile(){
    let names = []
    let table = document.getElementById('data');
    for (let r = 0, n = table.rows.length; r < n; r++)
            names.push(table.rows[r].cells[2].innerHTML);
    let highestOccurrence = names.sort((a,b) =>
        names.filter(v => v===a).length - names.filter(v => v===b).length
    ).pop();
    $("#popular-file").html(highestOccurrence);
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