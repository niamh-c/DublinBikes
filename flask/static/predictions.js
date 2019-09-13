/**
 * These prediction functions all play a role in displaying the predicted number of bikes for the station and time
 * selected. The Build Prediction function will set up the form for the user to choose options to predict with, such as station,
 * time, and date. The callPrediction funciton will clean the data and pass it to the Flask application which will
 * determine the correct model to use and deal with the data before passing it back to the function. Based on the result,
 * the function will determine how to display the bar chart.
 */

function buildPrediction() {
	document.getElementById("predictionresetrow").style.display =  'none'; 
	document.getElementById("resetrow").style.display =  'block'; 
    var date = new Date();
    if (flag == true) {
        directionsDisplay.setMap(null);
        document.getElementById("directionsPanel").innerHTML = "";
        flag = false;
        map.setCenter(new google.maps.LatLng(53.350140, -6.266155));
        map.setZoom(15);
    }
    var element = document.getElementById("myChart");
    if (element != null) {
        element.parentNode.removeChild(element);
    }
    document.getElementById("myPredictionsChartDiv").style.display="None";
    document.getElementById('predictionResults').innerHTML= "";
    document.getElementById("predictionResults").style.display = "None";
    document.getElementById("myPredictionsChart").style.display="None";
    document.getElementById("predictionBox").style.display="block";
    document.getElementById("base").style.display="none";
    document.getElementById("chart").style.display="none";
    document.getElementById("resetButton").style.visibility = "visible";
    calendarBuilder();
}

function callPrediction() {
    document.getElementById("predictionBox").style.display = "none";
    var station = document.getElementById("stations2").value;
    var flag = "false";
    selectStation(station, flag);
    var date = document.getElementById("dateField").value;
    var time = document.getElementById("timepicker").value;
    if (time == "00:00") {
	    finalTime = "0";
    }
    else{
        function timeConverter(time) {
                var PM = time.match('pm') ? true : false

                time = time.split(':')
                var min = time[1]

                if (PM) {
                    var hour = 12 + parseInt(time[0], 10)
                    console.log(hour);
                    console.log('PM');
                } else {
                	if (parseInt(time[0], 10)==0){
                		var hour = "";
                	}
                	else{
                		var hour = parseInt(time[0], 10).toString();
                	}
                }
                min = (Math.round(min/15) * 15) % 60;
                if (min==0){
                min='0'+min.toString();}
                else {min=min.toString();}
                min = min.replace(/\D/g, '');
            return (hour+ min)
        }

        var finalTime = timeConverter(time);
    } 
    
    predictReq = new XMLHttpRequest();
    predictReq.open("POST", "/predictions", true);
    predictReq.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
    predictReq.send("name=" + station + "&date=" + date + "&time=" + finalTime);
    predictReq.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            try {
                var result = JSON.parse(this.responseText);
                document.getElementById('predictionResults').style.display = "block";
                document.getElementById('myPredictionsChartDiv').style.display = "block";
                document.getElementById('predictionBox').style.display = "none";
                document.getElementById("base").style.display = "none";
                document.getElementById("chart").style.display = "none";
                document.getElementById("directionsPanel").style.display = "none";
                document.getElementById("resetButton").style.visibility = "visible";
                document.getElementById('predictionResults').innerHTML = "<div style='test-align: center; margin:20px;'><p class='header' style = \"color: black; margin-bottom:0px; padding: 20px\"><b>Station:</b> " +
                    station + "<br>There will be approximately " + result[2][(finalTime)] + " bikes at " + time + ".</p>\n";
                makeChart(result, 'prediction');
            }
            catch (err) {
                var result = this.responseText;
                if (result == "NONESTATION") {
                    document.getElementById('predictionResults').style.display = "block";
                    document.getElementById("resetButton").style.visibility = "visible";
                    document.getElementById('predictionResults').innerHTML = "<h1 style = \"color: white;\">" +
                        "Sorry, you did not choose a station! Try again. </h1>\n" +
                        "<br><br>" +
                        "<button id=\"resetPredict\" onclick=\"buildPrediction()\">Make Another Prediction</button>"
                } else if (result == "NONETIME") {
                    document.getElementById('predictionResults').style.display = "block";
                    document.getElementById("resetButton").style.visibility = "visible";
                    document.getElementById('predictionResults').innerHTML = "<h1 style = \"color: white;\">" +
                        "Sorry, you did not choose a time! Try again. </h1>\n" +
                        "<br><br>" +
                        "<button id=\"resetPredict\" onclick=\"buildPrediction()\">Make Another Prediction</button>"
                }
            }
        }
    }
}


var currentDate = new Date();
var endDate = new Date();
var numberOfDaysToAdd = 4;
currentDate.setDate(currentDate.getDate() + 1);
endDate.setDate(currentDate.getDate() + numberOfDaysToAdd);

function calendarBuilder() {
    $('input[name="daterange"]').daterangepicker({
        singleDatePicker: true,
        showDropdowns: true,
        minDate: currentDate,
        maxDate: endDate
    })}