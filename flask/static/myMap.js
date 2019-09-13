//create the map
function myMap() {
    map = new google.maps.Map(document.getElementById('googleMap'), {
        center: new google.maps.LatLng(53.350140, -6.266155),
        zoom: 15,
        styles:
            [
                {
                    "featureType": "administrative",
                    "elementType": "all",
                    "stylers": [
                        {
                            "saturation": "-100"
                        }
                    ]
                },
                {
                    "featureType": "administrative.province",
                    "elementType": "all",
                    "stylers": [
                        {
                            "visibility": "off"
                        }
                    ]
                },
                {
                    "featureType": "landscape",
                    "elementType": "all",
                    "stylers": [
                        {
                            "saturation": -100
                        },
                        {
                            "lightness": 65
                        },
                        {
                            "visibility": "on"
                        }
                    ]
                },
                {
                    "featureType": "poi",
                    "elementType": "all",
                    "stylers": [
                        {
                            "saturation": -100
                        },
                        {
                            "lightness": "50"
                        },
                        {
                            "visibility": "simplified"
                        }
                    ]
                },
                {
                    "featureType": "road",
                    "elementType": "all",
                    "stylers": [
                        {
                            "saturation": "-100"
                        }
                    ]
                },
                {
                    "featureType": "road.highway",
                    "elementType": "all",
                    "stylers": [
                        {
                            "visibility": "simplified"
                        }
                    ]
                },
                {
                    "featureType": "road.arterial",
                    "elementType": "all",
                    "stylers": [
                        {
                            "lightness": "30"
                        }
                    ]
                },
                {
                    "featureType": "road.local",
                    "elementType": "all",
                    "stylers": [
                        {
                            "lightness": "40"
                        }
                    ]
                },
                {
                    "featureType": "transit",
                    "elementType": "all",
                    "stylers": [
                        {
                            "saturation": -100
                        },
                        {
                            "visibility": "simplified"
                        }
                    ]
                },
                {
                    "featureType": "water",
                    "elementType": "geometry",
                    "stylers": [
                        {
                            "hue": "#ffff00"
                        },
                        {
                            "lightness": -25
                        },
                        {
                            "saturation": -97
                        }
                    ]
                },
                {
                    "featureType": "water",
                    "elementType": "labels",
                    "stylers": [
                        {
                            "lightness": -25
                        },
                        {
                            "saturation": -100
                        }
                    ]
                }
            ]
    });
//map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
    markerCluster = new MarkerClusterer(map);
    LocationWindow = new google.maps.InfoWindow;
//To enable the routing mapping
    directionsService = new google.maps.DirectionsService;
    directionsDisplay = new google.maps.DirectionsRenderer;
//markers
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("POST", "/markers", true);
    xmlhttp.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
    xmlhttp.send();
    xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var stations = JSON.parse(this.responseText);
            showMarkers(stations);
//Only show this button when the map has loaded
            document.getElementById("mylocation").style.visibility="visible";
        }
    }

}



// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markersArray[i].setMap(null);
    }
    markersArray = [];
}


//create the markers for the map
function showMarkers(stations) {
//creates an array of markers
    markers = stations.map(function (location, i) {
        var latLng = new google.maps.LatLng(stations[i][3], stations[i][4]);
        if (stations[i][7] == 'CLOSED') {
            var iconType = {
                url: '/static/images/redIcon.png',
                scaledSize: new google.maps.Size(25, 40), // scaled size
                origin: new google.maps.Point(0, 0), // origin
                anchor: new google.maps.Point(0, 0)
            } // anchor}
        } else if (stations[i][7] == 'OPEN' && stations[i][5] > 0) {
            var iconType = {
                url: '/static/images/greenIcon.png',
                scaledSize: new google.maps.Size(25, 40), // scaled size
                origin: new google.maps.Point(0, 0), // origin
                anchor: new google.maps.Point(0, 0) // anchor
            }
        } else if (stations[i][5] == 0){
            var iconType = {
                url: '/static/images/greenIconNO.png',
                scaledSize: new google.maps.Size(25, 40), // scaled size
                origin: new google.maps.Point(0, 0), // origin
                anchor: new google.maps.Point(0, 0)
            }
        } // anchor}
//if (stations[i][5]>0){var labelSet="B";}else{var labelSet="";}
        var marker = new google.maps.Marker({
            position: latLng,
            title: stations[i][1],
//label: labelSet,
            icon: iconType
        });
        addcontents(marker, stations[i][1], stations[i][2], stations[i][6]);
        markersArray.push(marker);
        markerCluster.clearMarkers();
        markerCluster.addMarkers(markersArray);
        return marker;
    });
}

