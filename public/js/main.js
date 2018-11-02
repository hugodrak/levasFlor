function toTop()
{
    $("html, body").animate({ scrollTop: 0 }, "slow");
    return false;
}

$(window).on('scroll', function ()
{
    if ($(window).width() <= 700 && $('.opening').height() != null)
    {
        if ($(window).scrollTop() <= $('.opening').height()-1)
        {
            // Here the opening is still viewed

            $('.content').css('top', '-40vh');
            $('.content').css('position', 'relative');
            $('.sidenav').css('position', 'relative');

            $('.nav_desktop').css('position', 'static');
            $('.sidenav').css('top', '0');

        }
        else
        {
            // Here the opening is hidden

            $('.content').css('top', '8vh');
            $('.content').css('position', 'relative');

            $('.sidenav').css('position', 'fixed');
            $('.sidenav').css('top', '8vh');
            $('.nav_desktop').css('position', 'fixed');

        }
    }

});

$(document).ready(function(){

    if ($('.opening').height() != null) {
        $('.nav_desktop').css('position', 'static');

    }

    if(document.body.scrollHeight < document.documentElement.clientHeight+320){
        var footer = document.querySelector(".footer");
        footer.style.position = "fixed";
        footer.style.bottom = 0

    }

    // if(new Date().getHours() >= 17){
    //     $("section.opening").css("background", "#fff url('../img/opening1.jpg') center center");
    // }
    // else{
    //     $("section.opening").css("background", "#fff url('../img/opening1.jpg') center center");
    //
    // };
});


function compareWood(woodselect) {
    var request = new XMLHttpRequest();
    var newData = new FormData();
    newData.append("selectedWood", (woodselect.value));
    request.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var recievedarray = JSON.parse(request.responseText);
            var i;
            var tableRows = document.querySelectorAll('#wood_table tr');
            // console.log(tableRows);
            for (i = 0; i < tableRows.length; i++) {
                var row = tableRows[i]
                row.innerHTML += "<td>" + recievedarray[i] + "</td>"
            };

            $(function() {
                $("#woodselect").val("Select wood to compare");
            });

        };
    };
    request.open("POST", "/woodselect", true);
    request.send(newData);
};

function toggleNav()
{
    thing = document.querySelector(".sidenav");
    console.log(thing.style.width)
    if (thing.style.width == "70%")
    {
        thing.style.width = "0px";
    }
    else
    {
        thing.style.width = "70%";
    }
}
