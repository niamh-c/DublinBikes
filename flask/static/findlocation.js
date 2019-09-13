/**
 * The Fund Location function will find the nearest Dublin Bikes station to your current location and will provide
 * walking directions to that station. It uses the Google Maps API.
 *
 */


function FindLocation() {
    document.getElementById('predictionResults').innerHTML= "";
    var element = document.getElementById("myChart");
    if (element != null) {
        element.parentNode.removeChild(element);
    }
    directionsDisplay.setMap(map);

    document.getElementById('directionsPanel').style.display = "block";
    document.getElementById("predictionResults").style.display = "None";
    document.getElementById("myPredictionsChart").style.display="None";
    document.getElementById("myPredictionsChart").style.display="None";
    document.getElementById("predictionresetrow").style.display =  'none'; 
	document.getElementById("resetrow").style.display =  'block'; 
    document.getElementById("predictionBox").style.display = "None";
    document.getElementById("base").style.display="none";
    document.getElementById("chart").style.display="none";
    document.getElementById("resetButton").style.visibility = "visible";
    directionsDisplay.setPanel(document.getElementById('directionsPanel'));
    flag = true;
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            nearestLoc(pos);
            map.setCenter(pos);
        }, function () {
            handleLocationError(true, LocationWindow, map.getCenter());
        });
    } else {
        // Browser doesn't support Geolocation
        handleLocationError(false, LocationWindow, map.getCenter());
    }
    function handleLocationError(browserHasGeolocation, LocationWindow, pos) {
        LocationWindow.setPosition(pos);
        LocationWindow.setContent(browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.');
        LocationWindow.open(map);
    }
    //Find the station nearest your current location
    function nearestLoc(pos) {
        var location = pos;
        var val = markers.reduce(function (prev, curr) {
            var cpos = google.maps.geometry.spherical.computeDistanceBetween(location, curr.position);
            var ppos = google.maps.geometry.spherical.computeDistanceBetween(location, prev.position);
            return cpos < ppos ? curr : prev;
        });
        function calculateAndDisplayRoute(directionsService, directionsDisplay, location, val) {
            directionsService.route({
                origin: location,
                destination: val.position,
                travelMode: 'WALKING',
                unitSystem: google.maps.UnitSystem.METRIC
            }, function (response, status) {
                if (status === 'OK') {
                    directionsDisplay.setDirections(response);
                    return response;
                } else {
                    window.alert('Directions request failed due to ' + status);
                }
            });
        }
        calculateAndDisplayRoute(directionsService, directionsDisplay, location, val);
        name = "The nearest station to your current location is " + lowerCaseMe(val.title) + ".";
        if (document.getElementById("stationName")!=null){
            document.getElementById("stationName").innerHTML = name;}
    }
}