//sets functionality to marker so that when clicked it displays the clicked markers info in the infoWindow and displays the graph below the map.
function addcontents(marker, name, address, banking) {
    marker.addListener('click', function () {
        if (flag == true) {
            directionsDisplay.setMap(null);
            document.getElementById("directionsPanel").innerHTML = "";
            flag = false;
        }
        xhttp = new XMLHttpRequest();
        xhttp2 = new XMLHttpRequest();
        xhttp.open("POST", "/getMarkerData", true);
        xhttp.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
        xhttp.send("name=" + name);
        xhttp2.open("POST", "/histData", true);
        xhttp2.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
        xhttp2.send("name=" + name);
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                //the next two lines will get the response from the flask db query
                //and then split it using '/' as the key, which is added in to the
                //returned string that flask passes back in. This allows us to
                //create a new line before each new piece of data
                var flaskJsonReturn = this.responseText;
                var flaskJsonArray = flaskJsonReturn.split("#");
                lastMarkerClicked = flaskJsonArray[1];
                var stationName = lowerCaseMe(flaskJsonArray[1]);
                var lastUpdate = dateFns.parse(flaskJsonArray[6]);
                var result = dateFns.distanceInWordsToNow(lastUpdate, {includeSeconds: true});
                if (banking == "1") {
                    banking = 'Yes';
                } else {
                    banking = 'No';
                }
                LocationWindow.setContent(
                    stationName + "<br />" +
                    flaskJsonArray[2] + "<br />" +
                    flaskJsonArray[3] + "<br />" +
                    flaskJsonArray[4] + "<br />" +
                    lowerCaseMe(flaskJsonArray[5]) + "<br>" +
                    'Credit Cards Accepted: ' + banking + "<br />" + "<br />" +
                    "This data was updated " + result + " ago");
                LocationWindow.open(marker.get('map'), marker);
            }
        };
        xhttp2.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                var flaskJsonReturn = JSON.parse(this.responseText);
                window.scrollTo(0,400);
                makeChart(flaskJsonReturn, 'mean')
            }
        };
    });
}

//centers on user location


function getLatLngFromString(location) {
    var latlang = location.replace(/[()]/g,'');
    var latlng = latlang.split(',');
    //console.log(latlang);
    var locate = new google.maps.LatLng(parseFloat(latlng[0]) , parseFloat(latlng[1]));
    return locate;
}




function selectStation(value, flag) {
    xhttpStation = new XMLHttpRequest();
    xhttpStation.open("POST", "/stationLoc", true);
    xhttpStation.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
    xhttpStation.send("name="+value);
    var googleLoc= xhttpStation.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var stationLoc = this.responseText;
            var googleLoc = getLatLngFromString(stationLoc);
            map.setCenter(googleLoc);
            map.setZoom(18);
        }
        return googleLoc;
    };
    if (flag == null) {
        xhttpStation2 = new XMLHttpRequest();
        xhttpStation2.open("POST", "/histData", true);
        xhttpStation2.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
        xhttpStation2.send("name=" + value);
        xhttpStation2.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var charData = JSON.parse(this.responseText);
                makeChart(charData, 'selectstation')
            }
        };
        
    }
}

