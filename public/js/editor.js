// Ajax to edit slim files from editor mode
function updateText() {
    var text = $('#index').val();

    var request = new XMLHttpRequest();
    var newData = new FormData();
    newData.append("text", (text));
    newData.append("id", ('index'));

    request.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            alert(request.responseText);
        };
    };
    request.open("POST", "/editor/textupdate", true);
    request.send(newData);
};


// ajax to get wood from dropdown to inputs
function selectWood(val) {
    var inputs = document.querySelectorAll('.woodForm input');

    var request = new XMLHttpRequest();
    var newData = new FormData();
    newData.append("selectedWood", (val));
    request.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var recievedarray = JSON.parse(request.responseText);
            console.log(recievedarray);
            var i = 0;
            Object.keys(recievedarray).forEach(function(key) {
                inputs[i].value = recievedarray[key];
                i +=  1;
            });

            $(function() {
                $("#woodselect").val("Select wood to compare");
            });

        };
    };
    request.open("POST", "/editor/woodselect", true);
    request.send(newData);
};