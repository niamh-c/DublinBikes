/**
 * The function Make Chart will draw a jQuery chart with mean hourly bikes available data stretching back to February.
 * It takes the parameter myData which is a list of 3 lists. The first list will contain the times to populate the
 * X axis of the graph with. The bike data is the second list, and the 3rd value is the max number of bikes for this
 * station, which is set as the max height of the bar graph.
 *
 */


function makeChart(myData, chart) {
    var times = myData[0];
    var data = myData[1];
    if (chart=="prediction"){
    	var element = document.getElementById("myPredictionsChart");
    }
    else{
    	document.getElementById("myPredictionsChartDiv").style.display="None";
    	document.getElementById('directionsPanel').style.display = "None";
	    document.getElementById("predictionResults").style.display = "None";
	    document.getElementById("myPredictionsChart").style.display="None";
	    document.getElementById("predictionBox").style.display = "None";
	    document.getElementById("base").style.display="none";
	    document.getElementById("chart").style.display="Block";
	    document.getElementById("resetButton").style.visibility = "visible";
	    var max_bikes = myData[2];
	    var element = document.getElementById("myChart");
    }
    
    /* Delete canvas by id to prevent barcharts from stacking on top of each other */
    
    if (element != null) {
        element.parentNode.removeChild(element);
    }
    
    if (chart=="prediction"){
    	 +

         "<button style='margin-top: 2px; margin-left: 15%; color: #0f798a;' id=\"resetPredict\" onclick=\"buildPrediction()\"><b>Make Another Prediction</b></button></div>";
    	 
    	 
    	document.getElementById("predictionresetrow").style.display =  'block'; 
    	document.getElementById("resetrow").style.display =  'none'; 
    	document.getElementById("myPredictionsChartDiv").innerHTML =  '<canvas id="myPredictionsChart"></canvas>';
    	var ctx = document.getElementById('myPredictionsChart').getContext('2d');
        var myBarChart = new Chart(ctx, {
            // The type of chart we want to create
            type: 'bar',

            // The data for our dataset
            data: {
                labels: times,
                datasets: [{
                    label: 'Bikes Available',
                    fontColor:"white",
                    data: data,
                    backgroundColor: "rgb(3, 169, 244)",
                    borderColor: 'rgb(51, 0, 0)',
                    hoverBorderColor: "white",
                }]
            },

            // Configuration options go here
            options: {
                title: {
                    display: true,
                    text: "Predicted Bikes Available Per Hour",
                    fontSize: 15,
                    fontColor: "white"
                },
                scales: {
                    xAxes: [{
                    	
                        ticks: {
                            fontColor: "white"
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            fontColor:"white",
                        }
                    }]
                }
            }
        });
        
    }
    else{
    /* Create a new canvas to put new barchart on */
    document.getElementById("myChartDiv").innerHTML =  '<canvas id="myChart"></canvas>';

    var ctx = document.getElementById('myChart').getContext('2d');

    var myBarChart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'bar',

        // The data for our dataset
        data: {
            labels: times,
            datasets: [{
                label: 'Bikes Available',
                fontColor:"white",
                data: data,
                backgroundColor: "rgb(3, 169, 244)",
                borderColor: 'rgb(51, 0, 0)',
                hoverBorderColor: "white",
            }]
        },

        // Configuration options go here
        options: {
            title: {
                display: true,
                text: "Average Bikes Available Per Hour",
                fontSize: 15,
                fontColor: "white"
            },
            scales: {
                xAxes: [{
                    ticks: {
                        fontColor: "white"
                    }
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        fontColor:"white",
                        max: max_bikes
                    }
                }]
            }
        }
    });
    }
}