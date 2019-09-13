/**
 * These three functions handle the toggles on the webpage. The first two will determine what value to set the toggle
 * to after it has been changed, and then will call the main toggle function, which will update the data displayed on
 * the map based on what toggles are selected.
 */

function toggle1Change() {
    var toggle1 = document.getElementById("Toggle1").value;
    var toggle2 = document.getElementById("Toggle2").value;
    if (document.getElementById("Toggle1").value == ">=0") {
        document.getElementById("Toggle1").value = ">0";
        toggle1 = document.getElementById("Toggle1").value;
    } else if (document.getElementById("Toggle1").value == ">0") {
        document.getElementById("Toggle1").value = ">=0";
        toggle1 = document.getElementById("Toggle1").value;
    }
    mainToggleFunction(toggle1, toggle2);
}
function toggle2Change() {
    var toggle1 = document.getElementById("Toggle1").value;
    var toggle2 = document.getElementById("Toggle2").value;
    if (document.getElementById("Toggle2").value == ">=0") {
        document.getElementById("Toggle2").value = ">0";
        toggle2 = document.getElementById("Toggle2").value;
    } else if (document.getElementById("Toggle2").value == ">0") {
        document.getElementById("Toggle2").value = ">=0";
        toggle2 = document.getElementById("Toggle2").value;
    }
    mainToggleFunction(toggle1, toggle2);
}

function mainToggleFunction(toggle1, toggle2) {
    xhttpMark = new XMLHttpRequest();
    xhttpMark.open("POST", "/toggleMarkers", true);
    xhttpMark.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
    xhttpMark.send("toggle1=" + toggle1 + "&toggle2=" + toggle2);
    xhttpMark.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var myStations = JSON.parse(this.responseText);
            deleteMarkers();
            showMarkers(myStations);
        }
    }
}