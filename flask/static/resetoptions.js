/**
 * The reset map function will reset the map and center it, and will also remove any routing options that are currently
 * being displayed. It will also remove any other features displayed on the page, returning it to the state it was in
 * when the user first navigated to the page.
 */


function resetMap() {
    map.setZoom(15);
    map.setCenter(new google.maps.LatLng(53.350140, -6.266155));
    document.getElementById("predictionresetrow").style.display =  'none'; 
	document.getElementById("resetrow").style.display =  'block'; 
    document.getElementById("resetButton").style.visibility = "hidden";
    directionsDisplay.setMap(null);
    LocationWindow.close();
    var element = document.getElementById("myChart");
    if (element != null) {
        element.parentNode.removeChild(element);
    }
    document.getElementById('predictionResults').innerHTML= "";
    document.getElementById("predictionResults").style.display = "None";
    document.getElementById("myPredictionsChart").style.display="None";
    document.getElementById("myPredictionsChartDiv").style.display="None";
    document.getElementById("predictionBox").style.display = "None";
    document.getElementById("base").style.display="block";
    document.getElementById("chart").style.display="none";
    
    map.setZoom(15);
    map.setCenter(new google.maps.LatLng(53.350140, -6.266155));
    document.getElementById("directionsPanel").style.display="none";
}